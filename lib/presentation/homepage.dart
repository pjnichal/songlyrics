import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/logic/connectivitybloc/connectivity_bloc.dart';

import '../logic/songbloc/songbloc_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<ConnectivityBloc>(context).add(ListenConnection());
    BlocProvider.of<SongBloc>(context).add(FetchSongs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SongLyrics"),
        centerTitle: true,
      ),
      body: BlocConsumer<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectionSuccess) {
            BlocProvider.of<SongBloc>(context).add(FetchSongs());
          }
        },
        builder: (context, state) {
          if (state is ConnectionFailure) {
            return const Center(
              child: Text("Check your internet"),
            );
          }
          return BlocBuilder<SongBloc, SongblocState>(
            builder: (context, state) {
              if (state is SongsLoadedSuccessFully) {
                return ListView.builder(
                  itemCount: state.songsList.length,
                  itemBuilder: ((context, index) => ListTile(
                        leading: Icon(Icons.music_note),
                        onTap: () {
                          Navigator.pushNamed(context, "/details",
                              arguments: state.songsList[index].track);
                        },
                        title: Text(state.songsList[index].track.trackName),
                        subtitle: Text(state.songsList[index].track.artistName),
                      )),
                );
              } else if (state is SongsFailed) {
                const Center(
                  child: Text("Oops Something went wrong"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
