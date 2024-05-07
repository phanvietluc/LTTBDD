Map<String, String>images = {
  "xoai":"https://product.hstatic.net/1000242281/product/14_master.jpg",
  "mit":"https://dacsanbay.com/wp-content/uploads/2021/12/mit-viet-nam-600x600.jpg",
  "saurieng":"https://bizweb.dktcdn.net/100/347/970/products/sau-rieng-6-ri-bbg.jpg?v=1564138907510",
  "chomchom":"https://bizweb.dktcdn.net/thumb/grande/100/475/702/products/chom-chom-nhan.png?v=1682103428280",
  "oi":"https://anhsangvietnhat.com/wp-content/uploads/2021/08/o%CC%82%CC%89i-xa%CC%81-li%CC%A3.jpeg",
  "mangcut":"https://cdn-images.kiotviet.vn/faifodn/8997c58f0a204ab481961da05627db1a.jpg",
  "tao":"https://sieuthivivo.com/wp-content/uploads/2020/02/tao-gala-my-1-compress-compress-compress-compress-compress.jpg",
  "le":"https://caycanhhaidang.com/wp-content/uploads/2016/09/Cay-Le-Vang-5.jpg",
  "cam":"https://product.hstatic.net/200000281397/product/upload_01576fda6c284a84bafec3cf31c7fc14.jpg",
  "thanhlong":"https://anviemex.com/wp-content/uploads/2021/06/anh-dai-dien-thanh-long-tr%C4%83ng.jpg",
};

class Fruit{
  String id, ten;
  double gia;
  String? url;
  String? mota;
  Fruit({required this.id, required this.ten, required this.gia, this.url, this.mota});
}
class GH_Item{
  String idSP;
  int sl;
  GH_Item({required this.idSP, required this.sl});
}
class AppData{
  final List<Fruit> _dssp = [
    Fruit(id: "01", ten: "Xoài", gia: 45000, url: images["xoai"], mota: "Xoài cát Hoài Lộc loại 1"),
    Fruit(id: "02", ten: "Mít", gia: 40000, url: images["mit"], mota: "Mít"),
    Fruit(id: "03", ten: "Sầu riêng", gia: 100000, url: images["saurieng"], mota: "Sầu riêng Khánh Sơn"),
    Fruit(id: "04", ten: "Chôm chôm", gia: 25000, url: images["chomchom"], mota: "Chôm Chôm"),
    Fruit(id: "05", ten: "Ổi", gia: 20000, url: images["oi"], mota: "Ổi"),
    Fruit(id: "06", ten: "Măng cụt", gia: 50000, url: images["mangcut"], mota: "Măng cụt"),
    Fruit(id: "07", ten: "Táo", gia: 25000, url: images["tao"], mota: "Táo Việt Nam"),
    Fruit(id: "08", ten: "Lê", gia: 26000, url: images["le"], mota: "Lê Việt Nam"),
    Fruit(id: "09", ten: "Cam", gia: 35000, url: images["cam"], mota: "Cam Vĩnh Long"),
    Fruit(id: "10", ten: "Thanh long", gia: 30000, url: images["thanhlong"], mota: "Thanh long Phan Thiết"),
  ];
  List<Fruit> get dssp => _dssp;
}