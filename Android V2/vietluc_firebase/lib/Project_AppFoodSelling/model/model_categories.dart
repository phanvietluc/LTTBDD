import 'package:cloud_firestore/cloud_firestore.dart';
class Categories{
  String ten, id;

  Categories({required this.ten, required this.id});
  static Categories empty() => Categories(ten: "", id: "");

  Map<String, dynamic> toJson() {
    return {
      'ten': this.ten,
      'id': this.id,
    };
  }

  factory Categories.fromJson(Map<String, dynamic> map) {
    return Categories(
      ten: map['ten'] as String,
      id: map['id'] as String,
    );
  }
}
class CategorySnapshot{
  Categories categories;
  DocumentReference reference;
  CategorySnapshot({required this.categories, required this.reference});

  factory CategorySnapshot.fromMap(DocumentSnapshot docsnap){
    return CategorySnapshot(
        categories: Categories.fromJson(docsnap.data() as Map<String, dynamic>),
        reference: docsnap.reference
    );
  }

  static Future<DocumentReference> them(Categories categories) async{
    return FirebaseFirestore.instance.collection("FoodCategories").add(categories.toJson());
  }

  Future<void> capNhat(Categories categories) async{
    return reference.update(categories.toJson());
  }

  Future<void> xoa() async{
    return reference.delete();
  }

  static Stream<List<CategorySnapshot>> getALL(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("FoodCategories").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => CategorySnapshot.fromMap(docSnap)
        ).toList());
  }

  static Future<List<CategorySnapshot>> getALL2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("FoodCategories").get();
    return qs.docs.map(
            (docSnap) => CategorySnapshot.fromMap(docSnap)
    ).toList();
  }
}