import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String tet = "Het tet";
  TextEditingController nameEditing = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('63.HTTT'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(tet, style: TextStyle(color: Colors.red, fontSize: 30.0),),
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    if(tet == 'Het tet') tet = 'Tet den roi';
                    else tet = 'Het tet';
                  });
                },
                child: Icon(Icons.home),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow,),
                Icon(Icons.star, color: Colors.yellow,),
                Icon(Icons.star, color: Colors.yellow,),
                Icon(Icons.star_half, color: Colors.yellow,),
                Icon(Icons.star,color: Colors.grey,),
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('This is SnackBar'),
                        duration: Duration(seconds: 30),//Khoảng thời gian tồn tại SnackBar
                        action: SnackBarAction(
                          label: "Close",
                          onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
                        ),
                      ));
                },
                child: Text('Show SnackBar!')),
            TextField(
              controller: nameEditing,
              decoration: InputDecoration(
                labelText: "Tên",
                hintText: "Nhập tên vào đây",
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Welcome ${nameEditing.text}!"),
                        duration: Duration(seconds: 5),
                    ));
                },
                child: Text('Submit')),
          ],
        ),
      )
    );
  }
}
