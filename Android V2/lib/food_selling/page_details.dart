import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/food_selling/controller.dart';
import 'model.dart';
import 'package:badges/badges.dart' as badges;
import 'page_giohang.dart';
import 'package:get/get.dart';
class PageDetail extends StatelessWidget {
  Food f;
  PageDetail({required this.f, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Get.to(CartFood());
              },
              child: badges.Badge(
                showBadge: FoodController.get().slMatHangGH > 0,
                badgeContent: Text('${FoodController.get().slMatHangGH}'),
                child: Icon(Icons.add_shopping_cart_outlined, size: 30,),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,width: MediaQuery.of(context).size.width,
              child: f.anh == null ? Icon(Icons.image_not_supported):Image.network(f.anh!),
            ),
            Text("${f.ten}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text("${f.mota}", style: TextStyle(fontSize: 20),),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Giá", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text("${f.gia} VNĐ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FoodController.get().themvaoGH(f, updateWidgetID: ["gio_hang"]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Text("Thêm vào giỏ", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,),
                          Icon(Icons.add_shopping_cart, color: Colors.white,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
