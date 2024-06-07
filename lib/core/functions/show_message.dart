import 'package:flutter_easyloading/flutter_easyloading.dart';

showErrorMessage(message, {int seconds = 2}) {
  EasyLoading.showError(message,
      dismissOnTap: true, duration: Duration(seconds: seconds));
}

showSuccessMessage(message, {bool dismiss = true}) {
  EasyLoading.showSuccess(
    message,
    dismissOnTap: dismiss,
  );
}
