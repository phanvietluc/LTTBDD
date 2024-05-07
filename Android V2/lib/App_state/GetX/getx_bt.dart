import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/BT/Trenlop.dart';
import 'package:viet_luc63132246_flutter/page_home.dart';
class Controller extends GetxController{
  final _count = 0.obs;//Biến _count bao bọc trạng thái
  int get count => _count.value;
  void Tang(){
    _count.value++;
    _count.refresh();//gọi khi sử dụng với các kiểu dữ liệu do người dùng tự định nghĩa
  }
  void Giam(){
    _count.value--;
    _count.refresh();
  }
}
class SimpleCounter extends GetxController{
  int count = 0;//Không cần biến React
  static SimpleCounter get(String? tag) => Get.find(tag: tag);//Định nghĩa property get
  void Increase(){
    count++;
    update(["01"], count <= 10);//Đặt điều kiện để xây dựng lại giao diện (count <= 10)
  }
  void Descrease(){
    count--;
    update(["01"], count <= 10);
  }
}
class PageCounterGetX extends StatelessWidget {
  PageCounterGetX({super.key});
  final c = Get.put(Controller());
  final c1 = Get.find<Controller>();
  final c2 = Get.put(Controller());
  //final c3 = Get.put(Controller(), tag: "c3: ");
  final c3 = Get.put(SimpleCounter(), tag: "Demo1");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter GetX"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  c.Tang();
                  SimpleCounter.get("my_simple_state").Increase();
                  //c3.Tang();
                },
                child: Text("+")
            ),
            GetX<Controller>(
                builder: (controller) => Text("${c.count}",style: TextStyle(fontSize: 20),), //controller = giá trị được put vào
            ),
            Obx(() => Text("c: ${c.count}")),
            Obx(() => Text("c1: ${c1.count}")),
            Obx(() => Text("c2: ${c2.count}")),
            GetBuilder(
              init: SimpleCounter(),//Tương tự như Get.put()
              id: "01",
              tag: "my_simple_state",//Phải trùng với tag của SimpleCounter ở SimpleCounter.get("my_simple_state").Increase();
              builder: (controller) => Text("${controller.count}"),
            ),
            GetBuilder(
              init: c3,//Khai báo final c3 = Get.put(SimpleCounter(), tag: "Demo1");
              id: "01",
              builder: (controller) => Text("${controller.count}"),
            ),
            /*GetX<Controller>(
              tag: "c3: ",
              builder: (controller) => Text("${c3.count}",style: TextStyle(fontSize: 20),)
            ),*/
            ElevatedButton(
                onPressed: () {
                  c.Giam();
                  SimpleCounter.get("my_simple_state").Descrease();
                  //c3.Giam();
                },
                child: Text("-")
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(Demo());
                },
                child: Text("To New App")
            ),
            ElevatedButton(
                onPressed: () {
                  Get.off(PageHome());
                },
                child: Text("Back to My App")
            ),
          ],
        ),
      ),
    );
  }
}
