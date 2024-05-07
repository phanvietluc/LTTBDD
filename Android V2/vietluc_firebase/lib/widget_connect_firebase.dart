import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
class MyFirebaseConnect extends StatefulWidget {
  final String ErrorMessege;
  final String ConnectMessege;
  final Widget Function(BuildContext context) builder;
  const MyFirebaseConnect({
    required this.ErrorMessege,
    required this.ConnectMessege,
    required this.builder, super.key});

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool KetNoi = false;
  bool Loi = false;
  @override
  Widget build(BuildContext context) {
    if(Loi){
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(widget.ErrorMessege,
            style: TextStyle(fontSize: 16, color: Colors.red,),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    }else{
      if(!KetNoi){
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(widget.ConnectMessege,
                style: TextStyle(fontSize: 16,),
                textDirection: TextDirection.ltr,
              )
            ],
          )
        );
      }else{
        return widget.builder(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _KhoiTaoFirebase();
  }

  _KhoiTaoFirebase(){
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then(
          (value) {
            setState(() {
              KetNoi = true;
            });
          },
    ).catchError((error){
      print(error);
      setState(() {
        Loi = true;
      });
    });
  }
}
