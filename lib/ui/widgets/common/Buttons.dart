import 'package:BedavaNeVar/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

export 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(FontAwesomeIcons.signOutAlt),
        tooltip: Strings.logout,
        onPressed: onPressed,
      );
}

class SortButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SortButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(FontAwesomeIcons.sortAmountDownAlt),
        tooltip: Strings.sortingTooltip,
        onPressed: onPressed,
      );
}

class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(FontAwesomeIcons.search),
        tooltip: Strings.sortingTooltip,
        onPressed: onPressed,
      );
}
