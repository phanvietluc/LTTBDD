import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/userdatabase.dart';

class OrderPageAdmin extends StatefulWidget {
  const OrderPageAdmin({super.key});

  @override
  State<OrderPageAdmin> createState() => _OrderPageAdminState();
}

class _OrderPageAdminState extends State<OrderPageAdmin> {
  Stream? orderStream;

  loadDulieu() async {
    orderStream = await UserDatabase().geAllOrder();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadDulieu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tất cả đơn hàng", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: StreamBuilder(
          stream: orderStream,
          builder: (context, snapshot) {
            return snapshot.hasData ?
            ListView.separated(
              itemBuilder: (context, index) {
                DocumentSnapshot dsHH = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tên KH: ${dsHH['name']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Text("Email: ${dsHH['email']}", style: TextStyle(fontSize: 16),),
                          Text("SPĐH: ${dsHH['tensp']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Text("Số lượng: ${dsHH['soluong']}"),
                          Row(
                            children: [
                              Text("Tổng cộng: "),
                              Text(" ${dsHH['tong']} VNĐ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () async {
                              await UserDatabase().updateStatusPr(dsHH.id);
                            },
                            child: Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.green,
                              ),
                              child: Center(child: Text("Đã giao", style: TextStyle(fontWeight: FontWeight.bold),),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 1.5,),
              itemCount: snapshot.data.docs.length,
            ) : Center(child: Text("Bạn chưa đặt đơn hàng nào"));
          },
        )
    );
  }
}
