

import 'package:flutter/material.dart';


import '../Utils/Const/color_const.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.child,
    this.bottomChild,
    this.onClose,
    this.heading,
    this.showCloseBtn = true,
    this.padding,
    this.headingStyle,
  });

  final Widget child;
  final Widget? bottomChild;
  final VoidCallback? onClose;
  final bool showCloseBtn;
  final String? heading;
  final TextStyle? headingStyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: secondary,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(12,22,0,22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: showCloseBtn,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onClose ?? ()=> Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: black,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: heading != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, right: 12),
                child: Text(
                  "$heading",
                  style: headingStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: RawScrollbar(
                thumbVisibility: true,
                padding: const EdgeInsets.only(left: 6, right: 2, bottom: 2),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: child
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomChild ?? const SizedBox()
            ),
          ],
        ),
      ),
    );
  }
}
