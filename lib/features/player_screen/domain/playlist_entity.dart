import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reno_music/features/player_screen/domain/audio_entity.dart';


part 'playlist_entity.freezed.dart';
part 'playlist_entity.g.dart';


@freezed
class PlaylistEntity with _$PlaylistEntity  {

  const factory PlaylistEntity({

    @Default('') String? poster,
    @Default('') String? title,
    @Default('') String? genre,
    @Default('') String? author,
    @Default([]) List<AudioEntity>? songs,



  }) = _PlaylistEntity;


  factory PlaylistEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaylistEntityFromJson(json);
}

