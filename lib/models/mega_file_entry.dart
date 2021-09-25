class MegaFileEntry {
  String path; // example: some/sub/folder/file-name.mp4
  bool isDirectory;
  DateTime created;
  DateTime updated;

  MegaFileEntry({
    required this.path,
    required this.isDirectory,
    required this.created,
    required this.updated,
  });

  String getFileName() {
    return path.split('/').last;
  }

  String getExtension() {
    return path.split('.').last;
  }

  String getThumbnail() {
    // TODO: for images/videos get image representation from cache or remote url
    // TODO: for music, folder, documents, pdf etc use static icons,
    // or predefined images from assets
    throw UnimplementedError();
  }

  String mimeType() {
    // TODO: find exsiting solution (flutter packages etc) probably exists
    switch (getExtension()) {
      case 'jpeg':
      case 'jpg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'mp4':
        return 'video/mp4';
      default:
        // TODO: what is generic mime type?
        return "";
    }
  }
}
