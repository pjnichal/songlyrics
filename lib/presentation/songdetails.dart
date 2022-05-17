import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:songlyrics/logic/songbloc/songbloc_bloc.dart';

import '../logic/connectivitybloc/connectivity_bloc.dart';
import '../models/song.dart';

class SongDetails extends StatefulWidget {
  final Track track;
  const SongDetails({Key? key, required this.track}) : super(key: key);

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ConnectivityBloc>(context).add(ListenConnection());
    BlocProvider.of<SongBloc>(context)
        .add(FetchLyrics(trackId: widget.track.trackId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.track.trackName), centerTitle: true),
      body: BlocConsumer<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
        if (state is ConnectionFailure) {
          return const Center(
            child: Text("Check Internet connection"),
          );
        }
        return SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Text(
              widget.track.trackName,
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Artist",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Text(
              widget.track.artistName,
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Album Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Text(
              widget.track.albumName,
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Explicit",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Text(
              widget.track.explicit == 0 ? "True" : "False",
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Rating",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Text(
              widget.track.trackRating.toString(),
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Lyrics",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            BlocBuilder<SongBloc, SongblocState>(
              builder: (context, state) {
                if (state is SongLyricsLoaded) {
                  return Text(
                    state.lyrics.lyricsBody,
                    style: TextStyle(fontSize: 18.sp),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              },
            ),
          ],
        ));
      }, listener: (context, state) {
        if (state is ConnectionSuccess) {
          BlocProvider.of<SongBloc>(context)
              .add(FetchLyrics(trackId: widget.track.trackId.toString()));
        }
      }),
    );
  }
}
