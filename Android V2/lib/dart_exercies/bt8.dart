Map<String, int> DemTu(String s){
  Map<String, int> outputMap = {};
  List<String> word = s.toLowerCase().split(RegExp("[' ' , . ; : \n \t]+"));
  for(String words in word){
    outputMap[words] = (outputMap[words] ?? 0) + 1;
  }
  outputMap.remove(' ');
  return outputMap;
}

void main(){
  var res = DemTu('Tết, tết tết rồi');
  res.forEach((key, value) {
    print('$key: $value');
  });
}