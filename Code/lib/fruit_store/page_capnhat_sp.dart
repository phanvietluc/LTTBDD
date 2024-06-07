import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viet_luc63132246_flutter/Upload_Image/storage_image_flutter.dart';
import 'package:viet_luc63132246_flutter/fruit_store/model.dart';
import 'package:viet_luc63132246_flutter/widget/snackbar.dart';
class PageCapNhatSP_Admin extends StatefulWidget {
  FruitSnapshot fruitSnapshot;
  PageCapNhatSP_Admin({required this.fruitSnapshot, super.key});

  @override
  State<PageCapNhatSP_Admin> createState() => _PageCapNhatSP_AdminState();
}

class _PageCapNhatSP_AdminState extends State<PageCapNhatSP_Admin> {
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
        title: Text("Cập nhật sản phẩm trái cây", style: TextStyle(fontWeight: FontWeight.bold),),
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
                  child: _xFile == null? Image.network(widget.fruitSnapshot.fruit.anh!):Image.file(File(_xFile!.path)),
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
                          Fruit f = Fruit(
                              id: txtId.text,
                              ten: txtTen.text,
                              gia: int.parse(txtGia.text),
                              mota: txtMota.text,
                          );
                          if(_xFile != null){
                            url = await uploadImage(imagePath: _xFile!.path, folders: ["AppFruitStore"], fileName: "${txtTen.text}.jpg");
                            if(url != null){
                              f.anh = url;
                              showmySnackBar(context, "Đang cập nhật sản phẩm ...", 7);
                              widget.fruitSnapshot.capNhat(f).then(
                                      (value) => showmySnackBar(context, "Cập nhật sản phẩm ${txtTen.text} thành công", 5)
                              ).catchError((error){
                                showmySnackBar(context, "Cập nhật không thành công", 5);
                              });
                            }
                          }else {
                            f.anh = widget.fruitSnapshot.fruit.anh;
                            showmySnackBar(context, "Đang cập nhật sản phẩm ...", 7);
                            widget.fruitSnapshot.capNhat(f).then(
                                    (value) => showmySnackBar(context, "Cập nhật sản phẩm ${txtTen.text} thành công", 5)
                            ).catchError((error) {
                              showmySnackBar(
                                  context, "Cập nhật không thành công", 5);
                            });
                          }
                        },
                        child: Text("Cập nhật")
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

  @override
  void initState() {
    txtId.text = widget.fruitSnapshot.fruit.id;
    txtTen.text = widget.fruitSnapshot.fruit.ten;
    txtGia.text = widget.fruitSnapshot.fruit.gia.toString();
    txtMota.text = widget.fruitSnapshot.fruit.mota??"";
    url = widget.fruitSnapshot.fruit.anh;
  }
}

