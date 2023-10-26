import 'package:json_annotation/json_annotation.dart';

part 'popular_image_model.g.dart';

@JsonSerializable()
class PopularImageModel {
  @JsonKey(name: "aspect_ratio")
  final double? aspectRatio;
  final int? height;
  @JsonKey(name: "iso_639_1")
  final dynamic iso6391;
  @JsonKey(name: "file_path")
  final String? filePath;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;
  final int? width;

  PopularImageModel({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory PopularImageModel.fromJson(Map<String, dynamic> json) =>
      _$PopularImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularImageModelToJson(this);
}
