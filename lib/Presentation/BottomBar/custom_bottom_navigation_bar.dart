import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Presentation/BottomBar/DrawerScreen/drawer_screen.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';
import 'package:nicholas_nutrihaven/Utils/Extensions/text_extension.dart';

import '../../Utils/Const/asset_const.dart';
import 'bottom_nav_controller.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override CustomBottomNavigationBarState createState() => CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: darkTheme));
  }

  final List<Widget> _screens = [
    DrawerScreen(),
    const Center(child: Text("Explore Screen")),
    const Center(child: Text("Video Screen")),
    const Center(child: Text("Profile Screen")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.put(BottomNavController());

    return SizedBox(
      child: GetBuilder(
          init: bottomNavController,
          builder: (_) {
            return Scaffold(
              // appBar:
              //     _bottomNavContoller.isAppBarHide == true
              //         ? AppBar(
              //             toolbarHeight: kToolbarHeight * 1.5,
              //             centerTitle: true,
              //             leading: Padding(
              //               padding: const EdgeInsets.only(left: 8.0),
              //               child: CircleAvatar(
              //                 backgroundColor: darkTheme.withOpacity(0.7),
              //                 child: IconButton(
              //                   onPressed: () {
              //                     _bottomNavContoller.advancedDrawerController
              //                         .hideDrawer();
              //                     _bottomNavContoller.isAppBarHide = false;
              //                     _bottomNavContoller.update();
              //                   },
              //                   icon: Icon(
              //                     Icons.close,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             title: Image.asset(ImageConst.logo2),
              //           )
              //         : null,
              body: SafeArea(
                top: false,
                child: _screens[_selectedIndex]
              ),
              // Display the selected screen
              // Custom Bottom Navigation Bar
              extendBody: true,
              // Make the bottom container transparent if needed
              extendBodyBehindAppBar: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 64.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF242424),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavItem(
                        icon: ImageConst.home,
                        label: "Home",
                        isSelected: _selectedIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      NavItem(
                        icon: ImageConst.explore,
                        label: "Explore",
                        isSelected: _selectedIndex == 1,
                        onTap: () => _onItemTapped(1),
                      ),
                      NavItem(
                        icon: ImageConst.video,
                        label: "Video",
                        isSelected: _selectedIndex == 2,
                        onTap: () => _onItemTapped(2),
                      ),
                      NavItem(
                        icon: ImageConst.profileB,
                        label: "Profile",
                        isSelected: _selectedIndex == 3,
                        onTap: () => _onItemTapped(3),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// Navigation Item Widget
class NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color(0xffE4BB49), // gradYellow start
                    Color(0xffAB7D01), // gradYellow end
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Image.asset(icon, height: 24.h, width: 24.w, color: secondary),
            if (isSelected) ...[
              const SizedBox(width: 8), // Spacing between icon and label
              Text(label,
                  style: context.labelSmall!.copyWith(color: secondary)),
            ],
          ],
        ),
      ),
    );
  }
}
