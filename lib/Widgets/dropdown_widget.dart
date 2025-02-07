
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/Const/color_const.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({super.key, required this.list});
  final List<String> list;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {

  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.list.first;
    return Container(
      height: 40.h,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(right: 8),

      decoration: BoxDecoration(
        color: grey.withOpacity(0.2),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: DropdownButton<String>(
        key: UniqueKey(),
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: black),),
          );
        }).toList(),
      ),
    );
  }
}
