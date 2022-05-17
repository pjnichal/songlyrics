part of 'songbloc_bloc.dart';

@immutable
abstract class SongblocEvent {}

class FetchSongs extends SongblocEvent {
  @override
  List<Object?> get props => [];
}

class FetchLyrics extends SongblocEvent {
  final String trackId;

  FetchLyrics({required this.trackId});
  @override
  List<Object?> get props => [trackId];
}
