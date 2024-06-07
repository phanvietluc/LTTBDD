import 'dart:math';

Future<int> lateNum() async{
  int num  = await Future.delayed(
    Duration(seconds: 5),
      () => 3,
  );
  return num;
}
void main() async{
  /*print('Doi1....');
  int num = await lateNum();
  print(num);
  print('Tam biet');
  print('Doi2....');
  lateNum().then((value){
    print(value);
  },);
  print('Tam biet');*/
  var futuree = Future<int>.delayed(
      Duration(seconds: 3),
      () => 5,
  );
  print(futuree);
}