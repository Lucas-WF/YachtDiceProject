class GameRepository {
  GameRepository();

  Map<String, int?> values = {
    "Aces": null,
    "Twos": null,
    "Threes": null,
    "Fours": null,
    "Fives": null,
    "Sixes": null,
    "Chances": null,
    "4 of a kind": null
  };
  List<bool> specialValues = [false, false, false, false];
  int bonus = 0;

  int valuesSum() {
    int sum = 0;

    for (var i in values.values) {
      sum += i ?? 0;
    }

    return sum;
  }

  int normalValuesSum() {
    bonus = 0;
    int sum = 0;

    List<String> scoreKeys = [
      "Aces",
      "Twos",
      "Threes",
      "Fours",
      "Fives",
      "Sixes"
    ];

    for (var key in scoreKeys) {
      sum += values[key] ?? 0;
    }

    if (sum >= 63) {
      bonus = 35;
    }

    return sum;
  }

  int specialValuesSum() {
    int sum = 0;

    if (specialValues[0]) sum += 25;
    if (specialValues[1]) sum += 30;
    if (specialValues[2]) sum += 40;
    if (specialValues[3]) sum += 50;

    return sum;
  }

  int totalSum() {
    return valuesSum() + specialValuesSum() + bonus;
  }

  void dispose() {
    bonus = 0;
    values.clear();
    specialValues = [false, false, false, false];
  }
}
