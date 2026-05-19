

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Helpers/get_storage_helper.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';

import '../../../Config/session_manager.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_snackbar.dart';
import '../../../Widgets/loader_widget.dart';
import '../controller/workout_plan_controller.dart';
import '../group_details_view/group_details_view.dart';

class RepWeightsSettingView extends StatelessWidget {
  const RepWeightsSettingView({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      builder: (controller) => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: secondary,
          appBar: CustomAppBar(
            title: "Edit Exercise Sets & Weight",
          ),
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Edit your sets and weights to use globally",
                    style: context.labelMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: darkTheme
                    ),
                  ),
                ),
                Divider(color: grey),
                const SizedBox(height: 20,),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.only(
                    left: horizontalPadding * 1.2,
                    top: 14,
                    bottom: 14,
                    right: 10
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: grey.withValues(alpha: 0.5)
                    ),
                    // color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showPicker(context, controller.globalReps.value, (value) {
                            controller.globalReps.value = value;
                            controller.update();
                          });
                        },
                        child:  Row(
                          children: [
                            Text(
                              "${controller.globalReps} Reps  ",
                              style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                      ),
                      Text(
                        "  /  ",
                        style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                      ),
                      InkWell(
                        onTap: () {
                          showPicker(context, controller.globalWeight.value, (value) {
                            controller.globalWeight.value = value;
                            controller.update();
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              "${controller.globalWeight.value} ${AppSessionManager().getUserData?.memberWeightUnit}  ",
                              style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: CustomButton(
              margin: EdgeInsets.symmetric(horizontal: 20),
              title: "Save",
              onTap: () async {
                try {
                  await saveReps(reps: controller.globalReps.value);
                  await saveWeights(weight: controller.globalWeight.value);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(
                        message: "Success 👏, Setting saved successfully",
                      ),
                    );
                  }
                  Get.back();

                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void showPicker(BuildContext context, int selectedNumber, Function(int) onChange) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select",
                      style: context.labelLarge?.copyWith(),
                    ),
                  ),
                  CupertinoButton(
                    child: Text("Done"),
                    onPressed: () {
                      onChange(selectedNumber);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedNumber,
                  ),
                  onSelectedItemChanged: (index) {
                    selectedNumber = index;
                  },
                  children: List.generate(101, (index) {
                    return Center(child: Text(index.toString()));
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showBottomSheet(BuildContext context, List<Widget> options) {
    showModalBottomSheet<void>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 300),
      ),
      builder: (BuildContext context) {
        return CustomOptionsBottomSheet(
            options: options
        );
      },
    );
  }

}
