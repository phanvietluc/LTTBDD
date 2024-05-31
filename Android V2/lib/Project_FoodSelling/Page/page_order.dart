import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/shared_references.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/userdatabase.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? email;
  Stream? orderStream;
  layDulieuNgD() async {
    email = await SharedReference().getUserEmail();
    setState(() {});
  }

  loadDulieu() async {
    await layDulieuNgD();
    orderStream = await UserDatabase().getOrder(email!);
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
                        Image.network(dsHH['anhsp'], height: 120, width: 120, fit: BoxFit.cover,),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${dsHH['tensp']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            Text("Số lượng: ${dsHH['soluong']}"),
                            Text("Tổng cộng: ${dsHH['tong']} VNĐ"),
                            Row(
                              children: [
                                Text("Trạng thái: ", style: TextStyle(fontSize: 15),),
                                Text("${dsHH['trangthai']}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: dsHH['trangthai'] == "Đang giao hàng" ? Colors.red : Colors.green
                                  ))
                              ],
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
