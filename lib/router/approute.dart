import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songlyrics/logic/connectivitybloc/connectivity_bloc.dart';
import 'package:songlyrics/logic/songbloc/songbloc_bloc.dart';
import 'package:songlyrics/presentation/homepage.dart';
import 'package:songlyrics/providers/songprovider.dart';
import 'package:songlyrics/repository/songsrepository.dart';
import 'package:http/http.dart' as http;

import '../models/song.dart';
import '../presentation/songdetails.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    late Song song;
    final connectionBloc = ConnectivityBloc();
    final songBloc =
        SongBloc(SongRepository(songProvider: SongProvider(http.Client())));
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: ((context) => songBloc)),
                    BlocProvider(
                        create: ((context) =>
                            connectionBloc..add(InitialListenConnection()))),
                  ],
                  child: HomePage(),
                ));
      case '/details':
        return MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: ((context) => songBloc)),
                    BlocProvider(
                        create: ((context) =>
                            connectionBloc..add(InitialListenConnection()))),
                  ],
                  child: SongDetails(track: routeSettings.arguments as Track),
                )));
    }
  }
}
