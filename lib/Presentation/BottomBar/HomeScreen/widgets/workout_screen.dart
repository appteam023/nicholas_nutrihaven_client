// import 'package:flutter/material.dart';
//
// import '../../../../Utils/Const/color_const.dart';
//
// class WorkoutWidget extends StatefulWidget {
//   @override
//   _WorkoutWidgetState createState() => _WorkoutWidgetState();
// }
//
// class _WorkoutWidgetState extends State<WorkoutWidget> {
//   int selectedIndex = 0;
//
//   final List<String> levels = ['Beginner', 'Intermediate', 'Advance'];
//   final List<List<Map<String, dynamic>>> workoutContent = [
//     [
//       {
//         'title': 'Chest & Triceps',
//         'calories': '500 Kcal',
//         'time': '50 Min',
//         'image': 'assets/chest_triceps.png',
//       },
//       {
//         'title': 'Back & Biceps',
//         'calories': '600 Kcal',
//         'time': '40 Min',
//         'image': 'assets/back_biceps.png',
//       },
//     ],
//     [
//       {
//         'title': 'Legs & Core',
//         'calories': '700 Kcal',
//         'time': '60 Min',
//         'image': 'assets/legs_core.png',
//       },
//       {
//         'title': 'Shoulders',
//         'calories': '400 Kcal',
//         'time': '30 Min',
//         'image': 'assets/shoulders.png',
//       },
//     ],
//     [
//       {
//         'title': 'Full Body',
//         'calories': '800 Kcal',
//         'time': '90 Min',
//         'image': 'assets/full_body.png',
//       },
//       {
//         'title': 'Cardio',
//         'calories': '500 Kcal',
//         'time': '45 Min',
//         'image': 'assets/cardio.png',
//       },
//     ],
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: List.generate(levels.length, (index) {
//             final isSelected = selectedIndex == index;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//               child: Container(
//                 height: 35,
//                 width: 125,
//                 decoration: BoxDecoration(
//                   gradient: isSelected ? gradientYellow : null,
//                   color: isSelected ? null : primary.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Center(
//                   child: Text(
//                     levels[index],
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.bold,
//                       color: isSelected ? secondary : darkGrey,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//         SizedBox(height: 20),
//         // Workout Cards
//         Expanded(
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: workoutContent[selectedIndex].length,
//             itemBuilder: (context, index) {
//               final workout = workoutContent[selectedIndex][index];
//               return Container(
//                 margin: EdgeInsets.only(right: 16),
//                 width: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: AssetImage(workout['image']),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     gradient: LinearGradient(
//                       colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           "Beginners Level",
//                           style: TextStyle(
//                             color: Colors.yellow,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           workout['title'],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _InfoChip(
//                               icon: Icons.local_fire_department,
//                               text: workout['calories'],
//                             ),
//                             _InfoChip(
//                               icon: Icons.access_time,
//                               text: workout['time'],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//
//   }
// }
//
// class _InfoChip extends StatelessWidget {
//   final IconData icon;
//   final String text;
//
//   const _InfoChip({required this.icon, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.white,
//           size: 16,
//         ),
//         SizedBox(width: 4),
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }
