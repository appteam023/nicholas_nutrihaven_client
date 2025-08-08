import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Data/Model/ExcerciseModel/get_exercise_model.dart'
    as exerciseModel;
import 'package:nicholas_nutrihaven/Data/Model/muscleModel/get_muscle_model.dart';

import 'package:nicholas_nutrihaven/Data/response/status.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/add_new_exercise_controller.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/custom_tab_bar_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/exercise_list_item_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/exercises_tab_view_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/muscle_list_item_widget.dart';
import 'package:nicholas_nutrihaven/Presentation/StartYourWorkout/AddNewExercise/widgets/muscles_tab_view_widget.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_appbar.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddNewExerciseScreen extends StatelessWidget {
  AddNewExerciseScreen({super.key});

  final controller = Get.put(AddNewExerciseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildAddExerciseButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: _buildAppBar(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const CustomTabBarWidget(
              tabTitles: ['All Exercises', 'By Muscle', 'Categories'],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ExercisesTabView(),
                  MusclesTabView(),
                  _buildCategoriesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return CustomAppBar(
      title: 'Add New Exercise',
      actionImage: InkWell(
        child: const Icon(
          Icons.more_vert_outlined,
          color: Colors.white,
        ),
      ),
      actionImageBG: secondary.withValues(alpha: 0.1),
    );
  }

  Widget _buildCategoriesTab() {
    return const Center(
      child: Text(
        'Categories Tab Content',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget _buildAddExerciseButton() {
    return Obx(
      () => CustomButton(
        width: 200.w,
        title: 'Add 1 Exercise',
        onTap: !controller.isExerciseSelected()
            ? null
            : () {
                controller.postExercise();
              },
      ),
    );
  }
}
