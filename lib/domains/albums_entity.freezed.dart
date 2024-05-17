// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'albums_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlbumsEntity _$AlbumsEntityFromJson(Map<String, dynamic> json) {
  return _AlbumsEntity.fromJson(json);
}

/// @nodoc
mixin _$AlbumsEntity {
  @JsonKey(name: 'Items')
  List<ItemEntity> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'TotalRecordCount')
  int get totalRecordCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumsEntityCopyWith<AlbumsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumsEntityCopyWith<$Res> {
  factory $AlbumsEntityCopyWith(
          AlbumsEntity value, $Res Function(AlbumsEntity) then) =
      _$AlbumsEntityCopyWithImpl<$Res, AlbumsEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Items') List<ItemEntity> items,
      @JsonKey(name: 'TotalRecordCount') int totalRecordCount});
}

/// @nodoc
class _$AlbumsEntityCopyWithImpl<$Res, $Val extends AlbumsEntity>
    implements $AlbumsEntityCopyWith<$Res> {
  _$AlbumsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalRecordCount = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemEntity>,
      totalRecordCount: null == totalRecordCount
          ? _value.totalRecordCount
          : totalRecordCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlbumsEntityImplCopyWith<$Res>
    implements $AlbumsEntityCopyWith<$Res> {
  factory _$$AlbumsEntityImplCopyWith(
          _$AlbumsEntityImpl value, $Res Function(_$AlbumsEntityImpl) then) =
      __$$AlbumsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Items') List<ItemEntity> items,
      @JsonKey(name: 'TotalRecordCount') int totalRecordCount});
}

/// @nodoc
class __$$AlbumsEntityImplCopyWithImpl<$Res>
    extends _$AlbumsEntityCopyWithImpl<$Res, _$AlbumsEntityImpl>
    implements _$$AlbumsEntityImplCopyWith<$Res> {
  __$$AlbumsEntityImplCopyWithImpl(
      _$AlbumsEntityImpl _value, $Res Function(_$AlbumsEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalRecordCount = null,
  }) {
    return _then(_$AlbumsEntityImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemEntity>,
      totalRecordCount: null == totalRecordCount
          ? _value.totalRecordCount
          : totalRecordCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlbumsEntityImpl implements _AlbumsEntity {
  const _$AlbumsEntityImpl(
      {@JsonKey(name: 'Items') required final List<ItemEntity> items,
      @JsonKey(name: 'TotalRecordCount') required this.totalRecordCount})
      : _items = items;

  factory _$AlbumsEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlbumsEntityImplFromJson(json);

  final List<ItemEntity> _items;
  @override
  @JsonKey(name: 'Items')
  List<ItemEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'TotalRecordCount')
  final int totalRecordCount;

  @override
  String toString() {
    return 'AlbumsEntity(items: $items, totalRecordCount: $totalRecordCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumsEntityImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalRecordCount, totalRecordCount) ||
                other.totalRecordCount == totalRecordCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), totalRecordCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumsEntityImplCopyWith<_$AlbumsEntityImpl> get copyWith =>
      __$$AlbumsEntityImplCopyWithImpl<_$AlbumsEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlbumsEntityImplToJson(
      this,
    );
  }
}

abstract class _AlbumsEntity implements AlbumsEntity {
  const factory _AlbumsEntity(
      {@JsonKey(name: 'Items') required final List<ItemEntity> items,
      @JsonKey(name: 'TotalRecordCount')
      required final int totalRecordCount}) = _$AlbumsEntityImpl;

  factory _AlbumsEntity.fromJson(Map<String, dynamic> json) =
      _$AlbumsEntityImpl.fromJson;

  @override
  @JsonKey(name: 'Items')
  List<ItemEntity> get items;
  @override
  @JsonKey(name: 'TotalRecordCount')
  int get totalRecordCount;
  @override
  @JsonKey(ignore: true)
  _$$AlbumsEntityImplCopyWith<_$AlbumsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
