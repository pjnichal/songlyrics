import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:songlyrics/models/lyrics.dart';
import 'package:songlyrics/repository/songsrepository.dart';

import '../../models/song.dart';

part 'songbloc_event.dart';
part 'songbloc_state.dart';

class SongBloc extends Bloc<SongblocEvent, SongblocState> {
  final SongRepository songRepository;

  SongBloc(this.songRepository) : super(SongblocInitial()) {
    on<SongblocEvent>((event, emit) async {
      if (event is FetchSongs) {
        try {
          final List<Song> response = await songRepository.fetchSongs();
          emit(SongsLoadedSuccessFully(response));
        } catch (e) {
          emit(SongsFailed());
        }
      }
      if (event is FetchLyrics) {
        final Lyrics lyrics = await songRepository.fetchLyrics(event.trackId);
        emit(SongLyricsLoaded(lyrics));
      }
    });
  }
}
