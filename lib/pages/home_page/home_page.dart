import 'package:flutter/material.dart';
import 'package:megacloud/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static Route<MaterialPage> route() {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
            color: Colors.grey,
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
          color: Colors.black,
        ),
        title: Text(globals.phone, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Row(
          children: [
            Column(
              children: [Expanded(child: Container())],
            ),
            // Column(children: [
            //   Expanded(
            //       child: ListView(
            //     shrinkWrap: true,
            //     children: [
            //       Text(
            //         'Файлы',
            //         style:
            //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ))
            // ]),
            Column(
              children: [Expanded(child: Container())],
            ),
          ],
        ),
      ),
    );
  }
}
