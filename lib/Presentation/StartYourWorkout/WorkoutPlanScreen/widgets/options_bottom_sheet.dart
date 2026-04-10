import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({
    super.key,
    this.onSavedWorkoutTap,
    this.onCreateWorkoutTap,
    this.onScratchTap,
    this.onRefreshTap,
    this.onTap,
  });

  final VoidCallback? onSavedWorkoutTap;
  final VoidCallback? onCreateWorkoutTap;
  final VoidCallback? onScratchTap;
  final VoidCallback? onRefreshTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetItem(Icons.bookmark_border, 'Save Workout', onCreateWorkoutTap),
          _buildDivider(),
          _buildBottomSheetItem(Icons.share, 'Share Workout Link'),
          _buildDivider(),
          _buildBottomSheetItem(Icons.add, 'Create Workout From Scratch', onTap),
          _buildDivider(),
          _buildBottomSheetItem(Icons.share, 'Build Superset/Circuit'),
          _buildDivider(),
          _buildBottomSheetItem(Icons.file_download_outlined, 'Saved Workouts', onSavedWorkoutTap),
          _buildDivider(),
          _buildBottomSheetItem(
              Icons.change_circle_outlined, 'Refresh Workout'),
        ],
      ),
    );
  }

  Widget _buildBottomSheetItem(IconData icon, String title, [VoidCallback? onTap]) {
    return ListTile(
      onTap: onTap ?? () => Get.back(),
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: grey.withValues(alpha: 0.2),
      height: 1.2,
    );
  }
}
