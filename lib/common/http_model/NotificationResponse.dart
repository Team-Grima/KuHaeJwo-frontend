class NotificationResponse {
  final int? id;
  final String? title;
  final String? body;
  final bool? isRead;
  final String? createdAt;

  NotificationResponse({
    this.id,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
  });

  NotificationResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        body = json['body'] as String?,
        isRead = json['isRead'] as bool?,
        createdAt = json['createdAt'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'body': body, 'isRead': isRead, 'createdAt': createdAt};
}
