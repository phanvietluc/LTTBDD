import 'package:cloud_firestore/cloud_firestore.dart';

class Food{
  String id, ten, cateid;
  String? mota, anh;
  int gia;

  Food({required this.id, required this.ten, required this.cateid, this.mota, this.anh, required this.gia});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'cateid': this.cateid,
      'mota': this.mota,
      'anh': this.anh,
      'gia': this.gia,
    };
  }

  factory Food.fromJson(Map<String, dynamic> map) {
    return Food(
      id: map['id'] as String,
      ten: map['ten'] as String,
      cateid: map['cateid'] as String,
      mota: map['mota'] as String,
      anh: map['anh'] as String,
      gia: map['gia'] as int,
    );
  }
}

class FoodSnapshot{
  Food food;
  DocumentReference reference;
  FoodSnapshot({required this.food, required this.reference});

  factory FoodSnapshot.fromMap(DocumentSnapshot docsnap){
    return FoodSnapshot(
        food: Food.fromJson(docsnap.data() as Map<String, dynamic>),
        reference: docsnap.reference
    );
  }

  static Future<DocumentReference> them(Food food) async{
    return FirebaseFirestore.instance.collection("Food").add(food.toJson());
  }

  Future<void> capNhat(Food food) async{
    return reference.update(food.toJson());
  }

  Future<void> xoa() async{
    return reference.delete();
  }

  static Stream<List<FoodSnapshot>> getALL(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Food").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => FoodSnapshot.fromMap(docSnap)
        ).toList());
  }

  static Future<List<FoodSnapshot>> getALL2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Food").get();
    return qs.docs.map(
            (docSnap) => FoodSnapshot.fromMap(docSnap)
    ).toList();
  }
}