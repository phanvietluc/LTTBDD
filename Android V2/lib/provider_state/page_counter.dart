import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ChangeNotifier_counter.dart';
class PageProvider extends StatelessWidget {
  const PageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(//FPT, TGDĐ ...
        create: (context) =>
          CounterChangeNotifier(),//Laptop Dell, Asus... cụ thể
        child: PageCounter(),
    );
  }
}

class PageCounter extends StatelessWidget {
  const PageCounter({super.key});

  @override
  Widget build(BuildContext context) {
    CounterChangeNotifier counter = context.watch<CounterChangeNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Counting", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  var provider = context.read<CounterChangeNotifier>();
                  provider.Tang();
                },
                child: Text("+")
            ),
            Consumer<CounterChangeNotifier>//Người sử dụng
              (builder: (context, value, child) {
                return Text('${value.counter}', style: TextStyle(fontSize: 20),);
              },),
            Text("${counter.counter}", style: TextStyle(fontSize: 20)),
            ElevatedButton(
                onPressed: () {
                  var provider = context.read<CounterChangeNotifier>();
                  provider.Giam();
                },
                child: Text("-")
            ),
          ],
        ),
      ),
    );
  }
}

