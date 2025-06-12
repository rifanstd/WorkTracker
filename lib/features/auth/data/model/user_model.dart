class UserModel {
  final String? uid;
  final String? email;
  final String? name;
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['id'] as String?,
      email: map['email'] as String?,
      name: map['name'] as String?,
      photoUrl: map['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': uid?.toString(),
        'email': email?.toString(),
        'name': name?.toString(),
        'photoUrl': photoUrl?.toString(),
      };
}
