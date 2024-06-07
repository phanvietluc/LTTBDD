import 'package:viet_luc63132246_flutter/nss/model/rss_resource.dart';

class RSSItem{
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  RSSItem.empty();//Khởi tạo thuộc tính chưa khởi tạo

  RSSItem getRssItemFromJson(Map<String, dynamic> json,{required RssResource r}){
    title = json["title"];
    pubDate = json["pubDate"];
    link = json["link"];
    description = _getDescription(json["description"] as String, r: r);
    imageUrl = _getImageUrl(json["description"] as String, r: r);
    return this;
  }

  String _getDescription(String rawDescription, {required RssResource r}){
    //Lấy dấu hiệu bắt đầu và kết thúc
    String startRegrex = r.StartDescriptionRegrex;
    String endRegrex = r.EndDescriptionRegrex;
    int start = rawDescription.indexOf(startRegrex) + startRegrex.length;// startRegrex.length là bắt đầu của từ đầu tiên trong thẻ <br>, nếu không có start = -1
    if(start >= startRegrex.length){
      //endRegrex.length > 0 có pattern kết thúc ngược lại lấy toàn bộ
      if(endRegrex.length > 0){
        int end = rawDescription.indexOf(endRegrex, start);//Giới hạn không gian tìm kiếm bắt đầu từ start kết thúc endRegrex
        return rawDescription.substring(start, end);
      }
      return rawDescription.substring(start);
    }
    return "";
  }

  //Ảnh được phép null -> không có ảnh
  String? _getImageUrl(String rawImage, {required RssResource r}){
    //Lấy dấu hiệu bắt đầu và kết thúc
    String startRegrex = r.StartImageRegrex;
    String endRegrex = r.EndImageRegrex;
    int start = rawImage.indexOf(startRegrex) + startRegrex.length;// startRegrex.length là bắt đầu của từ đầu tiên trong thẻ <br>, nếu không có start = -1
    if(start >= startRegrex.length){
      //endRegrex.length > 0 có pattern kết thúc ngược lại lấy toàn bộ
      if(endRegrex.length > 0){
        int end = rawImage.indexOf(endRegrex, start);//Giới hạn không gian tìm kiếm bắt đầu từ start kết thúc endRegrex
        return rawImage.substring(start, end);
      }
      return rawImage.substring(start);
    }
    return null;
  }
}