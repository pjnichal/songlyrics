part of 'songbloc_bloc.dart';

@immutable
abstract class SongblocState {}

class SongblocInitial extends SongblocState {}



class SongLyricsLoaded extends SongblocState {
  final Lyrics lyrics;

  SongLyricsLoaded(this.lyrics);
}

class SongsLoadedSuccessFully extends SongblocState {
  final List<Song> songsList;

  SongsLoadedSuccessFully(this.songsList);
  @override
  List<Object> get props => [songsList];
}

class SongsFailed extends SongblocState {}
