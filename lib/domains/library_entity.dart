import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_entity.freezed.dart';
part 'library_entity.g.dart';

@freezed
class LibraryEntity with _$LibraryEntity {
  const factory LibraryEntity({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Path') String? path,
    @JsonKey(name: 'Type') String? type,
    @JsonKey(name: 'CollectionType') String? collectionType,
    @Default({}) @JsonKey(name: 'ImageTags') Map<String, String> imageTags,
  }) = _LibraryEntity;

  factory LibraryEntity.fromJson(Map<String, dynamic> json) => _$LibraryEntityFromJson(json);
}

@freezed
class Libraries with _$Libraries {
  const factory Libraries({@JsonKey(name: 'Items') required List<LibraryEntity> libraries}) = _Libraries;

  factory Libraries.fromJson(Map<String, dynamic> json) => _$LibrariesFromJson(json);

}