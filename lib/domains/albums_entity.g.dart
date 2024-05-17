// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlbumsEntityImpl _$$AlbumsEntityImplFromJson(Map<String, dynamic> json) =>
    _$AlbumsEntityImpl(
      items: (json['Items'] as List<dynamic>)
          .map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecordCount: (json['TotalRecordCount'] as num).toInt(),
    );

Map<String, dynamic> _$$AlbumsEntityImplToJson(_$AlbumsEntityImpl instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'TotalRecordCount': instance.totalRecordCount,
    };
