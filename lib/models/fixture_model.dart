class FixtureModel {
  final String team1;
  final String team2;
  final String result;
  final String matchTime;
  final String categoryName;

  FixtureModel({
    required this.team1,
    required this.team2,
    required this.result,
    required this.matchTime,
    required this.categoryName
  });

  FixtureModel.fromJson(Map<dynamic, dynamic> json)
      : team1 = json['team1'],
        team2 = json['team2'],
        result = json['result'],
        matchTime = json['matchTime'],
        categoryName = json['categoryName'];
}
