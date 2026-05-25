import 'package:BedavaNeVar/models/user/user.dart' as UserModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool loginState = false;

  // Web için telefon doğrulamada kullanılacak
  ConfirmationResult? _webConfirmationResult;

  get auth => _auth;

  // Stream<User?>: Çıkışta null yayınla ki UI giriş ekranına dönebilsin
  Stream<UserModel.User?> get authState async* {
    await for (var user in _auth.authStateChanges()) {
      final currentLoginState = user != null;
      if (loginState != currentLoginState) {
        loginState = currentLoginState;
      }
      yield user != null ? UserModel.User.userFromSocialAuth(user) : null;
    }
  }

  UserModel.User getUser() {
    var firebaseUser = _auth.currentUser;
    return UserModel.User.userFromSocialAuth(firebaseUser);
  }

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        await _auth.signInWithPopup(GoogleAuthProvider());
        return;
      }
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Kullanıcı işlemi iptal etti');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Google Auth Token eksik');
      }

      await _auth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
      );
    } catch (e) {
      debugPrint('Google ile giriş sırasında hata: $e');
      rethrow;
    }
  }

  Future<void> signInWithTwitter() async {
    try {
      final twitterProvider = TwitterAuthProvider();
      if (kIsWeb) {
        await _auth.signInWithPopup(twitterProvider);
      } else {
        await _auth.signInWithProvider(twitterProvider);
      }
    } catch (e) {
      debugPrint('Twitter ile giriş sırasında hata: $e');
      rethrow;
    }
  }

  Future<void> signInWithEmail(String username, String password) {
    throw UnimplementedError();
  }

  // Genel signOut: Firebase oturumunu kapatır, gerekiyorsa Google oturumunu da sonlandırır
  Future<void> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
    } catch (e) {
      debugPrint('Google signOut sırasında hata: $e');
    } finally {
      try {
        await _auth.signOut();
      } catch (e) {
        debugPrint('Firebase signOut sırasında hata: $e');
        rethrow;
      }
    }
  }

  // Geriye dönük kullanım için mevcut metodu genel signOut'a yönlendir
  Future<void> signOutWithGoogle() async => signOut();

  // Telefon ile giriş — başlatma: verificationId döndürür (mobilde). Web'de sembolik değer döner.
  Future<String> startPhoneVerification(String phoneNumber) async {
    if (kIsWeb) {
      try {
        // reCAPTCHA doğrulayıcıyı başlat (varsayılan görünüm). Gerekirse görünmez moda alınabilir.
        final verifier = RecaptchaVerifier(
          auth: FirebaseAuthPlatform.instance,
          container: 'recaptcha-container',
          onError: (e) => debugPrint('reCAPTCHA hata: $e'),
          onSuccess: () => debugPrint('reCAPTCHA başarıyla doğrulandı'),
          onExpired: () => debugPrint('reCAPTCHA süresi doldu'),
        );
        _webConfirmationResult = await _auth.signInWithPhoneNumber(phoneNumber, verifier);
        debugPrint('Web phone sign-in başlatıldı (reCAPTCHA tamam).');
        // Web akışında verificationId kavramı yok; UI tarafında sadece confirmSmsCodeWeb çağrılır
        return 'WEB_CONFIRMATION';
      } catch (e) {
        debugPrint('Web phone sign-in hata: $e');
        rethrow;
      }
    }

    final completer = Completer<String>();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _auth.signInWithCredential(credential);
          if (!completer.isCompleted) completer.complete('AUTO_VERIFIED');
        } catch (e) {
          debugPrint('verificationCompleted sırasında hata: $e');
          if (!completer.isCompleted) completer.completeError(e);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('verifyPhoneNumber başarısız: ${e.code} ${e.message}');
        if (!completer.isCompleted) completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('Kod gönderildi. verificationId: $verificationId');
        if (!completer.isCompleted) completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Kod otomatik zaman aşımı. verificationId: $verificationId');
        if (!completer.isCompleted) completer.complete(verificationId);
      },
      timeout: const Duration(seconds: 60),
    );

    return completer.future;
  }

  Future<void> confirmSmsCode(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(credential);
  }

  Future<void> confirmSmsCodeWeb(String smsCode) async {
    final result = _webConfirmationResult;
    if (result == null) {
      throw PlatformException(code: 'WEB_CONFIRMATION_MISSING', message: 'Web doğrulama başlatılmamış.');
    }
    await result.confirm(smsCode);
  }
}
