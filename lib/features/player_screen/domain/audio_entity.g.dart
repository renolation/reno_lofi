// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AudioEntity _$$_AudioEntityFromJson(Map<String, dynamic> json) =>
    _$_AudioEntity(
      poster: json['poster'] as String? ?? '',
      linkPath: json['linkPath'] as String? ?? '',
      title: json['title'] as String? ?? '',
      artist: json['artist'] as String? ?? '',
      album: json['album'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
    );

Map<String, dynamic> _$$_AudioEntityToJson(_$_AudioEntity instance) =>
    <String, dynamic>{
      'poster': instance.poster,
      'linkPath': instance.linkPath,
      'title': instance.title,
      'artist': instance.artist,
      'album': instance.album,
      'genre': instance.genre,
      'duration': instance.duration,
    };
