import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import 'custom_TextField.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final Widget? actionImage;
  final Color? actionImageBG;
  final bool searchField;
  final void Function(String)? onChanged;


  const CustomAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcon,
    this.onActionPressed,
    this.actionImage,
    this.actionImageBG,
    this.searchField = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF093538),
      elevation: 0,
      // leadingWidth: 81.w,
      leadingWidth: 56.w + horizontalPadding,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin:
              EdgeInsets.only(left: horizontalPadding, bottom: 5.h, top: 5.h),
          decoration: BoxDecoration(
            color: secondary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(100.r),
          ),
          child: Icon(
            leadingIcon ?? Icons.adaptive.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      title: title != null
          ? Text(title!,
              style: context.headlineSmall!.copyWith(fontSize: 24.sp))
          : null,
      centerTitle: true,
      actions: [
        if (actionImage != null) // Display circular avatar with custom widget
          Padding(
            padding: EdgeInsets.only(
                right: horizontalPadding, bottom: 5.h, top: 5.h),
            child: GestureDetector(
              onTap: onActionPressed,
              child: CircleAvatar(
                radius: 30.r,
                // Adjust size as needed
                backgroundColor: actionImageBG ?? Colors.transparent,
                // Remove background
                child: ClipOval(
                  child: actionImage,
                ),
              ),
            ),
          )
        else if (actionIcon != null) // Display action icon otherwise
          Padding(
            padding: EdgeInsets.only(
                right: horizontalPadding, top: 5.h, bottom: 5.h),
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: secondary.withValues(alpha: 0.1),
              child: IconButton(
                icon: Icon(actionIcon, color: Colors.white),
                onPressed: onActionPressed,
              ),
            ),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, searchField ? 50 : 0),
        child: Visibility(
          visible: searchField,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100)
            ),
            child: CustomTextField(
              hintText: 'Search',
              radius: 100.0,
              onChanged: (val) {
                if (onChanged != null) {
                  onChanged!(val);
                }
              }
              // controller:
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(searchField ? kToolbarHeight + 50 : kToolbarHeight);
}
