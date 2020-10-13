import 'package:BedavaNeVar/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

export 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SortButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SortButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

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
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(FontAwesomeIcons.search),
        tooltip: Strings.sortingTooltip,
        onPressed: onPressed,
      );
}
