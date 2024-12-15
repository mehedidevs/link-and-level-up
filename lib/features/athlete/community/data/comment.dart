class Comment {
  final String username;
  final String avatarUrl;
  final String content;
  final String timeAgo;
  final int likes;
  final int replies;

  Comment({
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.replies,
  });
}
