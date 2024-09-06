class TrailerVideoEntity {
  final String id;
  final String name;
  final String type;
  final bool isOfficial;
  final String videoKey;

  TrailerVideoEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.isOfficial,
    required this.videoKey,
  });
}
