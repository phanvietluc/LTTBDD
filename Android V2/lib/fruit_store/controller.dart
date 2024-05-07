import 'model.dart';
import 'package:get/get.dart';

class SimpleController extends GetxController{
  var _dssp = <Fruit>[];
  final _gh = <GH_Item>[];

  List<Fruit> get dssp => _dssp;
  List<GH_Item> get gh => _gh;
  int get slMatHangGH => gh.length;
  static SimpleController get() => Get.find<SimpleController>();

  @override
  void onInit() {
    _dssp = AppData().dssp;
    update(["listSP"]);// listSP: id của widget hiển thị danh sách sản phẩm
  }

  void themvaoGH(Fruit f, {required List<String> updateWidgetID}){
    for(GH_Item item in gh){
      if(item.idSP == f.id){
        item.sl++;
        return;//Thêm
      }
    }
    gh.add(GH_Item(idSP: f.id, sl: 1));
    update(updateWidgetID);
  }
  void tangSlSp(Fruit f, {required List<String> updateWidgetID}) {
    for (GH_Item item in gh) {
      if (item.idSP == f.id) {
        item.sl++;
        update(updateWidgetID);
        return;
      }
    }
  }

  void giamSlsp(Fruit f, {required List<String> updateWidgetID}) {
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

  void xoaSPkGH(Fruit f, {required List<String> updateWidgetID}) {
    for (GH_Item item in gh) {
      if (item.idSP == f.id) {
        if (item.sl > 1) {
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
      Fruit f = dssp.firstWhere((sp) => sp.id == item.idSP);
      tongmh += item.sl * f.gia;
    }
    return tongmh;
  }
}

//Tách rời controller khỏi giao diện
class FruitStoreBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SimpleController());
  }
}