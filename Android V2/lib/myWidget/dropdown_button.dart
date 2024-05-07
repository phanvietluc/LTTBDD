import 'package:flutter/material.dart';
import 'wrapper_data.dart';
class MyDropDown extends StatefulWidget {
  List<String> lables;
  stringWrapper value;
  Widget Function(String vale)? itemBuilder;
  MyDropDown({required this.value,required this.lables, this.itemBuilder, super.key});
  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        isExpanded: true,
        value: widget.value.value,
        items: widget.lables.map(
          (lable) => DropdownMenuItem(
              value: lable,
              child: widget.itemBuilder == null ?
                  Text(lable):
                  widget.itemBuilder!(lable)
          )
        ).toList(),
        onChanged: (value) {
          setState(() {
            widget.value.value = value;
          });
        },
    );
  }

}

