class SinhVien{
  String id, ten;
  String? ngSinh, que_quan;
  SinhVien({required this.id, required this.ten, this.ngSinh, this.que_quan});

  @override
  String toString() {
    return 'SinhVien{id: $id, ten: $ten, Ngay sinh: $ngSinh, Que quan: $que_quan}';
  }
}

class QL_SinhVien{
  List<SinhVien> ls = [];
  void Add(SinhVien? sinhVien){
    if(sinhVien != null) ls.add(sinhVien);
  }
  void InDS1(){
    ls.forEach((sv) {
      print(sv.toString());
    });
  }
  void InDS2(){
    for(SinhVien sv in ls){
      print((sv.toString()));
    }
  }
}

void main(){
  SinhVien sv = SinhVien(id: '01', ten: 'Luc', ngSinh: '08/07/2003', que_quan: 'Khanh Hoa');
  QL_SinhVien qlsv = QL_SinhVien();
  qlsv.Add(sv);
  qlsv.Add(SinhVien(id: '02', ten: 'Hieu', ngSinh: '14/10/2003', que_quan: 'Khanh Hoa'));
  qlsv.Add(SinhVien(id: '03', ten: 'Truong', ngSinh: '09/06/2003', que_quan: 'Khanh Hoa'));
  qlsv.InDS1();
}