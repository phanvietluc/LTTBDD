import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_categories.dart';

class SimpleController1 extends GetxController{
  var _ds = <Categories>[];
  List<Categories> get ds => _ds;
  static SimpleController1 get() => Get.find<SimpleController1>();

  @override
  void onReady() {
    super.onReady();
    docDL();
  }

  Future<void> docDL() async{
    var list = await CategorySnapshot.getALL2();
    _ds = list.map((CateSmap) => CateSmap.categories).toList();
    update(["listCate"]);
  }
}

class CategoriesBinlding extends Bindings{

  @override
  void dependencies() {
    Get.put(SimpleController1());
  }
}