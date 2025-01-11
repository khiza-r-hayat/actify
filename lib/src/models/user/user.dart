import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User{
  const factory User({
    String? id,
    String? role,
    String? csrf,
    String? jwt,
    String? logout,
    String? loginTime,
  }) = _User;
  const User._();

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
}