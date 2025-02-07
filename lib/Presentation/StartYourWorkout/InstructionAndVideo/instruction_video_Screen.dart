import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicholas_nutrihaven/Presentation/Auth/SignIn/signin.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';
import 'package:nicholas_nutrihaven/Widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_appbar.dart';
import '../Widget/video_player_widget.dart';

class InstructionVideoScreen extends StatefulWidget {
  const InstructionVideoScreen({super.key});

  @override
  State<InstructionVideoScreen> createState() => _InstructionVideoScreenState();
}

class _InstructionVideoScreenState extends State<InstructionVideoScreen> {
  int _selectedIndex = 0;

  onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(
        title: 'Instructions & Video',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// VideoPlayer
              SizedBox(
                // height: 300.h,
                child: VideoPlayerWidget(),
              ),

              ///

              15.verticalSpace,
              Text(
                "Dumbbell Bicep Curls",
                style: context.headlineSmall!.copyWith(color: black),
              ),

              /// tabs
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => onSelected(0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 1.2, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == 0 ? darkTheme : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          "Instructions",
                          style: context.labelSmall!.copyWith(
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : darkTheme,
                              fontWeight:
                                  _selectedIndex == 0 ? FontWeight.w700 : null),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => onSelected(1),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 1.2, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == 1
                              ? darkTheme
                              : grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          "Target",
                          style: context.labelSmall!.copyWith(
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : darkTheme,
                              fontWeight:
                                  _selectedIndex == 1 ? FontWeight.w700 : null),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => onSelected(2),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 1.2, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == 2
                              ? darkTheme
                              : grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          "Equipments",
                          style: context.labelSmall!.copyWith(
                              color: _selectedIndex == 2
                                  ? Colors.white
                                  : darkTheme,
                              fontWeight:
                                  _selectedIndex == 2 ? FontWeight.w700 : null),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type. Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",
                style: context.bodyMedium!.copyWith(color: grey),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
