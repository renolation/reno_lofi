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
  String? get posterUrl => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get artist => throw _privateConstructorUsedError;
  String? get album => throw _privateConstructorUsedError;
  List<String>? get genre => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;

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
      {String? posterUrl,
      String? fileUrl,
      String? title,
      String? artist,
      String? album,
      List<String>? genre,
      int? duration});
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
    Object? posterUrl = freezed,
    Object? fileUrl = freezed,
    Object? title = freezed,
    Object? artist = freezed,
    Object? album = freezed,
    Object? genre = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
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
              as List<String>?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {String? posterUrl,
      String? fileUrl,
      String? title,
      String? artist,
      String? album,
      List<String>? genre,
      int? duration});
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
    Object? posterUrl = freezed,
    Object? fileUrl = freezed,
    Object? title = freezed,
    Object? artist = freezed,
    Object? album = freezed,
    Object? genre = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_AudioEntity(
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
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
          ? _value._genre
          : genre // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AudioEntity implements _AudioEntity {
  const _$_AudioEntity(
      {this.posterUrl = '',
      this.fileUrl = '',
      this.title = '',
      this.artist = '',
      this.album = '',
      final List<String>? genre = const [],
      this.duration = 0})
      : _genre = genre;

  factory _$_AudioEntity.fromJson(Map<String, dynamic> json) =>
      _$$_AudioEntityFromJson(json);

  @override
  @JsonKey()
  final String? posterUrl;
  @override
  @JsonKey()
  final String? fileUrl;
  @override
  @JsonKey()
  final String? title;
  @override
  @JsonKey()
  final String? artist;
  @override
  @JsonKey()
  final String? album;
  final List<String>? _genre;
  @override
  @JsonKey()
  List<String>? get genre {
    final value = _genre;
    if (value == null) return null;
    if (_genre is EqualUnmodifiableListView) return _genre;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int? duration;

  @override
  String toString() {
    return 'AudioEntity(posterUrl: $posterUrl, fileUrl: $fileUrl, title: $title, artist: $artist, album: $album, genre: $genre, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioEntity &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            const DeepCollectionEquality().equals(other._genre, _genre) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, posterUrl, fileUrl, title,
      artist, album, const DeepCollectionEquality().hash(_genre), duration);

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
      {final String? posterUrl,
      final String? fileUrl,
      final String? title,
      final String? artist,
      final String? album,
      final List<String>? genre,
      final int? duration}) = _$_AudioEntity;

  factory _AudioEntity.fromJson(Map<String, dynamic> json) =
      _$_AudioEntity.fromJson;

  @override
  String? get posterUrl;
  @override
  String? get fileUrl;
  @override
  String? get title;
  @override
  String? get artist;
  @override
  String? get album;
  @override
  List<String>? get genre;
  @override
  int? get duration;
  @override
  @JsonKey(ignore: true)
  _$$_AudioEntityCopyWith<_$_AudioEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
