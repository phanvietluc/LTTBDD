import 'dart:math';

import 'package:flutter/material.dart';

List<String> sp = ['Táo','Mít','Chuối','Xoài','Me','Chôm chôm','Sầu riêng', 'Dâu tây', 'Măng cụt', 'Mận', 'Thanh long'];
class PageList extends StatelessWidget {
  const PageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List View"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) =>
              ListTile(
                title: Text(sp[index], style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Trái cây Việt Gap'),
                trailing: Text('${Random().nextInt(100)}.000 VNĐ', style: TextStyle(color: Colors.red),),//Ghi phía sau, leading ghi phía trước
                leading: Icon(Icons.food_bank, color: Colors.blue,),
              ),
          separatorBuilder: (context, index) =>
              Divider(thickness: 1.5, color: Colors.blue,),
          itemCount: sp.length////Số lượng phần tử muốn cho vào danh sách
      )
    );
  }
}
class PageListBuild extends StatelessWidget {
  const PageListBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List View"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) =>
              ListTile(
                title: Text(sp[index], style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Trái cây Việt Gap'),
                trailing: Text('${Random().nextInt(100)}.000 VNĐ', style: TextStyle(color: Colors.red),),//Ghi phía sau, leading ghi phía trước
                leading: Icon(Icons.food_bank, color: Colors.blue,),
              ),
          itemCount: sp.length,//Số lượng phần tử muốn cho vào danh sách
      )
    );
  }
}

