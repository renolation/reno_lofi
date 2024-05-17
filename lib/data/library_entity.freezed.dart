// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LibraryEntity _$LibraryEntityFromJson(Map<String, dynamic> json) {
  return _LibraryEntity.fromJson(json);
}

/// @nodoc
mixin _$LibraryEntity {
  @JsonKey(name: 'Id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'Name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'Path')
  String? get path => throw _privateConstructorUsedError;
  @JsonKey(name: 'Type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'CollectionType')
  String? get collectionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'ImageTags')
  Map<String, String> get imageTags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LibraryEntityCopyWith<LibraryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibraryEntityCopyWith<$Res> {
  factory $LibraryEntityCopyWith(
          LibraryEntity value, $Res Function(LibraryEntity) then) =
      _$LibraryEntityCopyWithImpl<$Res, LibraryEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Id') String id,
      @JsonKey(name: 'Name') String? name,
      @JsonKey(name: 'Path') String? path,
      @JsonKey(name: 'Type') String? type,
      @JsonKey(name: 'CollectionType') String? collectionType,
      @JsonKey(name: 'ImageTags') Map<String, String> imageTags});
}

/// @nodoc
class _$LibraryEntityCopyWithImpl<$Res, $Val extends LibraryEntity>
    implements $LibraryEntityCopyWith<$Res> {
  _$LibraryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? path = freezed,
    Object? type = freezed,
    Object? collectionType = freezed,
    Object? imageTags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      collectionType: freezed == collectionType
          ? _value.collectionType
          : collectionType // ignore: cast_nullable_to_non_nullable
              as String?,
      imageTags: null == imageTags
          ? _value.imageTags
          : imageTags // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LibraryEntityImplCopyWith<$Res>
    implements $LibraryEntityCopyWith<$Res> {
  factory _$$LibraryEntityImplCopyWith(
          _$LibraryEntityImpl value, $Res Function(_$LibraryEntityImpl) then) =
      __$$LibraryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Id') String id,
      @JsonKey(name: 'Name') String? name,
      @JsonKey(name: 'Path') String? path,
      @JsonKey(name: 'Type') String? type,
      @JsonKey(name: 'CollectionType') String? collectionType,
      @JsonKey(name: 'ImageTags') Map<String, String> imageTags});
}

/// @nodoc
class __$$LibraryEntityImplCopyWithImpl<$Res>
    extends _$LibraryEntityCopyWithImpl<$Res, _$LibraryEntityImpl>
    implements _$$LibraryEntityImplCopyWith<$Res> {
  __$$LibraryEntityImplCopyWithImpl(
      _$LibraryEntityImpl _value, $Res Function(_$LibraryEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? path = freezed,
    Object? type = freezed,
    Object? collectionType = freezed,
    Object? imageTags = null,
  }) {
    return _then(_$LibraryEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      collectionType: freezed == collectionType
          ? _value.collectionType
          : collectionType // ignore: cast_nullable_to_non_nullable
              as String?,
      imageTags: null == imageTags
          ? _value._imageTags
          : imageTags // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LibraryEntityImpl implements _LibraryEntity {
  const _$LibraryEntityImpl(
      {@JsonKey(name: 'Id') required this.id,
      @JsonKey(name: 'Name') this.name,
      @JsonKey(name: 'Path') this.path,
      @JsonKey(name: 'Type') this.type,
      @JsonKey(name: 'CollectionType') this.collectionType,
      @JsonKey(name: 'ImageTags')
      final Map<String, String> imageTags = const {}})
      : _imageTags = imageTags;

  factory _$LibraryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LibraryEntityImplFromJson(json);

  @override
  @JsonKey(name: 'Id')
  final String id;
  @override
  @JsonKey(name: 'Name')
  final String? name;
  @override
  @JsonKey(name: 'Path')
  final String? path;
  @override
  @JsonKey(name: 'Type')
  final String? type;
  @override
  @JsonKey(name: 'CollectionType')
  final String? collectionType;
  final Map<String, String> _imageTags;
  @override
  @JsonKey(name: 'ImageTags')
  Map<String, String> get imageTags {
    if (_imageTags is EqualUnmodifiableMapView) return _imageTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_imageTags);
  }

  @override
  String toString() {
    return 'LibraryEntity(id: $id, name: $name, path: $path, type: $type, collectionType: $collectionType, imageTags: $imageTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LibraryEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.collectionType, collectionType) ||
                other.collectionType == collectionType) &&
            const DeepCollectionEquality()
                .equals(other._imageTags, _imageTags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, path, type,
      collectionType, const DeepCollectionEquality().hash(_imageTags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LibraryEntityImplCopyWith<_$LibraryEntityImpl> get copyWith =>
      __$$LibraryEntityImplCopyWithImpl<_$LibraryEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LibraryEntityImplToJson(
      this,
    );
  }
}

abstract class _LibraryEntity implements LibraryEntity {
  const factory _LibraryEntity(
          {@JsonKey(name: 'Id') required final String id,
          @JsonKey(name: 'Name') final String? name,
          @JsonKey(name: 'Path') final String? path,
          @JsonKey(name: 'Type') final String? type,
          @JsonKey(name: 'CollectionType') final String? collectionType,
          @JsonKey(name: 'ImageTags') final Map<String, String> imageTags}) =
      _$LibraryEntityImpl;

  factory _LibraryEntity.fromJson(Map<String, dynamic> json) =
      _$LibraryEntityImpl.fromJson;

  @override
  @JsonKey(name: 'Id')
  String get id;
  @override
  @JsonKey(name: 'Name')
  String? get name;
  @override
  @JsonKey(name: 'Path')
  String? get path;
  @override
  @JsonKey(name: 'Type')
  String? get type;
  @override
  @JsonKey(name: 'CollectionType')
  String? get collectionType;
  @override
  @JsonKey(name: 'ImageTags')
  Map<String, String> get imageTags;
  @override
  @JsonKey(ignore: true)
  _$$LibraryEntityImplCopyWith<_$LibraryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Libraries _$LibrariesFromJson(Map<String, dynamic> json) {
  return _Libraries.fromJson(json);
}

/// @nodoc
mixin _$Libraries {
  @JsonKey(name: 'Items')
  List<LibraryEntity> get libraries => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LibrariesCopyWith<Libraries> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibrariesCopyWith<$Res> {
  factory $LibrariesCopyWith(Libraries value, $Res Function(Libraries) then) =
      _$LibrariesCopyWithImpl<$Res, Libraries>;
  @useResult
  $Res call({@JsonKey(name: 'Items') List<LibraryEntity> libraries});
}

/// @nodoc
class _$LibrariesCopyWithImpl<$Res, $Val extends Libraries>
    implements $LibrariesCopyWith<$Res> {
  _$LibrariesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? libraries = null,
  }) {
    return _then(_value.copyWith(
      libraries: null == libraries
          ? _value.libraries
          : libraries // ignore: cast_nullable_to_non_nullable
              as List<LibraryEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LibrariesImplCopyWith<$Res>
    implements $LibrariesCopyWith<$Res> {
  factory _$$LibrariesImplCopyWith(
          _$LibrariesImpl value, $Res Function(_$LibrariesImpl) then) =
      __$$LibrariesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'Items') List<LibraryEntity> libraries});
}

/// @nodoc
class __$$LibrariesImplCopyWithImpl<$Res>
    extends _$LibrariesCopyWithImpl<$Res, _$LibrariesImpl>
    implements _$$LibrariesImplCopyWith<$Res> {
  __$$LibrariesImplCopyWithImpl(
      _$LibrariesImpl _value, $Res Function(_$LibrariesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? libraries = null,
  }) {
    return _then(_$LibrariesImpl(
      libraries: null == libraries
          ? _value._libraries
          : libraries // ignore: cast_nullable_to_non_nullable
              as List<LibraryEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LibrariesImpl implements _Libraries {
  const _$LibrariesImpl(
      {@JsonKey(name: 'Items') required final List<LibraryEntity> libraries})
      : _libraries = libraries;

  factory _$LibrariesImpl.fromJson(Map<String, dynamic> json) =>
      _$$LibrariesImplFromJson(json);

  final List<LibraryEntity> _libraries;
  @override
  @JsonKey(name: 'Items')
  List<LibraryEntity> get libraries {
    if (_libraries is EqualUnmodifiableListView) return _libraries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_libraries);
  }

  @override
  String toString() {
    return 'Libraries(libraries: $libraries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LibrariesImpl &&
            const DeepCollectionEquality()
                .equals(other._libraries, _libraries));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_libraries));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LibrariesImplCopyWith<_$LibrariesImpl> get copyWith =>
      __$$LibrariesImplCopyWithImpl<_$LibrariesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LibrariesImplToJson(
      this,
    );
  }
}

abstract class _Libraries implements Libraries {
  const factory _Libraries(
      {@JsonKey(name: 'Items')
      required final List<LibraryEntity> libraries}) = _$LibrariesImpl;

  factory _Libraries.fromJson(Map<String, dynamic> json) =
      _$LibrariesImpl.fromJson;

  @override
  @JsonKey(name: 'Items')
  List<LibraryEntity> get libraries;
  @override
  @JsonKey(ignore: true)
  _$$LibrariesImplCopyWith<_$LibrariesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
