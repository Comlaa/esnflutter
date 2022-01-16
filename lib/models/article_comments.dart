class ArticleComments {
  final String name;
  final String comment;

  ArticleComments({
    required this.name,
    required this.comment,
  });

  ArticleComments.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        comment = json['comment'];
}
