void main(){
  List<String> list = ['Nha Trang', 'TP HCM', 'Ha Noi', 'Hue'];
  List<int> cd = list.map(
       (e) => e.length
  ).toList();
  print(list);
  print(cd);
  print('');
  list.forEach((element) => print(element));
  List<int> bp = cd.map((e) => e*e).toList();
  print(bp);
}