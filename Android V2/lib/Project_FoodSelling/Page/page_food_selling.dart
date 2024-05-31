import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/Page/page_order.dart';
import 'package:viet_luc63132246_flutter/widget/widget_connect_firebase.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/controller/controller.dart';
import 'package:card_swiper/card_swiper.dart';
import 'page_list_food_cate.dart';
import 'page_details.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/shared_references.dart';
import 'page_profile.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/AuthPage/authmethod.dart';
class AppFoodSelling extends StatelessWidget {
  const AppFoodSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        ErrorMessege: "Lỗi kết nối",
        ConnectMessege: "Đang kết nối",
        builder: (context) => GetMaterialApp(
          initialBinding: FoodSellingBinlding(),
          debugShowCheckedModeBanner: false,
          home: PageHome(),
        ),
    );
  }
}

class PageHome extends StatefulWidget {
  PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String? name, email;
  layDulieuNgD() async {
    name = await SharedReference().getUserName();
    email = await SharedReference().getUserEmail();
    setState(() {});
  }

  loadDulieu() async {
    await layDulieuNgD();
    setState(() {});
  }

  @override
  void initState() {
    loadDulieu();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Selling", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${name}"),
              accountEmail: Text("${email}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PageProfile(),)
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.account_box),
                        SizedBox(width: 20,),
                        Text("Thông tin")
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OrderPage(),)
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag_rounded),
                        SizedBox(width: 20,),
                        Text("Các đơn hàng")
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      SignOut();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 20,),
                        Text("Đăng xuất")
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: GetBuilder<FoodController>(
        id: "listCate",
        init: FoodController.get(),
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.ct.length,
            itemBuilder: (context, index) {
              var category = controller.ct[index];
              var productsInCategory = controller.ds.where((product) => product.cateid == category.id).toList();
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(child: Text("${category.ten}", style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => PageListFood(categories: category,),)
                              );
                            },
                            child: Text("View all", style: TextStyle(color: Colors.blue),),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Swiper(
                        itemBuilder: (BuildContext context,int index){
                          var sp = productsInCategory[index];
                          return GestureDetector(
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
                          );
                        },
                        itemCount: productsInCategory.length,
                        pagination: null,
                        control: null,
                      ),
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

Future SignOut() async {
  await FirebaseAuth.instance.signOut();
}

