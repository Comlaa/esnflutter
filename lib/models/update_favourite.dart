class UpdateFavourite {
  final int articleId;
  final int userId;
  bool favorite;
  bool saved;

  UpdateFavourite({
    required this.articleId,
    required this.userId,
    required this.favorite,
    required this.saved,
  });
}
