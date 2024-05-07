import 'package:flutter/material.dart';
import 'class_data.dart';


class PageListPhoto extends StatefulWidget {
  const PageListPhoto({super.key});

  @override
  State<PageListPhoto> createState() => _PageListPhotoState();
}

class _PageListPhotoState extends State<PageListPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Photo'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Photo>>(
        future: gethtttpContent(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: (
                  Text("Loi doc du lieu",style: TextStyle(color: Colors.red),)
              ),
            );
          }
          else if(snapshot.hasData){
            List<Photo> list = snapshot.data!;
            return GridView.extent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: list.map(
                        (photo) => Image.network(photo.url!)
                ).toList()
            );
          }else{
            return Center(child: CircularProgressIndicator(),);//Vòng tròn quay loading
          }
        },
      ),
    );
  }
}

