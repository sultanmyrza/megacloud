import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megacloud/models/mega_file_entry.dart';
import 'package:megacloud/repositories/mega_files_repository.dart';
import 'package:megacloud/shared_widgets/carousel_banner_ads.dart';
import 'package:megacloud/globals.dart' as globals;

class FilesTab extends StatefulWidget {
  const FilesTab({Key? key}) : super(key: key);

  @override
  _FilesTabState createState() => _FilesTabState();
}

class _FilesTabState extends State<FilesTab> {
  bool _filesFetching = false;
  String _filesFetchingError = "";
  List<MegaFileEntry> _files = [];

  @override
  void initState() {
    super.initState();
    _fetchFiles();
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
          onPressed: () {},
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

  Future<void> _fetchFiles() async {
    setState(() {
      _filesFetchingError = "";
      _filesFetching = true;
      _files = [];
    });
    try {
      var result = await MegaFilesRepository.instance.fetchFiles();
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
    // TODO: ?????????????? ?????????? FilesGrid ?????????????? ?????????? ???????????????????? ??????????, ??????????, ??????????

    if (_files.isEmpty) {
      return const SliverToBoxAdapter(child: null);
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var file = _files[index];
        var fileThumbnail = file.getThumbnail();

        return Column(
          children: [
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1.7,
              child: SvgPicture.asset(
                fileThumbnail,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              file.getFileName(),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }, childCount: _files.length),
    );
  }
}
