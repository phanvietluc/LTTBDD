import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/food_selling/model_categories.dart';
import 'controller.dart';
import 'page_details.dart';
import 'package:badges/badges.dart' as badges;
import 'page_giohang.dart';
class PageListFood extends StatelessWidget {
  Categories categories;
  PageListFood({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Selling", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: GetBuilder<FoodController>(
        id: "listCate",
        init: FoodController.get(),
        builder: (controller) {
          var productsInCategory = controller.ds.where((product) => product.cateid == categories.id).toList();
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${categories.ten}", style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                    ),
                    GridView.extent(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        children: productsInCategory.map(
                            (sp) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>  PageDetail(f: sp),)
                                );
                              },
                              child: Card(
                                elevation: 0.5,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: sp.anh == null ? Icon(Icons.image_not_supported) : Image.network(sp.anh!)
                                    ),
                                    Text("${sp.ten}",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text("${sp.gia}đ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            )
                        ).toList()
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

