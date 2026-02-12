import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Utils/Const/asset_const.dart';
import '../../../../Data/response/status.dart';
import '../add_new_exercise_controller.dart';
import 'muscle_list_item_widget.dart';

import '../../../../Data/Model/muscleModel/get_muscle_model.dart';

class MusclesTabView extends StatelessWidget {
  MusclesTabView({
    super.key,
  });
  final List<Muscle> _fakeMuscles = List.generate(
    5,
    (index) => Muscle(
      id: index,
      name: 'Muscle $index',
      muscleImage: ImageConst.bicep,
    ),
  );
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddNewExerciseController>();
    return Obx(() {
      final response = controller.getMuscleResponse.value;
      switch (response.status) {
        case Status.INITIAL:
          return const SizedBox.shrink();
        case Status.LOADING:
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.vertical,
              itemCount: _fakeMuscles.length,
              itemBuilder: (context, index) {
                final muscle = _fakeMuscles[index];
                return MuscleListItemWidget(
                  muscleName: muscle.name ?? 'Unknown',
                  imageUrl: muscle.muscleImage ?? ImageConst.bicep,
                  muscleId: muscle.id ?? 0,
                );
              },
            ),
          );
        case Status.COMPLETED:
          final muscles = response.response?.data?.muscles ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.vertical,
            itemCount: muscles.length,
            itemBuilder: (context, index) {
              final muscle = muscles[index];
              return MuscleListItemWidget(
                muscleName: muscle.name ?? 'Unknown',
                imageUrl: muscle.muscleImage ?? ImageConst.bicep,
                muscleId: muscle.id ?? 0,
              );
            },
          );
        case Status.ERROR:
          return SizedBox(
            height: 180.h,
            child: Center(
                child: Text('Error: ${response.message ?? "Unknown error"}')),
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }
}
