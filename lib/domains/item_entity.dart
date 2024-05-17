import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_entity.freezed.dart';
part 'item_entity.g.dart';

@freezed
class ItemEntity with _$ItemEntity {

  const factory ItemEntity({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'ServerId') required String serverId,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'Overview') String? overview,
    @JsonKey(name: 'RunTimeTicks') required int? durationInTicks,
    @JsonKey(name: 'ProductionYear') int? productionYear,
    @JsonKey(name: 'AlbumArtist') String? albumArtist,
    @Default([]) @JsonKey(name: 'BackdropImageTags') List<String> backgropImageTags,
    @Default({}) @JsonKey(name: 'ImageTags') Map<String, String> imageTags,
  }) = _ItemEntity;
  const ItemEntity._();

  factory ItemEntity.fromJson(Map<String, dynamic> json) => _$ItemEntityFromJson(json);

  Duration get duration => durationInTicks == null ? Duration.zero : Duration(seconds: (durationInTicks! / 10000000).ceil());
}
