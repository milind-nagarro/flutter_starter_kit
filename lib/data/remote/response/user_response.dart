import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String phNumber;
  final String pin;

  User(this.id, this.name, this.phNumber, this.pin);

  static const fromJsonFactory = _$UserFromJson;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
