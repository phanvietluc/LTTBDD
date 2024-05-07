import 'package:flutter/foundation.dart';
//Dell, Asus...
class CounterChangeNotifier extends ChangeNotifier{
  int counter = 0;// Trạng thái cần quản lý
  void Tang(){
    counter++;
    notifyListeners();
  }
  void Giam(){
    counter--;
    notifyListeners();
  }
}