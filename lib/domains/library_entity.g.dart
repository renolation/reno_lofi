// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LibraryEntityImpl _$$LibraryEntityImplFromJson(Map<String, dynamic> json) =>
    _$LibraryEntityImpl(
      id: json['Id'] as String,
      name: json['Name'] as String?,
      path: json['Path'] as String?,
      type: json['Type'] as String?,
      collectionType: json['CollectionType'] as String?,
      imageTags: (json['ImageTags'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$LibraryEntityImplToJson(_$LibraryEntityImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Path': instance.path,
      'Type': instance.type,
      'CollectionType': instance.collectionType,
      'ImageTags': instance.imageTags,
    };

_$LibrariesImpl _$$LibrariesImplFromJson(Map<String, dynamic> json) =>
    _$LibrariesImpl(
      libraries: (json['Items'] as List<dynamic>)
          .map((e) => LibraryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LibrariesImplToJson(_$LibrariesImpl instance) =>
    <String, dynamic>{
      'Items': instance.libraries,
    };
