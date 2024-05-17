import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reno_music/data/item_entity.dart';

part 'albums_entity.freezed.dart';
part 'albums_entity.g.dart';


@freezed
class AlbumsEntity with _$AlbumsEntity {
  const factory AlbumsEntity({@JsonKey(name: 'Items') required List<ItemEntity> items, @JsonKey(name: 'TotalRecordCount') required int totalRecordCount}) = _AlbumsEntity;

  factory AlbumsEntity.fromJson(Map<String, dynamic> json) => _$AlbumsEntityFromJson(json);
}
