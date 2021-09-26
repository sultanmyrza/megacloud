import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megacloud/models/mega_file_entry.dart';
import 'package:megacloud/repositories/mega_files_repository.dart';
import 'package:megacloud/shared_widgets/carousel_banner_ads.dart';
import 'package:megacloud/globals.dart' as globals;

class PhotosTabEditMode extends StatefulWidget {
  final bool editMode;
  final Function() toggleEditMode;

  const PhotosTabEditMode({
    Key? key,
    required this.editMode,
    required this.toggleEditMode,
  }) : super(key: key);

  @override
  _PhotosTabEditModeState createState() => _PhotosTabEditModeState();
}

class _PhotosTabEditModeState extends State<PhotosTabEditMode> {
  bool _filesFetching = false;
  String _filesFetchingError = "";
  List<MegaFileEntry> _files = [];

  List<MegaFileEntry> _selectedFiles = [];

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
          icon: const Icon(Icons.download),
          color: Colors.grey,
        ),
        IconButton(
          onPressed: _deleteSelectedFiles,
          icon: const Icon(Icons.delete_forever),
          color: Colors.grey,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share),
          color: Colors.grey,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          color: Colors.grey,
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          widget.toggleEditMode();
        },
        color: Colors.black,
      ),
      title: Text(
        '${_selectedFiles.length}',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  void _deleteSelectedFiles() {
    for (var selectedFile in _selectedFiles) {
      _files.remove(selectedFile);
    }

    var snackBar = SnackBar(
      content: const Text("files_deleted").tr(
        args: [_selectedFiles.length.toString()],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() => _selectedFiles = []);
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
              height: double.infinity,
              width: double.infinity,
            );
          } else if (thumbnailPath
              .contains('assets/images/sample_gallery_photos')) {
            thumbnail = Image.asset(
              thumbnailPath,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            );
          } else {
            thumbnail = const Center(child: Icon(Icons.broken_image, size: 56));
          }

          var selectionStatusIcon = Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isSelected(file)
                  ? const Icon(
                      Icons.check_circle,
                      color: Color(0xff5a2a7e),
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: Color(0xff5a2a7e),
                    ),
            ),
          );

          return GestureDetector(
            onTap: () => _toggleSelectFile(file),
            child: Stack(
              children: [
                thumbnail,
                selectionStatusIcon,
              ],
            ),
          );
        },
        childCount: _files.length,
      ),
    );
  }

  void _toggleSelectFile(MegaFileEntry file) {
    if (_isSelected(file)) {
      setState(() => _selectedFiles.remove(file));
    } else {
      setState(() => _selectedFiles.add(file));
    }
  }

  _isSelected(MegaFileEntry file) {
    return _selectedFiles.where((element) => element.id == file.id).isNotEmpty;
  }
}
