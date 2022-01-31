import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ModelSignUp {
  String name;
  String email;
  String password;
  String password_confirmation;

  // String xyz;
  ModelSignUp({required this.name, required this.email,required this.password,required this.password_confirmation});
}