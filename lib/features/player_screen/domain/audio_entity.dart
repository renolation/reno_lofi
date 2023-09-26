import 'package:freezed_annotation/freezed_annotation.dart';


part 'audio_entity.freezed.dart';
part 'audio_entity.g.dart';


@freezed
class AudioEntity with _$AudioEntity  {

  const factory AudioEntity({

    @Default('') String? posterUrl,
    @Default('') String? fileUrl,
    @Default('') String? title,
    @Default('') String? artist,
    @Default('') String? album,
    @Default([]) List<String>? genre,
    @Default(0) int? duration,


  }) = _AudioEntity;


  factory AudioEntity.fromJson(Map<String, dynamic> json) =>
      _$AudioEntityFromJson(json);
}

