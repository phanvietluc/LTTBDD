import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viet_luc63132246_flutter/nss/controller/rss_controller_simple.dart';
import 'Webview.dart';
import 'package:flutter/cupertino.dart';

class RssApp extends StatelessWidget {
  const RssApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: RssBinding(),
      home: PageRssSimple(),
    );
  }
}

class PageRssSimple extends StatelessWidget {
  const PageRssSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<SimpleControllerRSS>(
          init: SimpleControllerRSS.instance,
          builder: (controller) => Text("${controller.resourceName}", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        onRefresh:() => SimpleControllerRSS.instance.readRss(),
        child: GetBuilder<SimpleControllerRSS>(
          id: "listRss",
          init: SimpleControllerRSS.instance,
          builder: (controller) {
            var listRss = controller.rssItem;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var list = listRss[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap:() =>  Get.to(MyWebPage(url: list.link!, resourceName: controller.resourceName)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: list.imageUrl == null ? Icon(Icons.image_not_supported): Image.network("${list.imageUrl!}"),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(list.title?? ""),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(list.description?? "")
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 1.5),
                itemCount: listRss.length,
            );
          },
        ),
      ),
    );
  }
}
