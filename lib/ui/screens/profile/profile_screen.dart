import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_viewmodel.dart';
import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_page.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends HookConsumerWidget {
  static final route = "/profile";

  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  ProfileScreen({super.key});

  ProfileScreen.navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(signInModelProvider);
    final authState = ref.watch(authStateProvider);
    return authState.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(appBar: AppBar(title: const Text('Profil')), body: Center(child: Text('Hata: $e'))),
      data: (user) {
        if (user == null) return const SignInPage();
        final title = user.fullname?.isNotEmpty == true ? user.fullname! : (user.email ?? 'Profil');
        return Scaffold(
          appBar: AppBar(
            title: Text('Profil: $title'),
            actions: [LogoutButton(onPressed: () async { await authViewModel.signOut(); })],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('E-posta: ${user.email ?? '-'}'),
            ]),
          ),
        );
      },
    );
  }
}
