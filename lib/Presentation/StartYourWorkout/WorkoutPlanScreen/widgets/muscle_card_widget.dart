import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/image_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MuscleCardWidget extends StatelessWidget {
  const MuscleCardWidget({
    super.key,
    required this.muscleName,
    required this.imageUrl,
    required this.onRemove,
  });

  final String muscleName;
  final String imageUrl;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: grey.withValues(alpha: 0.2),
      elevation: 0,
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      muscleName, style: context.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: grey.withValues(alpha: 0.2),
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
            Align(
              alignment: Alignment.topRight,
              child: CloseButton(
                onPressed: onRemove,
              ),
            )
          ],
        ),
      ),
    );
  }
}
