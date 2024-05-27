class Character {
  int id;
  String detail;
  String imgUrl;
  String name;
  String achievementName;
  bool isCheck;
  bool unlockStatus;

  Character({
    required this.id,
    required this.detail,
    required this.imgUrl,
    required this.name,
    required this.achievementName,
    required this.isCheck,
    required this.unlockStatus,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      detail: json['detail'],
      id: json['id'],
      imgUrl: json['imgUrl'],
      name: json['name'],
      achievementName: json['achievementName'],
      isCheck: json['isCheck'],
      unlockStatus: json['unlockStatus'],
    );
  }
}
