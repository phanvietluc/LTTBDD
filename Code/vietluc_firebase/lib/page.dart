import 'package:flutter/material.dart';
import 'model.dart';
class PageSV extends StatelessWidget {
  const PageSV({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream: SinhVienSnapshot.getALL(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text("Lỗi");
          }
          else {
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            var list = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index) => Text("${list[index].sv.ten}"),
                separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                itemCount: list.length
            );
          }
        },
      ),
    );
  }
}
