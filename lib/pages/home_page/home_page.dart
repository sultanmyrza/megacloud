import 'package:flutter/material.dart';
import 'package:megacloud/globals.dart' as globals;
import 'package:megacloud/pages/home_page/files_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static Route<MaterialPage> route() {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: _selectedIndex == 0
          ? const FilesTab()
          : Center(child: Text("TODO implement tab for $_selectedIndex")),
      // TODO: rewrite with tab bar view if needed example brainfood app
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            // TODO: add translations
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            // TODO: add translations
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            // TODO: add translations
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever_outlined),
            // TODO: add translations
            label: 'Trash',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        // TODO: change selectedItemColor to more distinguishable color
        // for example (megacom green color)
        selectedItemColor: const Color(0xff2e2e2e),
        unselectedItemColor: const Color(0xff7d7d8b),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
