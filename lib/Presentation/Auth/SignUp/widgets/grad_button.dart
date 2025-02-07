import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class GradButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final TextStyle? style;
  final VoidCallback? onTap;
  final bool isGradient;
  final bool loading;

  GradButton({
    super.key,
    this.width = 160, // Default fixed width
    this.height = 60, // Default fixed height
    required this.title,
    this.style,
    this.onTap,
    this.isGradient = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        width: width!.w, // Apply width scaling
        height: height!.h, // Apply height scaling
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          gradient: isGradient ? gradientYellow : null,
          color: isGradient ? null : Colors.grey,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            else
              Text(
                title,
                style: style ??
                    TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            if (!loading) ...[
              15.horizontalSpace,
              Icon(
                Icons.navigate_next,
                color: Colors.white,
                size: 20.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
