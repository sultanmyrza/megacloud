class MegaAlbum {
  String title;
  String thumbnailUrl;
  int itemsCount;
  DateTime created;
  DateTime updated;

  MegaAlbum({
    required this.title,
    required this.thumbnailUrl,
    required this.itemsCount,
    DateTime? created,
    DateTime? updated,
  })  : created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now();
}
