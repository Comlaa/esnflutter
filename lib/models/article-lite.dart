class ArticleLite {
  final String title;
  final String picture;
  bool favorite;
  bool saved;

  ArticleLite(
      {required this.title,
      required this.picture,
      required this.favorite,
      required this.saved});

  ArticleLite.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        picture = json['picture'],
        favorite = json['favorite'],
        saved = json['saved'];
}
