import 'dart:math';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/fruit_store/model.dart';
import 'controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:viet_luc63132246_flutter/myWidget/custom_text.dart';
import '../widget/widget_connect_firebase.dart';
class AppFruitStore extends StatelessWidget {
  const AppFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      ErrorMessege: "Lỗi rồi: ${Error}",
      ConnectMessege: "Đang kết nối",
      builder:(context) => GetMaterialApp(
        initialBinding: FruitStoreBinding(),
        debugShowCheckedModeBanner: false,
        home: PageHome(),
      ),
    );
  }
}

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Store",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: GetBuilder<SimpleController>(
        init: SimpleController.get(),//Gọi món
        id: "listSP",//Mã bàn
        builder: (controller) {
          return GridView.extent(
            maxCrossAxisExtent: 300,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: controller.dssp.map(
              (sp) => GestureDetector(
                onTap: () {
                  Get.to(PageDetails(f: sp));
                },
                child: Card(
                  elevation: 0.5,
                  child: Column(
                    children: [
                      Expanded(
                        child: sp.anh == null ? Icon(Icons.image_not_supported):Image.network(sp.anh!),
                      ),
                      Text("${sp.ten}",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("${sp.gia}đ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              )
            ).toList()
          );
        },//Món ăn được gọi tới đúng bàn
      ),
      //Chỉ có một và ghi ngoài body
    );
  }
}

class PageDetails extends StatelessWidget {
  Fruit f;
  PageDetails({required this.f,super.key});
  double r = Random().nextInt(21)/10.0 + 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${f.ten}",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
        actions: [
          GetBuilder<SimpleController>(
            init: SimpleController.get(),
            id: "listSP",
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  Get.to(CartFruit());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: badges.Badge(
                    badgeContent: Text('${SimpleController.get().slMatHangGH}'),
                    child: Icon(Icons.add_shopping_cart_outlined, size: 30,),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,width: MediaQuery.of(context).size.width,
              child: f.anh == null ? Icon(Icons.image_not_supported):Image.network(f.anh!),
            ),
            Text("${f.ten}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text("${f.mota}",),
            Row(
              children: [
                Text("${f.gia}đ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20,),),
                SizedBox(width: 30,),
                Text("${f.gia + f.gia * 0.2}đ", style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 20),)
              ],
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: r,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 10,),
                Text("${r}",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text("${Random().nextInt(100)} đánh giá")
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart_rounded),
        onPressed: () {
          SimpleController.get().themvaoGH(f, updateWidgetID: ["gio_hang"]);
        },
      ),
    );
  }
}

class CartFruit extends StatelessWidget {
  const CartFruit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: GetBuilder<SimpleController>(
        init: SimpleController.get(),
        id: "gio_hang",
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('Trái cây Cam Ranh\nSố 6 - Hùng Vương - Cam Phúc Nam - Cam Ranh - Khánh Hòa\nSĐT: 0378946251',style: TextStyle(fontSize: 15),),
              ),
              SizedBox(height: 50,),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      GH_Item gh = controller.gh[index];
                      Fruit f = controller.dssp.firstWhere((sp) => sp.id == gh.idSP);
                      int gia = f.gia * gh.sl;
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Xóa',
                              onPressed: (context) => controller.xoaSPkGH(f, updateWidgetID: ["gio_hang"]),
                            )
                          ],
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 60, height: 60,
                            child: f.anh == null ? Icon(Icons.image_not_supported) : Image.network(f.anh!),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: CustomText(
                                  text: "${f.ten}",
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_rounded),
                                    onPressed: () {
                                      controller.giamSlsp(f, updateWidgetID: ["gio_hang"]);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      text: "${gh.sl}",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_circle_rounded),
                                    onPressed: () {
                                      controller.tangSlSp(f, updateWidgetID: ["gio_hang"]);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(14),
                            child: CustomText(
                              text: "${gia.toInt()} VNĐ",
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                    itemCount: SimpleController.get().slMatHangGH,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng số tiền: ",style: TextStyle(fontSize: 18),),
                        SizedBox(width: 50,),
                        Text("${controller.Tong().toInt()} VNĐ",style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


//Phần thanh toán giỏ hàng
//Sử dụng ListView.separator
//Slidable => itemBuilder 