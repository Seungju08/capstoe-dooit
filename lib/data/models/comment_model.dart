class CommentModel {
  final int comment_id;
  final String author_name;
  final int author_id;
  final String author_tier;
  final String content;
  final String created_at;

  CommentModel({
    required this.comment_id,
    required this.author_name,
    required this.author_id,
    required this.author_tier,
    required this.content,
    required this.created_at,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    comment_id: json['comment_id'],
    author_name: json['author_name'],
    author_id: json['author_id'],
    author_tier: json['author_tier'],
    content: json['content'],
    created_at: json['created_at'],
  );
}
