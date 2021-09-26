import 'package:flutter/material.dart';
import 'package:megacloud/pages/home_page/tabs/photos_tab/photos_tab_edit_mode.dart';
import 'package:megacloud/pages/home_page/tabs/photos_tab/photos_tab_view_mode.dart';

class PhotosTab extends StatefulWidget {
  const PhotosTab({Key? key}) : super(key: key);

  @override
  _PhotosTabState createState() => _PhotosTabState();
}

class _PhotosTabState extends State<PhotosTab> {
  bool _editMode = false;

  _toggleEditMode() {
    setState(() => _editMode = !_editMode);
  }

  @override
  Widget build(BuildContext context) {
    return _editMode
        ? PhotosTabEditMode(
            editMode: _editMode,
            toggleEditMode: _toggleEditMode,
          )
        : PhotosTabViewMode(
            editMode: _editMode,
            toggleEditMode: _toggleEditMode,
          );
  }
}
