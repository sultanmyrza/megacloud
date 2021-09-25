import 'package:megacloud/globals.dart' as globals;

enum MegaFileEntryType { video, image, directory, pdf, audio, unknowDocument }

class MegaFileEntry {
  String path; // example: some/sub/folder/file-name.mp4
  bool isDirectory;
  DateTime created;
  DateTime updated;

  MegaFileEntry({
    required this.path,
    required this.isDirectory,
    DateTime? created,
    DateTime? updated,
  })  : created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now();

  String getFileName() {
    return path.split('/').last;
  }

  String getExtension() {
    return path.split('.').last.toLowerCase();
  }

  String getThumbnail() {
    if (isDirectory) {
      return globals.FileTypeIcons.folder;
    }
    switch (getExtension()) {
      case 'ai':
        return globals.FileTypeIcons.ai;
      case 'gif':
        return globals.FileTypeIcons.pdf;
      case 'pdf':
        return globals.FileTypeIcons.pdf;
      case 'zip':
        return globals.FileTypeIcons.zip;
      default:
        return globals.FileTypeIcons.unknow;
    }
  }

  MegaFileEntryType getType() {
    // TODO: handle edge cases
    if (isDirectory) return MegaFileEntryType.directory;

    switch (getExtension()) {
      case 'jpeg':
      case 'jpg':
      case 'png':
      case 'gif':
        return MegaFileEntryType.image;
      case 'mp4':
      case 'mov':
        return MegaFileEntryType.video;
      default:
        return MegaFileEntryType.unknowDocument;
    }
  }

  String mimeType() {
    // TODO: handle edge case
    if (isDirectory) return "directory";
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
