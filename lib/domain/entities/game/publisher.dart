class Publisher {
  final int id;
  final String name;
  final String? resourceLink;
  final String? logoLink;

  const Publisher({
    required this.id,
    required this.name,
    this.resourceLink,
    this.logoLink,
  });

  factory Publisher.empty() {
    return const Publisher(id: 0, name: 'Пусто');
  }
}
