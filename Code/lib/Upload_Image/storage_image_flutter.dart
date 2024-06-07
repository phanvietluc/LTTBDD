import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadImage({required String imagePath, required List<String> folders, required String fileName}) async{
  // /images/fruits/cam.jpg => folder = ['images', 'fruits'], filename = 'cam.jpg'
  //Đường dẫn trả về
  String downloadUrl;
  //tạo đối tượng firebase storage
  FirebaseStorage _storage = FirebaseStorage.instance;

  //reference lưu thư mục gốc
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);//Để tạo ra một dãy thư mục phân cấp
  reference = reference.child(fileName);//Thiết lập đường dẫn

  //Tạo metadata
  //metadata lưu đúng file ảnh, upload ảnh trả về đường dẫn
  final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {'picked-file-path': imagePath},
  );

  try{
    if(kIsWeb)
      await reference.putData(await XFile(imagePath).readAsBytes(), metadata);//Trên web
    else
      await reference.putFile(File(imagePath), metadata);//Trên thiết bị di động
    downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  }on FirebaseException catch(e){
    print("Lỗi upload ảnh lên firebase ${e.toString()}");
    return Future.error("Lỗi upload File");
  }
}

Future<void> deleteImage({required List<String> folders, required String fileName}) async{
  FirebaseStorage _storage = FirebaseStorage.instance;
  //Thiết lập đường dẫn trên firebase storage
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);
  return reference.delete();
}

