import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/nss/model/rss_item_template.dart';
import 'package:viet_luc63132246_flutter/nss/model/rss_resource.dart';
import 'package:http/http.dart' as http;

class SimpleControllerRSS extends GetxController{
  List<RssResource> _resource = rssResources;
  RssResource _current = rssResources[0];
  List<RSSItem> _rssItem = [];
  late String url;

  List<RSSItem> get rssItem => _rssItem;
  String get resourceName => _current.name;
  static SimpleControllerRSS get instance => Get.find<SimpleControllerRSS>();

  @override
  void onInit() {
    super.onInit();
    url = _current.resourceHeaders.values.toList()[0];
  }

  //Gọi lớp để chạy chương trình
  @override
  void onReady() {
    super.onReady();
    readRss();
  }

  Future<void> readRss() async{
    _fetchRss().then(
      (value) {
        _rssItem = value.map(
          (e) => RSSItem.empty().getRssItemFromJson(e, r: _current)
        ).toList();
        update(["listRss"]);
      },
    ).catchError(
        (error){
          print("Lỗi đọc RSS: " + error);
        }
    );
  }

  Future<List<dynamic>> _fetchRss() async{
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if(response.statusCode == 200){
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(utf8.decode(response.bodyBytes));
      String rssString = xml2json.toParker();
      var rssJson = jsonDecode(rssString);
      return rssJson["rss"]["channel"]["item"];
    }
    return Future.error("Lỗi đọc dữ liệu");
  }
}



class RssBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(SimpleControllerRSS());
  }
}