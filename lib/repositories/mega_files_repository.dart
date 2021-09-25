// it's singleton you can read https://stackoverflow.com/a/63129052/6133329
import 'dart:math';

import 'package:megacloud/models/mega_file_entry.dart';

class MegaFilesRepository {
  // FooAPI _fooAPI;

  static final MegaFilesRepository _instance = MegaFilesRepository._internal();

  static MegaFilesRepository instance = MegaFilesRepository();

  factory MegaFilesRepository() {
    return _instance;
  }

  MegaFilesRepository._internal() {
    // TODO: add init logic if needed
    // FOR EXAMPLE API parameters
  }

  Future<List<MegaFileEntry>> fetchFiles({
    String userId = "some user id",
  }) async {
    // TODO: fetch from real service

    await Future.delayed(const Duration(milliseconds: 650));

    // чтобы тестить когда у пользователя еще нет фйлов
    if ((Random().nextInt(10)) % 2 == 0) {
      return [];
    }

    return [
      MegaFileEntry(isDirectory: true, path: 'Скриншоты'),
      MegaFileEntry(isDirectory: true, path: 'Работа'),
      MegaFileEntry(isDirectory: true, path: 'Горы'),
      MegaFileEntry(isDirectory: true, path: 'FinkaBank'),
      MegaFileEntry(isDirectory: true, path: 'alpha_white_red'),
      MegaFileEntry(isDirectory: true, path: 'Видеоуроки'),
      MegaFileEntry(isDirectory: false, path: 'FinkaBank_compred.pdf'),
      MegaFileEntry(isDirectory: false, path: 'Logos_concepts.AI'),
      MegaFileEntry(isDirectory: false, path: 'tezcom.zip'),
    ];
  }

  Future<List<MegaFileEntry>> fetchPhotos({
    String userId = "some user id",
  }) async {
    // TODO: fetch from real service

    await Future.delayed(const Duration(seconds: 1));

    var fileEntries = List<int>.generate(40, (i) => (i + 1) % 10).map(
      (i) => MegaFileEntry(
        path: 'assets/images/sample_gallery_photos/sample_gallery_photo_$i.png',
        isDirectory: false,
      ),
    );

    return fileEntries.toList();
  }

  // TODO: define album data interface
  Future<List<dynamic>> fetchAlbums({
    String userId = "some user id",
  }) async {
    throw UnimplementedError();
  }
}
