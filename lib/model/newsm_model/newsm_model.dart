import 'package:json_annotation/json_annotation.dart';

import 'source.dart';

part 'newsm_model.g.dart';

@JsonSerializable()
class NewsmModel {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsmModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsmModel.fromJson(Map<String, dynamic> json) {
    return _$NewsmModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewsmModelToJson(this);
}
