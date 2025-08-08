import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetItem(Icons.bookmark_border, 'Save Workout'),
          _buildDivider(),
          _buildBottomSheetItem(Icons.share, 'Share Workout Link'),
          _buildDivider(),
          _buildBottomSheetItem(Icons.add, 'Create Workout From Scratch'),
          _buildDivider(),
          _buildBottomSheetItem(Icons.share, 'Build Superset/Circuit'),
          _buildDivider(),
          _buildBottomSheetItem(Icons.file_download_outlined, 'Saved Workouts'),
          _buildDivider(),
          _buildBottomSheetItem(
              Icons.change_circle_outlined, 'Refresh Workout'),
        ],
      ),
    );
  }

  Widget _buildBottomSheetItem(IconData icon, String title) {
    return ListTile(
      onTap: () => Get.back(),
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: grey.withOpacity(0.2),
      height: 1.2,
    );
  }
}
