import 'package:json_annotation/json_annotation.dart';

part 'form.g.dart';

@JsonSerializable()
class FormEntity {
  final String id;
  final String name;

  const FormEntity({required this.id, required this.name});

  factory FormEntity.fromJson(Map<String, dynamic> json) =>
      _$FormEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FormEntityToJson(this);
}
