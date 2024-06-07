import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final auth = FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }
  Future SignOut() async{
    await FirebaseAuth.instance.signOut();
  }
}