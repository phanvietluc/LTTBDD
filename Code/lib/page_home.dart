import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/admin/page_admin.dart';
import 'MyProfile/Profile/page_profile.dart';
import 'BT/Trenlop.dart';
import 'BT/BT2.dart';
import 'BT/form_list/Form.dart';
import 'PhoneSMS/phone_input.dart';
import 'Upload_Image/ storage/page_storage_test.dart';
import 'fruit_store/page_home_fruit.dart';
import 'provider_state/page_counter.dart';
import 'App_state/List_provider/giohang_app.dart';
import 'App_state/GetX/getx_bt.dart';
import 'BT/GridView.dart';
import 'Json_data/page_list_photo.dart';
import 'nss/page/page_rss_simple.dart';
import 'fruit_store/page_dssp_admin.dart';
import 'Project_FoodSelling/AuthPage/auth_page.dart';
class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildButton(context, text: 'My Profile', destination: MyProfile()),
              buildButton(context, text: 'BT TL', destination: Demo()),
              buildButton(context, text: 'PageListSeperated', destination: PageList()),
              buildButton(context, text: 'PageListBuilder', destination: PageListBuild()),
              buildButton(context, text: 'Grid View Count', destination: GridViewCount()),
              buildButton(context, text: 'Grid View Extend', destination: GridViewExtend()),
              buildButton(context, text: 'Form', destination: BTForm()),
              buildButton(context, text: 'Provider Counter', destination: PageProvider()),
              buildButton(context, text: "Fruit Store", destination: AppGioHang()),
              buildButton(context, text: "GetX Counter", destination: PageCounterGetX()),
              buildButton(context, text: "App Fruit Store", destination: AppFruitStore()),
              buildButton(context, text: "Page Fruit Store Admin", destination: FruitStoreAdmin()),
              buildButton(context, text: 'List Photo', destination: PageListPhoto()),
              buildButton(context, text: "Page RSS", destination: RssApp()),
              buildButton(context, text: "Firebase Storage Demo", destination: StorageApp()),
              buildButton(context, text: "LoginFoodSell", destination: AuthPage()),
              buildButton(context, text: "Page Food Admin", destination: PageAdmin()),
              buildButton(context, text: "Phone", destination: PhoneInput()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildButton(BuildContext context, {required String text, required Widget destination}){
  double w = MediaQuery.of(context).size.width;
  return Container(
    width: w,
    child: Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: ElevatedButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Text(text),
      ),
    ),
  );
}
