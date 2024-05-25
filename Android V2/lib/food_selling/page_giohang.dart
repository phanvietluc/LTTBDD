import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/food_selling/model.dart';
import 'controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:viet_luc63132246_flutter/myWidget/custom_text.dart';
class CartFood extends StatelessWidget {
  const CartFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: GetBuilder<FoodController>(
        init: FoodController.get(),
        id: "gio_hang",
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    GH_Item gh = controller.gh[index];
                    Food f = controller.ds.firstWhere((sp) => sp.id == gh.idSP);
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () {
                                          controller.tangSlSp(f, updateWidgetID: ["gio_hang"]);
                                        }),
                                    CustomText(
                                        text: "${gh.sl}",
                                        size: 18,
                                        weight: FontWeight.bold,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.remove_circle),
                                        onPressed: () {
                                          controller.giamSlsp(f, updateWidgetID: ["gio_hang"]);
                                        }),
                                  ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 20),
                              child: f.anh == null ? Icon(Icons.image_not_supported) : Image.network(f.anh!, width: 90, height: 90,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${f.ten}",
                                  weight: FontWeight.bold,
                                  size: 15,
                                ),
                                SizedBox(height: 10,),
                                CustomText(
                                  text: "${f.gia} VNĐ",
                                  color: Colors.red,
                                  weight: FontWeight.bold,
                                  size: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  },
                  separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                  itemCount: FoodController.get().slMatHangGH,
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
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                        child: Center(
                            child: Text(
                              "Thanh toán",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
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