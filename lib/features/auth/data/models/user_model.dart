
// import 'package:github_search/features/auth/domain/enities/user_entity.dart';

// class UserModel extends UserEntity{
//   UserModel({
//     required int id,
//     required String fullname,
//     required String phone,
//     required DateTime createdAt,
//     required String city,
//     required bool registered,

//   }) : super(
//     id: id, 
//     fullName: fullname,
//     phone: phone,
//     createdAt: createdAt,
//     city: city,
//     registered: registered,
//   );

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       fullname: json['username'],
//       phone: json['phone'],
//       createdAt: DateTime.parse(json['created_at']).toLocal(),
//       city: json['city'],
//       registered: json['registered'],
//     );
//   }
// }