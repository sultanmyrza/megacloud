import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:megacloud/models/mega_album.dart';
import 'package:megacloud/repositories/mega_files_repository.dart';
import 'package:megacloud/shared_widgets/carousel_banner_ads.dart';

class AlbumsTab extends StatefulWidget {
  const AlbumsTab({Key? key}) : super(key: key);

  @override
  _AlbumsTabState createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> {
  bool _filesFetching = false;
  String _filesFetchingError = "";
  List<MegaAlbum> _files = [];

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: CarouselBannerAds()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          _buildFetchingStatus(context),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          _buildFilesGrid(context),
        ],
      ),
    );
  }

  Future<void> _fetchAlbums() async {
    setState(() {
      _filesFetchingError = "";
      _filesFetching = true;
      _files = [];
    });
    try {
      var result = await MegaFilesRepository.instance.fetchAlbums();
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
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index == _files.length) {
          return _createAlbumButton(context);
        }

        var file = _files[index];

        var albumThumbnail = Image.asset(
          file.thumbnailUrl,
          fit: BoxFit.cover,
          height: double.infinity,
        );

        var albumShadow = Container(
          decoration: const BoxDecoration(
            color: Color(0x4c313851),
          ),
        );

        var albumTextStyle = Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.white);

        var albumText = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(file.title, style: albumTextStyle),
              Text(file.itemsCount.toString(), style: albumTextStyle),
            ],
          ),
        );

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0x4c313851),
          ),
          child: Stack(
            children: [
              albumThumbnail,
              albumShadow,
              albumText,
            ],
          ),
        );
      }, childCount: _files.length + 1),
    );
  }

  Widget _createAlbumButton(BuildContext context) {
    var albumShadow = Container(
      decoration: const BoxDecoration(
        color: Color(0x4c313851),
      ),
    );

    var albumTextStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: Colors.white,
        );

    var albumText = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity), // растянет ширину Column
        const Icon(Icons.add, color: Colors.white, size: 48),
        Text("create_album", style: albumTextStyle).tr(),
      ],
    );

    return GestureDetector(
      onTap: () {
        // TODO: implement create album function
        const snackBar = SnackBar(content: Text('Еще не готово!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0x4c313851),
        ),
        child: Stack(
          children: [albumShadow, albumText],
        ),
      ),
    );
  }
}
