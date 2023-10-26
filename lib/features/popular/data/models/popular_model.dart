import 'package:json_annotation/json_annotation.dart';
import 'package:pp/core/models/paginated_model.dart';

part 'popular_model.g.dart';

@JsonSerializable()
class PopularModel extends PaginatedModel {
  final bool? adult;
  final int? gender;
  final int? id;
  @JsonKey(name: "known_for")
  final List<KnownFor>? knownFor;
  @JsonKey(name: "known_for_department")
  final String? knownForDepartment;
  final String? name;
  final double? popularity;
  @JsonKey(name: "profile_path")
  final String? profilePath;

  PopularModel({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) =>
      _$PopularModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularModelToJson(this);
}

@JsonSerializable()
class KnownFor {
  final bool? adult;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;
  @JsonKey(name: "genre_ids")
  final List<int>? genreIds;
  final int? id;
  @JsonKey(name: "media_type")
  final String? mediaType;
  @JsonKey(name: "original_language")
  final String? originalLanguage;
  @JsonKey(name: "original_title")
  final String? originalTitle;
  final String? overview;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "release_date")
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;
  @JsonKey(name: "first_air_date")
  final DateTime? firstAirDate;
  final String? name;
  @JsonKey(name: "origin_country")
  final List<String>? originCountry;
  @JsonKey(name: "original_name")
  final String? originalName;

  KnownFor({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalName,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);

  Map<String, dynamic> toJson() => _$KnownForToJson(this);
}
