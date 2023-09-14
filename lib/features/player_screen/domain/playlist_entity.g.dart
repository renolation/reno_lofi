// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaylistEntity _$$_PlaylistEntityFromJson(Map<String, dynamic> json) =>
    _$_PlaylistEntity(
      poster: json['poster'] as String? ?? '',
      title: json['title'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      author: json['author'] as String? ?? '',
      songs: (json['songs'] as List<dynamic>?)
              ?.map((e) => AudioEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_PlaylistEntityToJson(_$_PlaylistEntity instance) =>
    <String, dynamic>{
      'poster': instance.poster,
      'title': instance.title,
      'genre': instance.genre,
      'author': instance.author,
      'songs': instance.songs,
    };
