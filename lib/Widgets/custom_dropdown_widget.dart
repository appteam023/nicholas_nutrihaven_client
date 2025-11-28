import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../Helpers/app_extensions.dart';
import '../Utils/Const/color_const.dart';


class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton({
    required this.hint,
    required this.selectedValue,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.dropdownSearchData,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.iconEnabledColor = Colors.grey,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    this.showSearchField = false,
    this.validator,
    super.key,
  });
  final String hint;
  // final String? value;
  final List<T> dropdownItems;
  final ValueChanged<T?>? onChanged;
  final T? selectedValue;
  final DropdownButtonBuilder? selectedItemBuilder;
  final DropdownSearchData? dropdownSearchData;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final bool showSearchField;
  final String? Function(T?)? validator;
  final Offset offset;

  @override
  State<CustomDropdownButton<T>> createState() => _CustomDropdownButton2State<T>();
}

class _CustomDropdownButton2State<T> extends State<CustomDropdownButton<T>> {

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: widget.hintAlignment,
          child: Text(
            widget.hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ),
        decoration: InputDecoration(
          prefix: widget.prefixIcon,
          prefixIconConstraints: widget.prefixIcon != null ? BoxConstraints(
            minWidth: 60.w,
          ) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide(
              color: grey
            )
          ),
          suffixIcon: widget.suffixIcon
        ),
        value: widget.selectedValue,
        items: widget.dropdownItems.map((T e) => DropdownMenuItem<T>(
          value: e,
          child: Container(
            alignment: widget.valueAlignment,
            child: Text(
              e.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
            ),
          ),
        )).toList(),
        validator: widget.validator,
        onChanged: widget.onChanged,
        selectedItemBuilder: widget.selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: widget.buttonHeight ?? 32,
          width: widget.buttonWidth,// ?? 140,
          padding: widget.buttonPadding ?? const EdgeInsets.only(left: 0, right: 0),
          decoration: widget.buttonDecoration ??
            BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: Colors.white,
              ),
            ),
          elevation: widget.buttonElevation,
        ),
        iconStyleData: widget.suffixIcon == null ? IconStyleData(
          icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down,),
          iconSize: widget.iconSize ?? 24,
          iconEnabledColor: widget.iconEnabledColor,
          iconDisabledColor: widget.iconDisabledColor,
        ) : IconStyleData(
          icon: const SizedBox()
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: widget.dropdownHeight ?? 400,
          // width: widget.dropdownWidth ?? 140,
          padding: widget.dropdownPadding,
          decoration: widget.dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
          elevation: widget.dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: widget.offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: widget.scrollbarRadius ?? const Radius.circular(40),
            thickness: widget.scrollbarThickness != null
                ? WidgetStateProperty.all<double>(widget.scrollbarThickness!)
                : null,
            thumbVisibility: widget.scrollbarAlwaysShow != null
                ? WidgetStateProperty.all<bool>(widget.scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: widget.itemHeight ?? 40,
          padding: widget.itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
        dropdownSearchData: widget.showSearchField ? DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 55,
          searchInnerWidget: Container(
            height: 55,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(
                  left: 20,
                  // bottom: 12,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
          },
        ) : null,
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}


class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.button,
    required this.itemList,
    required this.onChange,
    this.label,
    this.hintText,
    this.labelPadding,
    this.dropDownItemPadding,
  });

  final Widget button;
  final List<T> itemList;
  final ValueChanged<T?>? onChange;
  final String? label;
  final String? hintText;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? dropDownItemPadding;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label.isNotNullNotEmpty,
          child: Padding(
            padding: labelPadding ?? EdgeInsets.only(top: 8, bottom: 4, left: 16),
            child: Text(
              "$label",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 15,
                color: black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: IgnorePointer(
              ignoring: true,
              child: button
            ),
            // openWithLongPress: true,
            items: itemList.map((item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                "$item",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: black
                ),
              ),
            )).toList(),
            onChanged: onChange,
            buttonStyleData: ButtonStyleData(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              width: size.width/2,
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              offset: Offset(size.width/2.6, 4),
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: dropDownItemPadding ?? const EdgeInsets.only(left: 16, right: 16),
              height: 40
            ),
          ),
        ),
      ],
    );
  }
}