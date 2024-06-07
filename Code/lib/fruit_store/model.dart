import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
Map<String, String>images = {
  "xoai":"https://product.hstatic.net/1000242281/product/14_master.jpg",
  "mit":"https://dacsanbay.com/wp-content/uploads/2021/12/mit-viet-nam-600x600.jpg",
  "saurieng":"https://bizweb.dktcdn.net/100/347/970/products/sau-rieng-6-ri-bbg.jpg?v=1564138907510",
  "chomchom":"https://bizweb.dktcdn.net/thumb/grande/100/475/702/products/chom-chom-nhan.png?v=1682103428280",
  "oi":"https://anhsangvietnhat.com/wp-content/uploads/2021/08/o%CC%82%CC%89i-xa%CC%81-li%CC%A3.jpeg",
  "mangcut":"https://cdn-images.kiotviet.vn/faifodn/8997c58f0a204ab481961da05627db1a.jpg",
  "tao":"https://sieuthivivo.com/wp-content/uploads/2020/02/tao-gala-my-1-compress-compress-compress-compress-compress.jpg",
  "le":"https://caycanhhaidang.com/wp-content/uploads/2016/09/Cay-Le-Vang-5.jpg",
  "cam":"https://product.hstatic.net/200000281397/product/upload_01576fda6c284a84bafec3cf31c7fc14.jpg",
  "thanhlong":"https://anviemex.com/wp-content/uploads/2021/06/anh-dai-dien-thanh-long-tr%C4%83ng.jpg",
};

//Lớp mô tả dữ liệu
class Fruit{
  String id, ten;
  int gia;
  String? anh;
  String? mota;
  Fruit({required this.id, required this.ten, required this.gia, this.anh, this.mota});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'gia': this.gia,
      'anh': this.anh,
      'mota': this.mota,
    };
  }

  factory Fruit.fromJson(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as String,
      ten: map['ten'] as String,
      gia: map['gia'] as int,
      anh: map['anh'] as String,
      mota: map['mota'] as String,
    );
  }
}
class GH_Item{
  String idSP;
  int sl;
  GH_Item({required this.idSP, required this.sl});
}
//Lớp truy cập dữ liệu
class FruitSnapshot{
  Fruit fruit;
  DocumentReference ref;

  FruitSnapshot({required this.fruit, required this.ref});
  factory FruitSnapshot.fromMap(DocumentSnapshot docSnap){
    return FruitSnapshot(
        fruit: Fruit.fromJson(docSnap.data() as Map<String, dynamic>),
        ref: docSnap.reference
    );
  }

  //Static vì không ảnh hưởng đến dữ liệu sẵn có
  static Future<DocumentReference> them(Fruit fruit) async{
    return FirebaseFirestore.instance.collection("Fruits").add(fruit.toJson());
  }

  Future<void> capNhat(Fruit fruit) async{
    return ref.update(fruit.toJson());
  }

  Future<void> xoa() async{
    return ref.delete();
  }

  //Truy vấn theo thời gian thực
  static Stream<List<FruitSnapshot>> getALL(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Fruits").snapshots();//Truy vấn kiểu Stream dùng snapshots()
    //Đỏi kiểu dữ liệu QuerySnapshot -> List
    return sqs.map(
      (qs) => qs.docs.map(
        (docSnap) => FruitSnapshot.fromMap(docSnap)
      ).toList());//sqs.map để chuyển QuerySnapshot -> List, docSnap.map Chuyển sang kiểu FruitSnapshot
  }

  //Truy vấn dữ liệu 1 lần
  static Future<List<FruitSnapshot>> getALL2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Fruits").get();//Truy vấn kiểu Future dùng get()
    return qs.docs.map(
            (docSnap) => FruitSnapshot.fromMap(docSnap)
    ).toList();
  }
}

class AppData{
  final List<Fruit> _dssp = [
    Fruit(id: "01", ten: "Xoài", gia: 45000, anh: images["xoai"], mota: "Xoài cát Hoài Lộc loại 1"),
    Fruit(id: "02", ten: "Mít", gia: 40000, anh: images["mit"], mota: "Mít"),
    Fruit(id: "03", ten: "Sầu riêng", gia: 100000, anh: images["saurieng"], mota: "Sầu riêng Khánh Sơn"),
    Fruit(id: "04", ten: "Chôm chôm", gia: 25000, anh: images["chomchom"], mota: "Chôm Chôm"),
    Fruit(id: "05", ten: "Ổi", gia: 20000, anh: images["oi"], mota: "Ổi"),
    Fruit(id: "06", ten: "Măng cụt", gia: 50000, anh: images["mangcut"], mota: "Măng cụt"),
    Fruit(id: "07", ten: "Táo", gia: 25000, anh: images["tao"], mota: "Táo Việt Nam"),
    Fruit(id: "08", ten: "Lê", gia: 26000, anh: images["le"], mota: "Lê Việt Nam"),
    Fruit(id: "09", ten: "Cam", gia: 35000, anh: images["cam"], mota: "Cam Vĩnh Long"),
    Fruit(id: "10", ten: "Thanh long", gia: 30000, anh: images["thanhlong"], mota: "Thanh long Phan Thiết"),
  ];
  List<Fruit> get dssp => _dssp;
}