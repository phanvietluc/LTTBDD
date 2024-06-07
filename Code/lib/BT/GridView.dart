import 'package:flutter/material.dart';

class GridViewCount extends StatelessWidget {
  const GridViewCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View Count"),
        backgroundColor: Colors.blue,
      ),
      body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(100,
            (index) =>
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue)
              ),
              child: Center(
                child: Text('${index+1}', style: TextStyle(fontSize: 20),),
              ),
            )
          ),
      ),
    );
  }
}

class GridViewExtend extends StatelessWidget {
  const GridViewExtend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View Extend"),
        backgroundColor: Colors.blue,
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        padding: EdgeInsets.all(5),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: List.generate(100,
          (index) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue)
            ),
            child: Center(
              child: Text("${index+1}",style:TextStyle(fontSize: 20),),
            ),
          )
        ),
      )
    );
  }
}

