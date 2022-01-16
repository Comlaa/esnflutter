class Article {
  final int id;
  final String title;
  final String text;
  final String tags;
  final String category;
  final List<dynamic> articleComments;
  final num articleRating;
  final String comments;
  final String picture;
  bool favorite;
  bool saved;
  int rating;

  Article(
      {required this.id,
      required this.title,
      required this.text,
      required this.tags,
      required this.category,
      required this.articleComments,
      required this.articleRating,
      required this.comments,
      required this.picture,
      required this.favorite,
      required this.saved,
      required this.rating});

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        tags = json['tags'],
        category = json['category'],
        articleComments = json['articleComments'],
        articleRating = json['articleRating'],
        comments = json['comments'],
        picture = json['picture'],
        favorite = json['favorite'],
        saved = json['saved'],
        rating = json['rating'];
}
