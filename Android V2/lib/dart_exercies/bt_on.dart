void main()async{
  /*Future.delayed(Duration(seconds: 5),() => 3,)//Sau 5 giây
      .then(
        (value) {
          print(value);
        },//In 3
        onError: (error){
          print(error);
        },//Giá trị Future hoàn thành vs giá trị lỗi in error trong onError
      ).catchError((error) {
        print(error);
      }).whenComplete(
          () => print("Kết thúc"),
      );//Nếu đoạn mã then có lỗi thì in error trong catchError
  print(1);
  var result = await Future<int>.delayed(//await: đợi sau 2 giây trả về số nguyên 2
      Duration(seconds: 2),
      () => 2,
  );
  //Sau khi thực hiện xong await mới thực hiện
  //Không có await thực hiện print(3) sau 2 giây thực hiện print(result
  print(3);
  print(result);*/
  try{
    var result = await Future<int>.delayed(//await: đợi sau 2 giây trả về số nguyên 2
      Duration(seconds: 2),
          () => 2,
    );
    print(result);
  }catch(e){
    print(e);
  }finally{
    print("Kết thúc");
  }

  //then <=> try
  //catchError <=> catch
  //whenComplete <=> finally
}