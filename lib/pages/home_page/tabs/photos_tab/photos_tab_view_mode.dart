import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megacloud/models/mega_file_entry.dart';
import 'package:megacloud/repositories/mega_files_repository.dart';
import 'package:megacloud/shared_widgets/carousel_banner_ads.dart';
import 'package:megacloud/globals.dart' as globals;

class PhotosTabViewMode extends StatefulWidget {
  final bool editMode;
  final Function() toggleEditMode;

  const PhotosTabViewMode({
    Key? key,
    required this.editMode,
    required this.toggleEditMode,
  }) : super(key: key);

  @override
  _PhotosTabViewModeState createState() => _PhotosTabViewModeState();
}

class _PhotosTabViewModeState extends State<PhotosTabViewMode> {
  bool _filesFetching = false;
  String _filesFetchingError = "";
  List<MegaFileEntry> _files = [];
  @override
  void initState() {
    super.initState();
    _fetchFiles();
  }

  Future<void> _fetchFiles() async {
    setState(() {
      _filesFetchingError = "";
      _filesFetching = true;
      _files = [];
    });
    try {
      var result = await MegaFilesRepository.instance.fetchPhotos();
      setState(() {
        _filesFetchingError = "";
        _filesFetching = false;
        _files = result;
      });
    } on Exception catch (e) {
      setState(() {
        _filesFetchingError = e.toString();
        _filesFetching = false;
        _files = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        _buildCarouselBannerAds(context),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        _buildFetchingStatus(context),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        _buildFilesGrid(context),
      ],
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
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
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                // ignore: prefer_function_declarations_over_variables
                Function() _toggleEditMode = () {
                  Navigator.of(context).pop();
                  widget.toggleEditMode();
                };
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  height: 300,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.check_circle),
                        title: const Text('select_files').tr(),
                      ),
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.download),
                        title: const Text('download').tr(),
                      ),
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.delete_forever),
                        title: const Text('delete').tr(),
                      ),
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.drive_file_move_outlined),
                        title: const Text('move').tr(),
                      ),
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.copy),
                        title: const Text('copy').tr(),
                      ),
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.drive_file_rename_outline),
                        title: const Text('rename').tr(),
                      ),
                      ListTile(
                        onTap: _toggleEditMode,
                        leading: const Icon(Icons.check_circle),
                        title: const Text('select_files').tr(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.more_vert_outlined),
          color: Colors.grey,
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.settings_outlined),
        onPressed: () {},
        color: Colors.black,
      ),
      title: Text(
        globals.phone,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  SliverToBoxAdapter _buildCarouselBannerAds(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: CarouselBannerAds(),
      ),
    );
  }

  Widget _buildFetchingStatus(BuildContext context) {
    Widget? child;

    if (_filesFetching) {
      child = const Center(child: CircularProgressIndicator());
    }

    if (_filesFetchingError.isNotEmpty) {
      child = Text(_filesFetchingError);
    }

    if (_files.isEmpty && !_filesFetching) {
      child = Center(child: const Text("no_files_yet").tr());
    }

    return SliverToBoxAdapter(child: child);
  }

  Widget _buildFilesGrid(BuildContext context) {
    // TODO: сделать общий FilesGrid который может показывать папки, файлы, фотки

    if (_files.isEmpty) {
      return const SliverToBoxAdapter(child: null);
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var file = _files[index];
          var thumbnailPath = file.getThumbnail();

          Widget? thumbnail;
          if (thumbnailPath.contains('.svg')) {
            thumbnail = SvgPicture.asset(
              thumbnailPath,
            );
          }

          if (thumbnailPath.contains('assets/images/sample_gallery_photos')) {
            thumbnail = Image.asset(thumbnailPath, fit: BoxFit.cover);
          }

          return thumbnail;
        },
        childCount: _files.length,
      ),
    );
  }
}
