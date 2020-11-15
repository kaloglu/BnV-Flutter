import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key key,
    @required this.signedInBuilder,
    @required this.nonSignedInBuilder,
  }) : super(key: key);
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateProvider);
    return authStateChanges.when(
      data: (user) => _data(context, user),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load data right now.',
        ),
      ),
    );
  }

  Widget _data(BuildContext context, User user) {
    if (user != null) {
      return signedInBuilder(context);
    }
    return nonSignedInBuilder(context);
  }
}
