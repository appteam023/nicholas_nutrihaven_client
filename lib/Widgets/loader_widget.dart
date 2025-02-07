import 'package:get/get.dart';
import 'custom_loader_widget.dart';

showLoader(bool val) {
  if (val) {
    Get.dialog(CustomLoadingWidget(
      isLoading: val,
    ));
    print("true----${val}");
  } else {
    print("false----${val}");
    Get.back();
    CustomLoadingWidget(
      isLoading: val,
    );
  }
}
