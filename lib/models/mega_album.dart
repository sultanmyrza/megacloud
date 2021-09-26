import 'package:uuid/uuid.dart';

class MegaAlbum {
  String id;
  String title;
  String thumbnailUrl;
  int itemsCount;
  DateTime created;
  DateTime updated;

  MegaAlbum({
    String? id,
    required this.title,
    required this.thumbnailUrl,
    required this.itemsCount,
    DateTime? created,
    DateTime? updated,
  })  : id = id ?? const Uuid().v4(),
        created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now();
}
