import 'package:flutter/material.dart';
import 'package:megacloud/globals.dart' as globals;
import 'package:megacloud/pages/home_page/tabs/albums_tab.dart';
import 'package:megacloud/pages/home_page/tabs/files_tab.dart';
import 'package:megacloud/pages/home_page/tabs/photos_tab/photos_tab.dart';
import 'package:megacloud/pages/home_page/tabs/trash_tab.dart';

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
      body: _buildBody(context),
      // TODO: rewrite with tab bar view if needed example brainfood app
      bottomNavigationBar: BottomNavigationBar(
        // TODO: add translations
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Files'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Photos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Albums',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Trash'),
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

  Widget _buildBody(BuildContext context) {
    // TODO: rewrite with tab bar view if needed example brainfood app
    if (_selectedIndex == 0) {
      return const FilesTab();
    }
    if (_selectedIndex == 1) {
      return const PhotosTab();
    }

    if (_selectedIndex == 2) {
      return const AlbumsTab();
    }

    if (_selectedIndex == 3) {
      return const TrashTab();
    }

    return Center(child: Text("TODO implement tab for $_selectedIndex"));
  }
}
