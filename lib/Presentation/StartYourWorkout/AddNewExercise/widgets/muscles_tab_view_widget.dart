import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/Model/MuscleModel/get_muscle_model.dart';
import 'package:nicholas_nutrihaven/Data/response/status.dart';

import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/add_new_exercise_controller.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/muscle_list_item_widget.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MusclesTabView extends StatelessWidget {
  MusclesTabView({
    super.key,
  });
  final List<Datum> _fakeMuscles = List.generate(
    5,
    (index) => Datum(
      muscleId: index,
      muscleName: 'Muscle $index',
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
                  muscleName: muscle.muscleName ?? 'Unknown',
                  imageUrl: muscle.muscleImage ?? ImageConst.bicep,
                  muscleId: muscle.muscleId ?? 0,
                );
              },
            ),
          );
        case Status.COMPLETED:
          final muscles = response.response?.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.vertical,
            itemCount: muscles.length,
            itemBuilder: (context, index) {
              final muscle = muscles[index];
              return MuscleListItemWidget(
                muscleName: muscle.muscleName ?? 'Unknown',
                imageUrl: muscle.muscleImage ?? ImageConst.bicep,
                muscleId: muscle.muscleId ?? 0,
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
