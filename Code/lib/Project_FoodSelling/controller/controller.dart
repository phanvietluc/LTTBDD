import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_categories.dart';
class FoodController extends GetxController{
  var _ds = <Food>[];
  var _ct = <Categories>[];
  final _gh = <GH_Item>[];
  List<Food> get ds => _ds;
  List<Categories> get ct => _ct;
  List<GH_Item> get gh => _gh;
  int get slMatHangGH => gh.length;
  static FoodController get() => Get.find<FoodController>();


  @override
  void onReady() {
    super.onReady();
    docDL();
    docDL1();
  }

  Future<void> docDL() async{
    var list = await FoodSnapshot.getALL2();
    _ds = list.map((foodSmap) => foodSmap.food).toList();
    update(["listSP"]);
  }
  Future<void> docDL1() async{
    var list = await CategorySnapshot.getALL2();
    _ct = list.map((cateSmap) => cateSmap.categories).toList();
    update(["listCate"]);
  }
}

class FoodSellingBinlding extends Bindings{

  @override
  void dependencies() {
    Get.put(FoodController());
  }
}