import 'package:songlyrics/models/lyrics.dart';

import '../models/song.dart';
import '../providers/songprovider.dart';

class SongRepository {
  final SongProvider songProvider;
  SongRepository({required this.songProvider});
  Future<List<Song>> fetchSongs() async {
    return songProvider.fetchSongs();
  }

  Future<Lyrics> fetchLyrics(String trackId) async {
    return songProvider.fetchLyrics(trackId);
  }
}
