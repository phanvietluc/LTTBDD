import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/widget/widget_connect_firebase.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:card_swiper/card_swiper.dart';
import 'page_list_food_cate.dart';
import 'page_details.dart';

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
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> _refreshUser() async {
    user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshUser();
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
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
            ),
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

void SignOut(){
  FirebaseAuth.instance.signOut();
}

