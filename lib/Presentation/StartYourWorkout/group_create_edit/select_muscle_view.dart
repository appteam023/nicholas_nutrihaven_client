

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Data/DataSources/remote/api_constant.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Utils/Extensions/text_extension.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/image_widget.dart';
import '../../../Widgets/loader_widget.dart';
import '../controller/workout_plan_controller.dart';

class SelectMuscleView extends StatelessWidget {
  const SelectMuscleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      init: Get.find<WorkoutPlanController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.fetchMuscles();
        });
      },
      builder: (controller) {
        return CustomLoader(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: secondary,
            appBar: CustomAppBar(
              title: "Select Muscles",
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollUpdateNotification) {
                      if (scrollInfo.metrics.axis == Axis.vertical) { //
                        if (scrollInfo.metrics.atEdge) {
                          if (scrollInfo.metrics.pixels == 0) {
                            debugPrint("At the top");
                          } else {
                            debugPrint("At the bottom");
                            controller.fetchMuscles();
                          }
                        }
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return await controller.fetchMuscles(forceReload: true);
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverMainAxisGroup(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, bottom: 14),
                                    child: Text(
                                      'Pick the muscle groups you want to workout.',
                                      style: context.bodyMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 14.0),
                                    child: Text(
                                      'Main Muscle Groups',
                                      style: context.headlineSmall!.copyWith(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          GetBuilder<WorkoutPlanController>(
                            builder: (controller) => controller.musclesData.value?.muscles?.isNotEmpty ?? false ?
                              SliverGrid.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 38,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: controller.musclesData.value?.muscles?.length,
                                itemBuilder: (context, index) {
                                  final element = controller.musclesData.value?.muscles?[index];
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (controller.selectedMuscle.map((e) => e.id).contains(element?.id)) {
                                            controller.selectedMuscle.removeWhere((e) => e.id == element?.id);
                                          } else {
                                            controller.selectedMuscle.add(element!);
                                          }
                                          controller.update();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                controller.selectedMuscle.map((e) => e.id).contains(element?.id) ? 10 : 0
                                            ),
                                            // color: themeColor,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: ImageWidget(
                                                  isNetworkImage: true,
                                                  imageUrl: "${ApiConstants.baseUrl}${element?.muscleImage}",
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ),
                                              controller.selectedMuscle.map((e) => e.id).contains(element?.id) ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: yellow.withValues(alpha: 0.5)
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: themeColor,
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                  ),
                                                  child: const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ) : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${element?.name}",
                                          style: context.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: primary,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              )
                              : SliverToBoxAdapter(
                                  child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Text(
                                      'No Muscle Found',
                                      style: context.bodyLarge?.copyWith(
                                        fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: controller.selectedMuscle.isEmpty ? null : CustomButton(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              title: "Continue",
              onTap: () {
                Get.back();
              },
            ),
          ),
        );
      }
    );
  }
}
