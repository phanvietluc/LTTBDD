import 'package:flutter/material.dart';
import 'form_model.dart';
class BTForm extends StatelessWidget {
  BTForm({super.key});
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSoluong = TextEditingController();
  MatHang mh = MatHang();
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài tập Form'),
      ),
      body: Form(
        key: formState,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            TextFormField(
              controller: txtName,
              keyboardType: TextInputType.text,
              onSaved: (newValue) => mh.name = newValue,
              validator: (value) => validateString(value),
              decoration: InputDecoration(
                labelText: "Tên mặt hàng",
                hintText: "Nhập tên mặt hàng"
              ),
            ),
            DropdownButtonFormField<String>(
                items: LoaiMH.map(
                  (loaiMH) => DropdownMenuItem<String>(
                      child: Text("${loaiMH}"),
                      value: loaiMH,
                  )).toList(),
                onChanged: (value) => dropdownValue = value,
                onSaved: (newValue) => mh.loaiMH = newValue,
                value: dropdownValue,
                validator: (value) => validateString(value),
                decoration: InputDecoration(
                  labelText: "Loại mặt hàng"
                ),
            ),
            TextFormField(
              controller: txtSoluong,
              keyboardType: TextInputType.number,
              onSaved: (newValue) => mh.soluong = int.parse(newValue!),
              validator: (value) => validateSoluong(value),
              decoration: InputDecoration(
                labelText: "Số lượng",
                hintText: "Nhập số lượng mặt hàng"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => _save(context),
                    child: Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Lưu dữ liệu vừa nhập OnSaved
  _save(BuildContext context) {
    if(formState.currentState!.validate()){
      formState.currentState!.save();
      hienThiDiaLog(context);
    }
  }

  validateString(String? value) {
    return value == null || value.isEmpty ? "Bạn chưa nhập dữ liệu" : null;
  }

  validateSoluong(String? value) {
    if(value == null || value.isEmpty)
      return "Bạn chưa nhập số lượng";
    else
      return int.parse(value) <= 0 ? "Số lượng phải lớn hơn 0" : null;
  }

  void hienThiDiaLog(BuildContext context) {
    var dialog = AlertDialog(
      title: Text("Thông báo"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,//Hiển thị thông báo lên phù hợp với màn hình
        children: [
          Text('Bạn đã nhập mặt hàng:'),
          Text('Tên MH: ${mh.name}'),
          Text('Loại MH: ${mh.loaiMH}'),
          Text('Số lượng: ${mh.soluong}'),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);//Thoát khỏi thông báo
            },
            child: Text("OK"),
        )
      ],
    );
    showDialog(context: context, builder:(context) =>  dialog);
  }
}
