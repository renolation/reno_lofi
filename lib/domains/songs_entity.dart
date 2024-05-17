import 'package:freezed_annotation/freezed_annotation.dart';

part 'songs_entity.freezed.dart';
part 'songs_entity.g.dart';

@freezed
class SongsEntity with _$SongsEntity {

  const factory SongsEntity({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'RunTimeTicks') required int runTimeTicks,
    @JsonKey(name: 'IndexNumber') @Default(0) int indexNumber,
    @JsonKey(name: 'UserData') required SongUserData songUserData,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'AlbumArtist') String? albumArtist,
    @JsonKey(name: 'Album') String? albumName,
    @JsonKey(name: 'Name') String? name,
    @Default({}) @JsonKey(name: 'ImageTags') Map<String, String> imageTags,
  }) = _SongsEntity;

  factory SongsEntity.fromJson(Map<String, dynamic> json) => _$SongsEntityFromJson(json);
}

@freezed
class SongsWrapper with _$SongsWrapper {
  const factory SongsWrapper({@JsonKey(name: 'Items') required List<SongsEntity> items}) = _SongsWrapper;

  factory SongsWrapper.fromJson(Map<String, dynamic> json) => _$SongsWrapperFromJson(json);
}


@freezed
class SongUserData with _$SongUserData {
  const factory SongUserData({
    @JsonKey(name: 'PlaybackPositionTicks') required int playbackPositionTicks,
    @JsonKey(name: 'PlayCount') required int playCount,
    @JsonKey(name: 'IsFavorite') required bool isFavorite,
    @JsonKey(name: 'Played') required bool played,
  }) = _SongUserData;

  factory SongUserData.fromJson(Map<String, dynamic> json) => _$SongUserDataFromJson(json);
}
