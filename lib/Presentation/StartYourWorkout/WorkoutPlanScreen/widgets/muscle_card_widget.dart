import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/asset_const.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/image_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MuscleCardWidget extends StatelessWidget {
  const MuscleCardWidget({
    super.key,
    required this.muscleName,
    required this.imageUrl,
  });

  final String muscleName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: grey.withOpacity(0.2),
      elevation: 0,
      child: SizedBox(
        width: 180.w,
        child: Row(
          children: [
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                clipBehavior: Clip.antiAlias,
                color: darkTheme,
                elevation: 0,
                child: Skeleton.replace(
                  replace: true,
                  height: 64.h,
                  width: 64.w,
                  replacement: Container(color: Colors.grey.shade300),
                  child: ImageWidget(
                    isNetworkImage: true,
                    imageUrl: imageUrl,
                    height: 64.h,
                    width: 64.w,
                  ),
                )),
            SizedBox(width: 5.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(muscleName, style: context.labelLarge),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '100%',
                    style: context.bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
