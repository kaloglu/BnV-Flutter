import 'package:BedavaNeVar/constants/constants.dart';

import 'custom_buttons.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    super.key,
    required String text,
    bool loading = false,
    VoidCallback? onPressed,
  }) : super(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          textColor: Colors.black87,
          loading: loading,
          onPressed: onPressed,
        );
}
