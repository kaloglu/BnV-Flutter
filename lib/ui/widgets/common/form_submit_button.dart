import 'package:BedavaNeVar/constants/constants.dart';

import 'custom_buttons.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    super.key,
    required String text,
    bool loading = false,
    VoidCallback? onPressed,
  }) : super(
          child: Text(text),
          height: 44.0,
          loading: loading,
          onPressed: onPressed,
        );
}
