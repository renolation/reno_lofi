import 'package:reno_music/features/player_screen/domain/playlist_entity.dart';

import '../features/player_screen/domain/audio_entity.dart';

const List<String> listTab = [
  'Home',
  'Search',
  'Notifications',
  'Profile',
  'Playlists'
];
const String urlMp3 =
    'https://b2.renolation.com/file/music-reno/chillhop-beat-quotthousand-milesquot-113254.mp3';

const List<AudioEntity> listAudio = [
  AudioEntity(
    posterUrl:
        'https://b2.renolation.com/file/music-reno/kellen-riggin-K9NOVc5dlAc-unsplash.jpg',
    fileUrl:
        'https://b2.renolation.com/file/music-reno/NemCauYeuVaoKhongTrung-HoangDungTheVoice-7817514.mp3',
    title: 'Flower Boy 1',
    artist: 'Kristaps Ungurs',
    album: 'Chillhop',
    genre: ['Chillhop'],
    duration: 180,
  ),
  AudioEntity(
    posterUrl:
        'https://b2.renolation.com/file/music-reno/kristaps-ungurs-hqXqJ5QTeQQ-unsplash.jpg',
    fileUrl:
        'https://b2.renolation.com/file/music-reno/chillhop-beat-quotthousand-milesquot-113254.mp3',
    title: 'Flower Boy 2',
    artist: 'Kristaps Ungurs',
    album: 'Chillhop',
    genre: ['Chillhop'],
    duration: 180,
  ),
  AudioEntity(
    posterUrl:
        'https://b2.renolation.com/file/music-reno/kellen-riggin-K9NOVc5dlAc-unsplash.jpg',
    fileUrl:
        'https://b2.renolation.com/file/music-reno/chillhop-beat-quotthousand-milesquot-113254.mp3',
    title: 'Flower Boy 3',
    artist: 'Kristaps Ungurs',
    album: 'Chillhop',
    genre: ['Chillhop'],
    duration: 180,
  ),
  AudioEntity(
    posterUrl:
        'https://b2.renolation.com/file/music-reno/kristaps-ungurs-hqXqJ5QTeQQ-unsplash.jpg',
    fileUrl:
        'https://b2.renolation.com/file/music-reno/NemCauYeuVaoKhongTrung-HoangDungTheVoice-7817514.mp3',
    title: 'Flower Boy 4',
    artist: 'Kristaps Ungurs',
    album: 'Chillhop',
    genre: ['Chillhop'],
    duration: 180,
  ),
];

const PlaylistEntity playlist = PlaylistEntity(
  poster:
      'https://b2.renolation.com/file/music-reno/kristaps-ungurs-hqXqJ5QTeQQ-unsplash.jpg',
  title: 'Chillhop',
  genre: 'Chillhop',
  author: 'Kristaps Ungurs',
  songs: listAudio,
);

class Constants {
  static const String host = '192.168.31.62';
  // static const String host = 'truyen.getdata.one';
  //
  static const String scheme = 'http';
  // static const String scheme = 'https';
  //
  static const int port = 3000;
  // static const int? port = null;
}
