import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fruit_state.dart';
import 'package:badges/badges.dart' as badges;
import 'package:viet_luc63132246_flutter/page_home.dart';
class AppGioHang extends StatelessWidget {
  const AppGioHang({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppGiohangState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FruitStoreHomePage(),
        ),
    );
  }
}

class FruitStoreHomePage extends StatelessWidget {
  const FruitStoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppGiohangState giohangState = context.watch<AppGiohangState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Store"),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GioHangPage(),)
                );
              },
              child: badges.Badge(
                showBadge: giohangState.slMatHangTrGioHang > 0,
                badgeContent: Text('${giohangState.slMatHangTrGioHang}'),
                child: Icon(Icons.add_shopping_cart_outlined, size: 30,),
              ),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(giohangState.sp[index]),
            trailing: IconButton(
              onPressed: () {
                var giohang = context.read<AppGiohangState>();
                giohang.Them(index);
              },
              icon: giohangState.KtraMatHangCoTrongGH(index) == false ? Icon(Icons.add):Icon(Icons.check),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 1.5,),
        itemCount: giohangState.sp.length,
      ),
    );
  }
}

class GioHangPage extends StatelessWidget {
  const GioHangPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppGiohangState giohangState = context.watch<AppGiohangState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                int idMH = giohangState.giohang[index];
                return ListTile(
                  title: Text("${giohangState.sp[idMH]}"),
                  trailing: IconButton(
                      onPressed: () {
                        var giohang = context.read<AppGiohangState>();
                        giohang.Loai(index);
                      },
                      icon: Icon(Icons.remove_circle_outline),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 1.5,),
              itemCount: giohangState.slMatHangTrGioHang,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tổng số tiền:\t\t\t\t\t\t"),
                Text("${9000*giohangState.slMatHangTrGioHang} VNĐ\t\t\t\t\t"),
                ElevatedButton(
                  onPressed: () {
                    if(giohangState.slMatHangTrGioHang > 0) {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ThanhToan(),)
                      );
                    }else{
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You need add one product!'),
                            duration: Duration(seconds: 5),//Khoảng thời gian tồn tại SnackBar
                            action: SnackBarAction(
                              label: "Close",
                              onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
                            ),
                          ));
                    }
                  },
                  child: Text("Thanh toán")
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ThanhToan extends StatelessWidget {
  const ThanhToan({super.key});

  @override
  Widget build(BuildContext context) {
    AppGiohangState giohangState = context.watch<AppGiohangState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                int idMH = giohangState.giohang[index];
                return ListTile(
                  title: Text("${giohangState.sp[idMH]}"),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 1.5,),
              itemCount: giohangState.slMatHangTrGioHang,
            ),
          ),
          Divider(height: 10, thickness: 1, color: Colors.black,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tổng số tiền:\t\t\t\t\t\t",style: TextStyle(fontSize: 18),),
                    Text("${9000*giohangState.slMatHangTrGioHang} VNĐ\t\t\t\t\t",style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 20,),
                buildButton(context, text: "Thanh toán", destination: OrderSuccess())
                /*InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderSuccess(),)
                    );
                  },
                  child: ContainerButtonModel(
                    Itext: "Thanh toán",
                    bgColor: Colors.blueAccent,
                    containerWidth: MediaQuery.of(context).size.width,
                  )
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Order Success!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          Text("Your order will be delivered soon."),
          Text("Thank you! for chosing my app!"),
          Padding(
            padding: EdgeInsets.all(15),
            child: buildButton(context, text: "Continue Shopping", destination: FruitStoreHomePage())
          )
        ],
      ),
    );
  }
}




