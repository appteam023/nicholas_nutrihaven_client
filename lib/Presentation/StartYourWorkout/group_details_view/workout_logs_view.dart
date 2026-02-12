

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Const/color_const.dart';
import '../../../Utils/Extensions/text_extension.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/loader_widget.dart';
import '../controller/workout_plan_controller.dart';

class WorkoutLogsView extends StatelessWidget {
  const WorkoutLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutPlanController>(
      init: Get.find<WorkoutPlanController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller?.fetchWorkOutLogs();
        });
      },
      builder: (controller) {
        return CustomLoader(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: secondary,
            appBar: CustomAppBar(
              title: "Workout Logs",
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
                            controller.fetchWorkOutLogs();
                          }
                        }
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return await controller.fetchWorkOutLogs(forceReload: true);
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
                                    padding: const EdgeInsets.only(bottom: 14.0),
                                    child: Text(
                                      "Workout Time Logs",
                                      style: context.headlineSmall!.copyWith(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            controller.workoutLogData.value?.workoutLogs?.isNotEmpty ?? false ?
                            SliverList.builder(
                              itemCount: controller.workoutLogData.value?.workoutLogs?.length,
                              itemBuilder: (context, index) {
                                final element = controller.workoutLogData.value?.workoutLogs?[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (index == 0)
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              buildHeader(context, "Start Time", Colors.green),
                                              buildHeader(context, "End Time", Colors.redAccent),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    Row(
                                      children: [
                                        buildTimer(context, controller, element?.startTime, Colors.green),
                                        buildTimer(context, controller, element?.endTime, Colors.redAccent),
                                      ],
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
                                    "No Logs Found",
                                    style: context.bodyLarge?.copyWith(
                                        fontSize: 18
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
          ),
        );
      }
    );
  }

  Flexible buildHeader(BuildContext context, String heading, Color iconColor) {
    return Flexible(
      child: ListTile(
        leading: Icon(Icons.timer, color: iconColor,),
        title: Text(
          heading,
          style: context.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: primary,
          ),
        ),
      ),
    );
  }

  Flexible buildTimer(BuildContext context, WorkoutPlanController controller,
    String? time, Color iconColor,
      ) {
    return Flexible(
      child: ListTile(
        leading: Icon(Icons.timer, color: iconColor),
        title: Text(
          time == null ? "-" :
          "${controller.formatTZDateString(time, format: "hh:mm:ss a")}",
          style: context.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: primary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          time == null ? "-" :
          "${controller.formatTZDateString(time, format: "dd-MM-yyyy")}",
          style: context.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: darkGrey,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
