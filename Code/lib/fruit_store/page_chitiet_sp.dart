import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viet_luc63132246_flutter/Upload_Image/storage_image_flutter.dart';
import 'package:viet_luc63132246_flutter/fruit_store/model.dart';
import 'package:viet_luc63132246_flutter/widget/snackbar.dart';
class PageChiTietSP_Admin extends StatefulWidget {
  const PageChiTietSP_Admin({super.key});

  @override
  State<PageChiTietSP_Admin> createState() => _PageChiTietSP_AdminState();
}

class _PageChiTietSP_AdminState extends State<PageChiTietSP_Admin> {
  XFile? _xFile;
  String? url;//Đường dẫn của ảnh
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMota = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm mới sản phẩm trái cây", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: w * 0.8,
                  height: w * 0.8 * 2/3,
                  child: _xFile == null? Icon(Icons.image):Image.file(File(_xFile!.path)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ElevatedButton(
                        onPressed: () async{
                          //ImagePicker lấy dữ liệu từ bộ nhớ ngoài
                          _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);//gallery để chọn file từ tệp
                          if(_xFile != null)
                            setState(() {
                            });
                        },
                        child: Text("Chọn ảnh")
                    ),
                  ),
                ],
              ),
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                  labelText: "Id",
                ),
              ),
              TextField(
                controller: txtTen,
                decoration: InputDecoration(
                  labelText: "Tên",
                ),
              ),
              TextField(
                controller: txtGia,
                decoration: InputDecoration(
                  labelText: "Giá",
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtMota,
                decoration: InputDecoration(
                  labelText: "Mô tả",
                ),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ElevatedButton(
                        onPressed: () async{
                          if(_xFile != null){
                            showmySnackBar(context, "Đang thêm sản phẩm ...", 7);
                            url = await uploadImage(imagePath: _xFile!.path, folders: ["AppFruitStore"], fileName: "${txtTen.text}.jpg");
                            if(url != null){
                              Fruit f = Fruit(
                                  id: txtId.text,
                                  ten: txtTen.text,
                                  gia: int.parse(txtGia.text),
                                  mota: txtMota.text,
                                  anh: url
                              );
                              FruitSnapshot.them(f).then(
                                (value) => showmySnackBar(context, "Thêm sản phẩm ${txtTen.text} thành công", 5)
                              ).catchError((error){
                                showmySnackBar(context, "Thêm không thành công", 5);
                              });
                            }
                          }
                        },
                        child: Text("Thêm")
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
