import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> DsPT = [];
  TextEditingController soA = TextEditingController();
  TextEditingController soB = TextEditingController();
  int kq = 0;
  String? chuoi;
  void _Minus() {
    setState(() {
      kq = int.parse(soA.text) - int.parse(soB.text);
      chuoi = soA.text + " - " + soB.text + " = " + kq.toString();
      DsPT.add(chuoi!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Phan Viết Lực"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: soA,
                decoration: InputDecoration(
                  labelText: "Hệ số A",
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: soB,
                decoration: InputDecoration(
                  labelText: "Hệ số B",
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20,),
              Text(
                "Kết quả:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${kq}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),)
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _Minus(),
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text("Danh sách kết quả", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              /*Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        String ls = DsPT[index];
                        return ListTile(
                          title: Text("${ls}"),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(thickness: 1,),
                      itemCount: DsPT.length
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      )
    );
  }
}
