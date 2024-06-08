import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_cart.dart';

class OrderPageAdmin extends StatefulWidget {
  const OrderPageAdmin({super.key});

  @override
  State<OrderPageAdmin> createState() => _OrderPageAdminState();
}

class _OrderPageAdminState extends State<OrderPageAdmin> {
  Stream<List<CartSnapshot>>? orderStream;

  loadDulieu() async {
    orderStream = await CartSnapshot.getAllOrder();
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Có lỗi xảy ra: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Không có đơn hàng nào được đặt"));
            }
            var list = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                var dsHH = list[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tên KH: ${dsHH.cart.tenUser}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Text("Email: ${dsHH.cart.email}", style: TextStyle(fontSize: 16),),
                          Text("SPĐH: ${dsHH.cart.tenSP}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Text("Số lượng: ${dsHH.cart.tenSP}"),
                          Row(
                            children: [
                              Text("Tổng cộng: "),
                              Text(" ${dsHH.cart.tong} VNĐ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () async {
                              await CartSnapshot.updateStatusPr(dsHH.reference.id);
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
              itemCount: snapshot.data!.length,
            );
          },
        )
    );
  }
}
