class ConcatCities {
  final List<String> addedCities;

  ConcatCities(this.addedCities);

  @override
  String toString() => "ConcatCities(addedCities: $addedCities)";
}

class TrimCities {
  final List<String> removedCities;

  TrimCities(this.removedCities);

  @override
  String toString() => "TrimCities(removedCities: $removedCities)";
}
