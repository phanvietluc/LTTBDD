import 'dart:convert';
import 'package:http/http.dart' as http;

//{
//"albumId": 1,
//"id": 1,
//"title": "accusamus beatae ad facilis cum similique qui sunt",
//"url": "https://via.placeholder.com/600/92c952",
//"thumbnailUrl": "https://via.placeholder.com/150/92c952"
//},

class Photo{
  int? albumId, id;
  String? title, url, thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Map<String, dynamic> toMap() {
    return {
      'albumId': this.albumId,
      'id': this.id,
      'title': this.title,
      'url': this.url,
      'thumbnailUrl': this.thumbnailUrl,
    };
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

Future<List<Photo>> gethtttpContent() async{
  List<Photo>? listphoto;
  Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/photos');
  final http.Response response = await http.get(uri);
  if(response.statusCode == 200){
    List<dynamic> list = jsonDecode(response.body) as List;
    listphoto = list.map((e) => Photo.fromJson(e)).toList();
    return listphoto;
  }else{
    print("Khong tai duoc album");
    return Future.error("Khong tai duoc album");
  }
}
