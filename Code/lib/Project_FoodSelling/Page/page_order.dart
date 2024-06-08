import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/userdatabase.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_cart.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  User? user;
  Stream<List<CartSnapshot>>? orderStream;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await loadOrderData(user!.uid);
    }
  }

  loadOrderData(String userId) async {
    orderStream = await CartSnapshot.getOrder(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tất cả đơn hàng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<List<CartSnapshot>>(
        stream: orderStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Có lỗi xảy ra: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Bạn chưa đặt đơn hàng nào"));
          }
          var list = snapshot.data!;
          return ListView.separated(
            itemBuilder: (context, index) {
              var dsHH = list[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image.network(dsHH.cart.anhsp, height: 120, width: 120, fit: BoxFit.cover),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dsHH.cart.tenSP}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text("Số lượng: ${dsHH.cart.sl}"),
                        Text("Tổng cộng: ${dsHH.cart.tong} VNĐ"),
                        Row(
                          children: [
                            Text(
                              "Trạng thái: ",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "${dsHH.cart.trangthai}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: dsHH.cart.trangthai == "Đang giao hàng" ? Colors.red : Colors.green,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(thickness: 1.5),
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
