import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


showmySnackBar(BuildContext context, String thongBao, int thoiGian){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(thongBao), duration: Duration(seconds: thoiGian),
    )
  );
}