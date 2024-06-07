import 'package:url_launcher/url_launcher.dart';

Future<bool> openPhoneDial(String phoneNumber) async{
  bool check = await canLaunch('tel:${phoneNumber}');
  if(check ==false)  return false;
  else  return launch('tel:${phoneNumber}');
}

Future<bool> openSMS(String phoneNumber) async{
  bool check = await canLaunch('sms:${phoneNumber}');
  if(check ==false)  return false;
  else  return launch('sms:${phoneNumber}');
}

