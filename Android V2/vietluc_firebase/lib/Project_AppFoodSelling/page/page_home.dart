import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../widget_connect_firebase.dart';
import '../controller/controller.dart';
import '../controller/user_controller.dart';
import '../model/model_users.dart';
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
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Food Selling", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").where("id", isEqualTo: user!.uid).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Có lỗi xảy ra: ${snapshot.error}');
                      }
                      var data = snapshot.data!.docs.first.data();
                      return UserAccountsDrawerHeader(
                        accountName: Text("${data["name"]}"),
                        accountEmail: Text("${data["email"]}"),
                      );
                    },
                  );

                }else return CircularProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {

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
                      UserController user = UserController();
                      user.signOut(context);
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