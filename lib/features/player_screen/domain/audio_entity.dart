import 'package:freezed_annotation/freezed_annotation.dart';


part 'audio_entity.freezed.dart';
part 'audio_entity.g.dart';


@freezed
class AudioEntity with _$AudioEntity  {

  const factory AudioEntity({

    @Default('') String? poster,
    @Default('') String? linkPath,
    @Default('') String? title,
    @Default('') String? artist,
    @Default('') String? album,
    @Default('') String? genre,
    @Default('') String? duration,


  }) = _AudioEntity;


  factory AudioEntity.fromJson(Map<String, dynamic> json) =>
      _$AudioEntityFromJson(json);
}

