class RssResource{
  String id, name;
  String StartDescriptionRegrex, EndDescriptionRegrex;
  String StartImageRegrex, EndImageRegrex;
  Map<String, String> resourceHeaders;

  RssResource({
    required this.id,
    required this.name,
    required this.StartDescriptionRegrex,
    required this.EndDescriptionRegrex,
    required this.StartImageRegrex,
    required this.EndImageRegrex,
    required this.resourceHeaders,
  });
}

List<RssResource> rssResources = [
  RssResource(
      id: "vnexpress",
      name: "VN Express",
      StartDescriptionRegrex: "</a></br>",
      EndDescriptionRegrex: "",
      StartImageRegrex: '<img src="',
      EndImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ": "https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Thế giới": "https://vnexpress.net/rss/the-gioi.rss",
        "Thể thao": "https://vnexpress.net/rss/the-thao.rss",
        "Giáo dục": "https://vnexpress.net/rss/giao-duc.rss",
        "Đời sống": "https://vnexpress.net/rss/gia-dinh.rss",
      },
  ),
  RssResource(
      id: "dantri", name: "Dân trí",
      StartDescriptionRegrex: "</a></br>",
      EndDescriptionRegrex: "",
      StartImageRegrex: "<img src='",
      EndImageRegrex: "'",
      resourceHeaders: {
        "Trang chủ":"https://dantri.com.vn/rss/home.rss",
        "Thế giới": "https://dantri.com.vn/rss/the-gioi.rss",
        "Thể thao": "https://dantri.com.vn/rss/the-thao.rss",
        "Giáo dục": "https://dantri.com.vn/rss/giao-duc.rss",
        "Đời sống": "https://dantri.com.vn/rss/gia-dinh.rss",
      },
  ),
];