class User {
  final String id;
  final String username;
  final String email;
  final int points;
  User({this.id, this.username, this.email, this.points});
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        email = data['email'],
        points = data['points'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'points': points,
      'username': username
    };
  }
}