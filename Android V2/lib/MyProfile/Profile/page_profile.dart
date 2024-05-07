import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/myWidget/dropdown_button.dart';
import 'package:viet_luc63132246_flutter/myWidget/radio_button.dart';
import 'package:viet_luc63132246_flutter/myWidget/wrapper_data.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  stringWrapper gioiTinh = stringWrapper(value: "Nam");
  stringWrapper ngy = stringWrapper(value: "Chưa");
  List<String> phepTinhs = ["Cộng", "Trừ", "Nhân", "Chia", "Tích phân", "Đạo hàm", "Tất cả"];
  List<String> MHs = ["CTDLGT", "LTHĐT", "LTTBDĐ", "CSDL", "HQTCSDL"];
  stringWrapper MH = stringWrapper(value: "CTDLGT");
  stringWrapper pt = stringWrapper(value: "Cộng");
  DateTime NgSinh = DateTime(2003, 07, 08);
  int index = 0;
  double size = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Lực"),
                accountEmail: Text("luc2003@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('Images/picture1.jpg'),
                ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  InboxPage(),)
                );
              },
            ),
          ],
        ),
      ),
      body: _buildbody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home, color: Colors.blue,),
              icon: Icon(Icons.home, color: Colors.grey,),
              label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.message, color: Colors.blue,),
            icon: Icon(Icons.message, color: Colors.grey,),
            label: "SMS",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.call, color: Colors.blue,),
            icon: Icon(Icons.call, color: Colors.grey,),
            label: "Phone",
          )
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }//Hàm build

  _buildbody(BuildContext context, int index){
    switch(index){
      case 0: return _buildHome(context);
      case 1: return _buildTax(context);
      case 2: return _buildPhone(context);
    }
  }

  _buildHome(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: size, width: MediaQuery.of(context).size.width,
                child: Image.asset('Images/picture1.jpg'),
              ),
            ),
            SizedBox(height: 10,),
            Text('Họ tên:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('Phan Viết Lực', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),),
            SizedBox(height: 10,),
            Text('Ngày sinh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Row(
              children: [
                Expanded(
                    child: Text("${NgSinh.day}/${NgSinh.month}/${NgSinh.year}", style: TextStyle(fontSize: 20),)),
                IconButton(
                    onPressed: () async {
                      DateTime? d = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2040)
                      );
                      if(d != null)
                        setState(() {
                          NgSinh = d;
                        });
                    },
                    icon: Icon(Icons.calendar_month)
                ),
                SizedBox(width: 10,),
              ],
            ),//Chọn ngày sinh trong lịch có thay đổi
            SizedBox(height: 10,),
            Text('Giới tính', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            MyGroupRadio(lables: ["Nam", "Nữ"], groupValue: gioiTinh,),
            SizedBox(height: 10,),
            Text('Có người yêu chưa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            MyGroupRadio(lables: ["Có", "Chưa"], groupValue: ngy, isHorizaltal: false,),
            SizedBox(height: 10,),
            Text('Quê quán', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('Sông Cầu - Phú Yên', style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text('Sở thích', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('Ngủ', style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text('Phép tính giỏi nhất', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            MyDropDown(value: pt, lables: phepTinhs),
            SizedBox(height: 10,),
            Text('Môn học giỏi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            MyDropDown(
              value: MH,
              lables: MHs,
              itemBuilder: (vale) => Row(
                children: [
                  Icon(Icons.book),
                  Text(vale),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTax(BuildContext context) {
    return Center(
      child: Text("SMS", style: TextStyle(fontSize: 20),),
    );
  }

  _buildPhone(BuildContext context) {
    return Center(
      child: Text("Phone", style: TextStyle(fontSize: 20)),
    );
  }
}
class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Inbox"),
      ),
    );
  }
}






