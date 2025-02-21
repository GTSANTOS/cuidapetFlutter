import 'package:json_annotation/json_annotation.dart';

part 'access_token_model.g.dart';

@JsonSerializable()
class AccessTokenModel {
  @JsonKey(name: 'access_token')
  String accessToken;

  AccessTokenModel({
    this.accessToken,
  });

  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenModelFromJson(json);
}
