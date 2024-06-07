import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viet_luc63132246_flutter/Upload_Image/storage_image_flutter.dart';
import 'package:viet_luc63132246_flutter/widget/widget_connect_firebase.dart';
class StorageApp extends StatelessWidget {
  const StorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        ErrorMessege: "Lỗi",
        ConnectMessege: "Đang kết nối",
        builder: (context) => PageStorageTest(),
    );
  }
}

class PageStorageTest extends StatefulWidget {
  const PageStorageTest({super.key});

  @override
  State<PageStorageTest> createState() => _PageStorageTestState();
}

class _PageStorageTestState extends State<PageStorageTest> {
  XFile? _xFile;
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Storage Text"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 200,
              child: _xFile == null? Icon(Icons.image):Image.file(File(_xFile!.path)),
            ),
          ),
          ElevatedButton(
              onPressed: () async{
                //ImagePicker lấy dữ liệu từ bộ nhớ ngoài
                _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);//gallery để chọn file từ tệp
                if(_xFile != null)
                  setState(() {

                  });
              },
              child: Text("Chọn ảnh")
          ),
          ElevatedButton(
              onPressed: () async{
                url = await uploadImage(imagePath: _xFile!.path, folders: ["Test!!!"], fileName: "Fruit.jpg");
                if(url != null)
                  setState(() {

                  });
              },
              child: Text("Upload")
          ),
          ElevatedButton(
              onPressed: () {
                deleteImage(folders: ["Test!!!"], fileName: "Fruit.jpg");
              },
              child: Text("Delete")
          ),
          Text(url??"No url")
        ],
      ),
    );
  }
}
