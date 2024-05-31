import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/admin/page_capnhat.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/admin/page_chitiet_sp.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model.dart';
import 'package:viet_luc63132246_flutter/widget/widget_connect_firebase.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:viet_luc63132246_flutter/widget/snackbar.dart';
class FoodSellAdmin extends StatelessWidget {
  const FoodSellAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      ErrorMessege: "Lỗi kết nối...",
      ConnectMessege: "Đang kết nối",
      builder: (context) => PageDSSP_Admin(),
    );
  }
}

class PageDSSP_Admin extends StatelessWidget {
  const PageDSSP_Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DSSP Admin",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<FoodSnapshot>>(
          stream: FoodSnapshot.getALL(),
          builder: (context, snapshot) {
            if(snapshot.hasError)
              return Center(
                child: Text("Lỗi khi kết nối"),
              );
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var list = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(thickness: 1.5,),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var fsn = list[index];
                return Slidable(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image.network(fsn.food.anh!)
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID: ${fsn.food.id}"),
                                Text("Tên: ${fsn.food.ten}"),
                                Text("Giá: ${fsn.food.gia}"),
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    extentRatio: 0.7,
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.blueAccent,
                        icon: Icons.edit,
                        label: 'Cập nhật',
                        onPressed: (context) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PageCapNhatSP_Admin(foodSnapshot: fsn),)
                          );
                        },
                      ),
                      SlidableAction(
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Xóa',
                        onPressed: (context) {
                          fsn.xoa();
                          showmySnackBar(context, "Xóa thành công", 2);
                        },
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>  PageChiTietSP_Admin(),)
          );
        },
      ),
    );
  }
}

