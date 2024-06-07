import 'package:flutter/material.dart';
import 'Profile/page_profile.dart';
class Page_Home extends StatelessWidget {
  const Page_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
             /* Container(
                width: 180,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },
                    child: Text('My Profile'),
                ),
              ),*/
              buildButton(context, text: 'My Profile', destination: MyProfile())
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
    child: ElevatedButton(
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Text(text),
    ),
  );
}
