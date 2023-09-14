// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaylistEntity _$PlaylistEntityFromJson(Map<String, dynamic> json) {
  return _PlaylistEntity.fromJson(json);
}

/// @nodoc
mixin _$PlaylistEntity {
  String? get poster => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get genre => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  List<AudioEntity>? get songs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistEntityCopyWith<PlaylistEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistEntityCopyWith<$Res> {
  factory $PlaylistEntityCopyWith(
          PlaylistEntity value, $Res Function(PlaylistEntity) then) =
      _$PlaylistEntityCopyWithImpl<$Res, PlaylistEntity>;
  @useResult
  $Res call(
      {String? poster,
      String? title,
      String? genre,
      String? author,
      List<AudioEntity>? songs});
}

/// @nodoc
class _$PlaylistEntityCopyWithImpl<$Res, $Val extends PlaylistEntity>
    implements $PlaylistEntityCopyWith<$Res> {
  _$PlaylistEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poster = freezed,
    Object? title = freezed,
    Object? genre = freezed,
    Object? author = freezed,
    Object? songs = freezed,
  }) {
    return _then(_value.copyWith(
      poster: freezed == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      songs: freezed == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<AudioEntity>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlaylistEntityCopyWith<$Res>
    implements $PlaylistEntityCopyWith<$Res> {
  factory _$$_PlaylistEntityCopyWith(
          _$_PlaylistEntity value, $Res Function(_$_PlaylistEntity) then) =
      __$$_PlaylistEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? poster,
      String? title,
      String? genre,
      String? author,
      List<AudioEntity>? songs});
}

/// @nodoc
class __$$_PlaylistEntityCopyWithImpl<$Res>
    extends _$PlaylistEntityCopyWithImpl<$Res, _$_PlaylistEntity>
    implements _$$_PlaylistEntityCopyWith<$Res> {
  __$$_PlaylistEntityCopyWithImpl(
      _$_PlaylistEntity _value, $Res Function(_$_PlaylistEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poster = freezed,
    Object? title = freezed,
    Object? genre = freezed,
    Object? author = freezed,
    Object? songs = freezed,
  }) {
    return _then(_$_PlaylistEntity(
      poster: freezed == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      songs: freezed == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<AudioEntity>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlaylistEntity implements _PlaylistEntity {
  const _$_PlaylistEntity(
      {this.poster = '',
      this.title = '',
      this.genre = '',
      this.author = '',
      final List<AudioEntity>? songs = const []})
      : _songs = songs;

  factory _$_PlaylistEntity.fromJson(Map<String, dynamic> json) =>
      _$$_PlaylistEntityFromJson(json);

  @override
  @JsonKey()
  final String? poster;
  @override
  @JsonKey()
  final String? title;
  @override
  @JsonKey()
  final String? genre;
  @override
  @JsonKey()
  final String? author;
  final List<AudioEntity>? _songs;
  @override
  @JsonKey()
  List<AudioEntity>? get songs {
    final value = _songs;
    if (value == null) return null;
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PlaylistEntity(poster: $poster, title: $title, genre: $genre, author: $author, songs: $songs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaylistEntity &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._songs, _songs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, poster, title, genre, author,
      const DeepCollectionEquality().hash(_songs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaylistEntityCopyWith<_$_PlaylistEntity> get copyWith =>
      __$$_PlaylistEntityCopyWithImpl<_$_PlaylistEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaylistEntityToJson(
      this,
    );
  }
}

abstract class _PlaylistEntity implements PlaylistEntity {
  const factory _PlaylistEntity(
      {final String? poster,
      final String? title,
      final String? genre,
      final String? author,
      final List<AudioEntity>? songs}) = _$_PlaylistEntity;

  factory _PlaylistEntity.fromJson(Map<String, dynamic> json) =
      _$_PlaylistEntity.fromJson;

  @override
  String? get poster;
  @override
  String? get title;
  @override
  String? get genre;
  @override
  String? get author;
  @override
  List<AudioEntity>? get songs;
  @override
  @JsonKey(ignore: true)
  _$$_PlaylistEntityCopyWith<_$_PlaylistEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
