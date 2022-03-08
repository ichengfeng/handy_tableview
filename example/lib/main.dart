import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handy_tableview/tableview.dart';

main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, splashColor: Colors.transparent,),
      debugShowCheckedModeBanner: false,
      home: const CFHomePage(),
    );
  }
}

class CFHomePage extends StatelessWidget {
  const CFHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: HandyTableView(
        style: TableViewStyle.group,
        numberOfSections: 6,
        numberOfRowsInSection: (section) => section == 1 ? 3 : 10,
        tableViewHeaderBuilder: (ctx) {
          return Image.network('https://picsum.photos/375/180?random=1',fit: BoxFit.cover,);
        },
        tableViewFooterBuilder: (ctx) {
          return Image.network('https://picsum.photos/375/88?random=2',fit: BoxFit.cover,);
        },
        cellForRowBuilder: (ctx,indexPath) {
          return Container(
            color: Colors.primaries[indexPath.row%Colors.primaries.length],
            child: indexPath.section == 1 && indexPath.row == 1
                ? Image.network('https://picsum.photos/375/88?random=3',fit: BoxFit.cover,)
                : Container(padding: const EdgeInsets.all(24),child: Text('${indexPath.row}')),
          );
        },
        sectionHeaderBuilder: (ctx, section) {
          if(section == 1) {
            return Container(
              height: 120,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(image: NetworkImage("https://picsum.photos/375/120?random=4"),fit: BoxFit.cover,),
              ),
              child: defaultContainerBuilder('Header == $section',backgroundColor: Colors.transparent),
            );
          }
          return defaultContainerBuilder("Header == $section",backgroundColor: Colors.white);
        },
        sectionFooterBuilder: (ctx, section) {
          return defaultContainerBuilder("Footer",backgroundColor: const Color(0xFFF8F8F8),footer: true);
        },
      ),
    );
  }

  Widget defaultContainerBuilder(String text,{Color backgroundColor = Colors.white, bool footer = false}) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
      alignment: Alignment.center,
      child: Text(
        '----- $text -----',
        style: TextStyle(color: footer ? Colors.orange : Colors.red),
      ),
    );
  }
}