import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  bool? readOnly;
  bool? obscureText;
  TextEditingController? controller;
  VoidCallback? onTap;
  void Function(String)? onChanged;
  Widget? prefix;
  Widget? suffix;
  Widget? suffixIcon;
  int? minLines;
  int? maxLines;
  Widget? color;
  TextInputType? keyboardType;
  var radius;
  TextInputAction? inputAction;
  String? Function(String?)? validator;
  void Function()?  onEditingComplete;

  CustomTextField({
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
              color: secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: secondary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: secondary,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 200.r),
            borderSide:  BorderSide(
              color: secondary,
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
