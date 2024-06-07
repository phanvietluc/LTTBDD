import 'package:flutter/foundation.dart';
class AppGiohangState extends ChangeNotifier{
  List<String> _sp = ['Táo','Mít','Chuối','Xoài','Me','Chôm chôm','Sầu riêng', 'Dâu tây', 'Măng cụt', 'Mận', 'Thanh long'];
  List<String> get sp => _sp;
  List<int> _giohang = [];
  List<int> get giohang => _giohang;
  int get slMatHangTrGioHang => giohang.length;
  void Them(int index){
    if(!KtraMatHangCoTrongGH(index)) {
      giohang.add(index);
      notifyListeners();
    }
  }
  void Loai(int index){
    giohang.removeAt(index);
    notifyListeners();
  }
  bool KtraMatHangCoTrongGH(int index){
    for(int i in giohang)
      if(i == index)
        return true;
    return false;
  }
}