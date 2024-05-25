import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'model_categories.dart';
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


  void themvaoGH(Food f, {required List<String> updateWidgetID}){
    for(GH_Item item in gh){
      if(item.idSP == f.id){
        item.sl++;
        return;//Thêm
      }
    }
    gh.add(GH_Item(idSP: f.id, sl: 1));
    update(updateWidgetID);
  }
  void tangSlSp(Food f, {required List<String> updateWidgetID}) {
    for (GH_Item item in gh) {
      if (item.idSP == f.id) {
        item.sl++;
        update(updateWidgetID);
        return;
      }
    }
  }

  void giamSlsp(Food f, {required List<String> updateWidgetID}) {
    for (GH_Item item in gh) {
      if (item.idSP == f.id) {
        if (item.sl > 1) {
          item.sl--;
        } else {
          gh.remove(item);
        }
        update(updateWidgetID);
        return;
      }
    }
  }

  void xoaSPkGH(Food f, {required List<String> updateWidgetID}) {
    for (GH_Item item in gh) {
      if (item.idSP == f.id) {
        if (item.sl >= 1) {
          gh.remove(item);
        }
        update(updateWidgetID);
        return;
      }
    }
  }


  double Tong(){
    double tongmh = 0;
    for(GH_Item item in gh){
      Food f = ds.firstWhere((sp) => sp.id == item.idSP);
      tongmh += item.sl * f.gia;
    }
    return tongmh;
  }
}

class FoodSellingBinlding extends Bindings{

  @override
  void dependencies() {
    Get.put(FoodController());
  }
}