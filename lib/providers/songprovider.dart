import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:songlyrics/logic/songbloc/songbloc_bloc.dart';
import 'package:songlyrics/models/lyrics.dart';

import '../models/song.dart';

class SongProvider {
  final http.Client httpClient;

  SongProvider(this.httpClient);
  Future<List<Song>> fetchSongs() async {
    final url =
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7&chart.tracks.get?chart_name=top&page=1&page_size=500&f_has_lyrics=1';

    final response = await this.httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }
    final json = jsonDecode(response.body.toString());

    final songs = json['message']['body']['track_list'];
    print(songs);
    print(songFromJson(jsonEncode(songs)));
    return songFromJson(jsonEncode(songs));
  }

  Future<Lyrics> fetchLyrics(String trackId) async {
    final url =
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7&track_id=$trackId';

    final response = await this.httpClient.get(Uri.parse(url));

    final json = jsonDecode(response.body.toString());

    final lyrics = json['message']['body']['lyrics'];

    print(lyricsFromJson(jsonEncode(lyrics)));
    return lyricsFromJson(jsonEncode(lyrics));
  }
}
