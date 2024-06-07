import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/admin/page_dssp_admin.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/admin/page_order_admin.dart';

class PageAdmin extends StatelessWidget {
  const PageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          children: [
            AdminOption(context, "Danh mục các sản phẩm", FoodSellAdmin()),
            SizedBox(height: 30,),
            AdminOption(context, "Các đơn hàng", OrderPageAdmin()),
          ],
        ),
      )
    );
  }

  Widget AdminOption(BuildContext context, String title, Widget widget) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => widget,)
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
