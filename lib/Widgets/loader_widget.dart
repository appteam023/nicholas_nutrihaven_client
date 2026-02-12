import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Const/color_const.dart';
import 'custom_loader_widget.dart';

bool kIsLoading = true;

showLoader(bool val) {
  if (val == false && kIsLoading == false) return;
  debugPrint("val----$val");
  kIsLoading = val;
  if (val) {
    Get.dialog(CustomLoadingWidget(
      isLoading: val,
    ));
    debugPrint("true----$val");
  } else {
    debugPrint("false----$val");
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
  }
}


class CustomLoader extends StatefulWidget {
  const CustomLoader({
    super.key,
    required this.isLoading,
    required this.child,
    this.blurAmount = 4.0,
    this.overlayColor = Colors.black54,
    this.loaderColor = themeColor,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final bool isLoading;
  final Widget child;
  final double blurAmount;
  final Color overlayColor;
  final Color? loaderColor;
  final Duration animationDuration;

  @override
  State<CustomLoader> createState() => AnimatedCustomLoaderState();
}

class AnimatedCustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: widget.blurAmount).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CustomLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AbsorbPointer(
          absorbing: widget.isLoading,
          child: widget.child,
        ),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_controller.status == AnimationStatus.dismissed) {
              return const SizedBox.shrink();
            }

            return RepaintBoundary(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: _blurAnimation.value,
                  sigmaY: _blurAnimation.value,
                ),
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: ColoredBox(
                    color: widget.overlayColor.withValues(alpha: 0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: widget.loaderColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}