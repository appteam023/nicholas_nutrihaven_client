import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcerciseModel/get_exercise_model.dart';
import 'package:nicholas_nutrihaven/Data/response/status.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/add_new_exercise_controller.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/exercise_list_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExercisesTabView extends StatelessWidget {
  ExercisesTabView({
    super.key,
  });

  final List<Exercise> _fakeExercises = List.generate(
    3,
    (index) => Exercise(
      id: index,
      name: 'Exercise $index',
      exerciseImage: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddNewExerciseController>();
    return Obx(() {
      final response = controller.getExerciseResponse.value;
      switch (response.status) {
        case Status.INITIAL:
          return const SizedBox.shrink();
        case Status.LOADING:
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _fakeExercises.length,
              itemBuilder: (context, index) {
                final exercise = _fakeExercises[index];
                return ExerciseListItemWidget(
                  name: exercise.name ?? 'Unnamed Exercise',
                  exerciseId: exercise.id ?? 0,
                );
              },
            ),
          );
        case Status.COMPLETED:
          final exercises = response.response?.data?.exercises ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExerciseListItemWidget(
                name: exercise.name ?? 'Unnamed Exercise',
                exerciseId: exercise.id ?? 0,
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
