// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AudioEntity _$$_AudioEntityFromJson(Map<String, dynamic> json) =>
    _$_AudioEntity(
      posterUrl: json['posterUrl'] as String? ?? '',
      fileUrl: json['fileUrl'] as String? ?? '',
      title: json['title'] as String? ?? '',
      artist: json['artist'] as String? ?? '',
      album: json['album'] as String? ?? '',
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      duration: json['duration'] as int? ?? 0,
    );

Map<String, dynamic> _$$_AudioEntityToJson(_$_AudioEntity instance) =>
    <String, dynamic>{
      'posterUrl': instance.posterUrl,
      'fileUrl': instance.fileUrl,
      'title': instance.title,
      'artist': instance.artist,
      'album': instance.album,
      'genre': instance.genre,
      'duration': instance.duration,
    };
