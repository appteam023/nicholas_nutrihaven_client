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
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
    CustomLoadingWidget(
      isLoading: val,
    );
  }
}
