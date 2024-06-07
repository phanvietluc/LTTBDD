import '../model/model_categories.dart';
import '../model/model_food.dart';
import 'package:get/get.dart';
class FoodController extends GetxController{
  var _ds = <Food>[];
  var _ct = <Categories>[];
  List<Food> get ds => _ds;
  List<Categories> get ct => _ct;
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