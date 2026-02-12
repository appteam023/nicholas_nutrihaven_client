import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool? readOnly;
  final bool? obscureText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final int? minLines;
  final int? maxLines;
  final Widget? color;
  final TextInputType? keyboardType;
  final double? radius;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final void Function()?  onEditingComplete;
  final Color borderColor;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.readOnly,
    this.onTap,
    this.prefix,
    this.suffix,
    this.suffixIcon,
    this.minLines,
    this.maxLines,
    this.radius,
    this.validator,
    this.obscureText,
    this.inputAction,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.color,
    this.borderColor = secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondary,
      // height: 55.h,
      child: TextFormField(
        style: context.labelLarge!.copyWith(fontWeight: FontWeight.normal),
        obscureText: obscureText ?? false,
        validator: validator,
        onTap: onTap,
        onChanged: onChanged,
        onEditingComplete:  onEditingComplete,
        controller: controller,
        readOnly: readOnly ?? false,
        minLines: minLines ?? 1,
        maxLines: maxLines,
        textInputAction: inputAction ?? TextInputAction.done,
        keyboardType: keyboardType,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: radius != null? 20.0 : 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: borderColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: borderColor,
            ),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefix,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
