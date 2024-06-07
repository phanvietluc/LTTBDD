import 'package:flutter/material.dart';
import 'wrapper_data.dart';
class MyGroupRadio extends StatefulWidget {
  List<String> lables;
  stringWrapper groupValue;
  bool? isHorizaltal;//theo chiều ngang(true) hoặc dọc(false)
  MyGroupRadio({required this.lables, required this.groupValue,this.isHorizaltal = true,super.key});

  @override
  State<MyGroupRadio> createState() => _MyGroupRadioState();
}

class _MyGroupRadioState extends State<MyGroupRadio> {
  @override
  Widget build(BuildContext context) {
    if(widget.isHorizaltal == true)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildListRadio(),
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildListRadio(),
    );
  }
  _buildListRadio(){
    return
    widget.lables.map(
      (lable) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
              value: lable,
              groupValue: widget.groupValue.value,
              onChanged: (value) {
                setState(() {
                  widget.groupValue.value = value!;
                });
              },
          ),
          Text(lable, style: TextStyle(fontSize: 20),)
        ],
      )
    ).toList();
  }
}
