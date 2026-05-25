import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhoneSignInSheet extends HookConsumerWidget {
  const PhoneSignInSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authServiceProvider);

    final phoneController = TextEditingController(text: '+90');
    final codeController = TextEditingController();

    // Basit yerel durumlar
    final ValueNotifier<bool> isSending = ValueNotifier(false);
    final ValueNotifier<bool> codeSent = ValueNotifier(false);
    final ValueNotifier<String?> verificationId = ValueNotifier<String?>(null);
    final ValueNotifier<String?> errorText = ValueNotifier<String?>(null);

    Future<void> startVerification() async {
      FocusScope.of(context).unfocus();
      errorText.value = null;
      isSending.value = true;
      try {
        final phone = phoneController.text.trim();
        if (phone.isEmpty || !phone.startsWith('+')) {
          errorText.value = 'Lütfen ülke kodu ile birlikte geçerli bir telefon girin (örn. +90...)';
          return;
        }
        final String vid = await auth.startPhoneVerification(phone);
        verificationId.value = vid;
        codeSent.value = true;
      } catch (e) {
        debugPrint('Telefon doğrulama başlatılamadı: $e');
        errorText.value = 'Doğrulama başlatılamadı: $e';
      } finally {
        isSending.value = false;
      }
    }

    Future<void> confirmCode() async {
      FocusScope.of(context).unfocus();
      errorText.value = null;
      isSending.value = true;
      try {
        final code = codeController.text.trim();
        if (code.length < 4) {
          errorText.value = 'Lütfen SMS ile gelen doğrulama kodunu girin';
          return;
        }
        if (kIsWeb) {
          await auth.confirmSmsCodeWeb(code);
        } else {
          final vid = verificationId.value;
          if (vid == null) {
            errorText.value = 'Doğrulama kimliği bulunamadı. Lütfen tekrar deneyin.';
            return;
          }
          await auth.confirmSmsCode(vid, code);
        }
        if (context.mounted) Navigator.of(context).pop();
      } catch (e) {
        debugPrint('Kod doğrulama başarısız: $e');
        errorText.value = 'Kod doğrulanamadı: $e';
      } finally {
        isSending.value = false;
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Telefon ile Giriş', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<String?>(
              valueListenable: errorText,
              builder: (_, err, __) => err == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(err, style: const TextStyle(color: Colors.redAccent)),
                    ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: codeSent,
              builder: (_, sent, __) {
                if (!sent) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Telefon Numarası',
                          hintText: '+90 5xx xxx xx xx',
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<bool>(
                        valueListenable: isSending,
                        builder: (_, loading, __) => ElevatedButton.icon(
                          onPressed: loading ? null : startVerification,
                          icon: loading
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.sms),
                          label: const Text('SMS Gönder'),
                        ),
                      ),
                      if (kIsWeb)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Not: Web önizlemede reCAPTCHA açılabilir. Eğer engellenirse tarayıcıda pop-up izinlerini kontrol edin.',
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'SMS Kodu',
                          hintText: '123456',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<bool>(
                        valueListenable: isSending,
                        builder: (_, loading, __) => ElevatedButton.icon(
                          onPressed: loading ? null : confirmCode,
                          icon: loading
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.verified),
                          label: const Text('Doğrula ve Giriş Yap'),
                        ),
                      ),
                      TextButton(
                        onPressed: () => codeSent.value = false,
                        child: const Text('Numarayı Değiştir'),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
