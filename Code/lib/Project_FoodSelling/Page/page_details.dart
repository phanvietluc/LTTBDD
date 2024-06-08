import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/userdatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_cart.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_user.dart';

class PageDetail extends StatefulWidget {
  final Food f;
  PageDetail({required this.f, super.key});

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  int a = 1, total = 0;
  String? name, email, id;

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        var userDoc = await UserSnapshot.getUser1(user.uid);
        setState(() {
          id = userDoc.user.id;
          email = userDoc.user.email;
          name = userDoc.user.ten;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    total = int.parse(widget.f.gia.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 50, bottom: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: widget.f.anh == null ? Icon(Icons.image_not_supported) : Image.network(widget.f.anh!),
            ),
            Text("${widget.f.ten}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Số lượng:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (a > 1) {
                            --a;
                            total = total - int.parse(widget.f.gia.toString());
                          }
                          setState(() {});
                        },
                        child: Icon(Icons.remove_circle),
                      ),
                      SizedBox(width: 20.0),
                      Text("$a", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(width: 20.0),
                      GestureDetector(
                        onTap: () {
                          ++a;
                          total = total + int.parse(widget.f.gia.toString());
                          setState(() {});
                        },
                        child: Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("${widget.f.mota}", style: TextStyle(fontSize: 18)),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Giá", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("${total} VNĐ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Đặt hàng?"),
                            content: Text("${widget.f.ten}\nSố lượng: $a\nTổng: $total VNĐ"),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  dathang();
                                  Navigator.pop(context);
                                },
                                child: Text("Có"),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Không"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text("Đặt hàng", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Icon(Icons.add_shopping_cart, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dathang() async {
    Cart cart = Cart(
      idUser: id!,
      tenUser: name!,
      email: email!,
      tenSP: widget.f.ten,
      anhsp: widget.f.anh!,
      sl: a,
      tong: total,
      trangthai: "Đang giao hàng"
    );
    CartSnapshot.themOrder(cart).then(
      (value) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Text("Đặt hàng thành công"),
              ],
            ),
          ),
        );
        Navigator.pop(context);
      },
    ).catchError((error){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              Text("Đặt hàng không thành công"),
            ],
          ),
        ),
      );
      Navigator.pop(context);
    });;
  }
}
