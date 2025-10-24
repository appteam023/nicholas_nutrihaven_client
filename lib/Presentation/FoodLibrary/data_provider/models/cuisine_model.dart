class CuisineModel {
  final String name;
  final String flagIcon;

  const CuisineModel({
    required this.name,
    required this.flagIcon,
  });

  @override
  String toString() {
    return name;
  }
}