// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AudioEntity _$AudioEntityFromJson(Map<String, dynamic> json) {
  return _AudioEntity.fromJson(json);
}

/// @nodoc
mixin _$AudioEntity {
  String? get poster => throw _privateConstructorUsedError;
  String? get linkPath => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get artist => throw _privateConstructorUsedError;
  String? get album => throw _privateConstructorUsedError;
  String? get genre => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioEntityCopyWith<AudioEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioEntityCopyWith<$Res> {
  factory $AudioEntityCopyWith(
          AudioEntity value, $Res Function(AudioEntity) then) =
      _$AudioEntityCopyWithImpl<$Res, AudioEntity>;
  @useResult
  $Res call(
      {String? poster,
      String? linkPath,
      String? title,
      String? artist,
      String? album,
      String? genre,
      String? duration});
}

/// @nodoc
class _$AudioEntityCopyWithImpl<$Res, $Val extends AudioEntity>
    implements $AudioEntityCopyWith<$Res> {
  _$AudioEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poster = freezed,
    Object? linkPath = freezed,
    Object? title = freezed,
    Object? artist = freezed,
    Object? album = freezed,
    Object? genre = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      poster: freezed == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      linkPath: freezed == linkPath
          ? _value.linkPath
          : linkPath // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      artist: freezed == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioEntityCopyWith<$Res>
    implements $AudioEntityCopyWith<$Res> {
  factory _$$_AudioEntityCopyWith(
          _$_AudioEntity value, $Res Function(_$_AudioEntity) then) =
      __$$_AudioEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? poster,
      String? linkPath,
      String? title,
      String? artist,
      String? album,
      String? genre,
      String? duration});
}

/// @nodoc
class __$$_AudioEntityCopyWithImpl<$Res>
    extends _$AudioEntityCopyWithImpl<$Res, _$_AudioEntity>
    implements _$$_AudioEntityCopyWith<$Res> {
  __$$_AudioEntityCopyWithImpl(
      _$_AudioEntity _value, $Res Function(_$_AudioEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poster = freezed,
    Object? linkPath = freezed,
    Object? title = freezed,
    Object? artist = freezed,
    Object? album = freezed,
    Object? genre = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_AudioEntity(
      poster: freezed == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      linkPath: freezed == linkPath
          ? _value.linkPath
          : linkPath // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      artist: freezed == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AudioEntity implements _AudioEntity {
  const _$_AudioEntity(
      {this.poster = '',
      this.linkPath = '',
      this.title = '',
      this.artist = '',
      this.album = '',
      this.genre = '',
      this.duration = ''});

  factory _$_AudioEntity.fromJson(Map<String, dynamic> json) =>
      _$$_AudioEntityFromJson(json);

  @override
  @JsonKey()
  final String? poster;
  @override
  @JsonKey()
  final String? linkPath;
  @override
  @JsonKey()
  final String? title;
  @override
  @JsonKey()
  final String? artist;
  @override
  @JsonKey()
  final String? album;
  @override
  @JsonKey()
  final String? genre;
  @override
  @JsonKey()
  final String? duration;

  @override
  String toString() {
    return 'AudioEntity(poster: $poster, linkPath: $linkPath, title: $title, artist: $artist, album: $album, genre: $genre, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioEntity &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.linkPath, linkPath) ||
                other.linkPath == linkPath) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, poster, linkPath, title, artist, album, genre, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioEntityCopyWith<_$_AudioEntity> get copyWith =>
      __$$_AudioEntityCopyWithImpl<_$_AudioEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AudioEntityToJson(
      this,
    );
  }
}

abstract class _AudioEntity implements AudioEntity {
  const factory _AudioEntity(
      {final String? poster,
      final String? linkPath,
      final String? title,
      final String? artist,
      final String? album,
      final String? genre,
      final String? duration}) = _$_AudioEntity;

  factory _AudioEntity.fromJson(Map<String, dynamic> json) =
      _$_AudioEntity.fromJson;

  @override
  String? get poster;
  @override
  String? get linkPath;
  @override
  String? get title;
  @override
  String? get artist;
  @override
  String? get album;
  @override
  String? get genre;
  @override
  String? get duration;
  @override
  @JsonKey(ignore: true)
  _$$_AudioEntityCopyWith<_$_AudioEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
