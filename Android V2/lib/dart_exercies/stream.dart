import 'dart:async';

class MyStream<T>{
  StreamController<T> _controller = StreamController();
  Stream<T> get stream => _controller.stream;
  void addEvent(T event){
    _controller.sink.add(event);
  }
  void Dispose(){
    _controller.close();
  }
}
void main(){
  MyStream<String> myStream = MyStream();
  myStream.stream.listen(
    (event) {
      print(event);
    });
  myStream.addEvent("Hello World");
}