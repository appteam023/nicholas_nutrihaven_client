
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_button.dart';
import 'tag_video_controller.dart';

class TagVideoScreen extends StatelessWidget {
  const TagVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TagVideoController>(
        init: TagVideoController(),
        builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF093538),
            elevation: 0,
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
                  Icons.adaptive.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              "Tag Video",
              style: context.headlineSmall!.copyWith(fontSize: 24.sp)
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20
            ),
            child: Form(
              key: controller.tagFormKey,
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.start,
                    controller: controller.tagNameCtrl,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Tag Name",
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    textAlign: TextAlign.start,
                    controller: controller.tagDescCtrl,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Tag Description",
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    minLines: 2,
                    maxLines: 2,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    title: "Add Tag",
                    width: 250.w,
                    onTap: () async {
                      bool res = await controller.tagVideos();
                      if (res && context.mounted) {
                        _dialogBuilder(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/correct.png"),
                10.verticalSpace,
                Text("Tag Added Successfully!"),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                title: "Ok",
                width: 250.w,
                onTap: () {
                  Get.close(2);
                },
              )
            )
          ],
        );
      },
    );
  }
}
