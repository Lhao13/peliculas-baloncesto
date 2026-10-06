import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_pelis/Pantalla_AgregarPelicula.dart';
import 'package:proyecto_pelis/Pantalla_Principal.dart';
import 'package:rxdart/rxdart.dart';

import 'package:proyecto_pelis/modelos/pelicula_search_TMBD.dart';
import 'package:proyecto_pelis/widgets/appbar_default.dart';
import 'package:http/http.dart' as http;

import 'package:proyecto_pelis/globals.dart' as globals;

class Recomendados extends StatefulWidget {
  const Recomendados({super.key});

  @override
  State<Recomendados> createState() => _RecomendadosState();
}

class _RecomendadosState extends State<Recomendados> {
  List<PeliculaTmdb> movies = [];
  bool hasLoaded = true;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchMovies(' ');
    subject.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen(searchMovies);
  }

  void searchMovies(query) {
    resetMovies();
    if (query.isEmpty) {
      setState(() {
        hasLoaded = true;
      });
      return;
    }
    setState(() => hasLoaded = false);
    //cambiar el numero 4 por la categoria de pelicula que se desea ver
    http
        .get(Uri.parse('${globals.urif}/pelicula/$preferencia'))
        .then((res) => (res.body))
        .then(json.decode)
        .then((movies) => movies.forEach(addMovie))
        .catchError(onError)
        .then((e) {
      setState(() {
        hasLoaded = true;
      });
    });
  }

  void onError(dynamic d) {
    setState(() {
      hasLoaded = true;
    });
  }

  void addMovie(item) {
    setState(() {
      movies.add(PeliculaTmdb.fromJson(item));
    });
  }

  void resetMovies() {
    setState(() => movies.clear());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.01, 0.99],
            colors: [
              Color.fromARGB(255, 1, 34, 1),
              Color.fromARGB(237, 0, 195, 0)
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBarDefault(title: 'Recomendados'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(movies[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class buildCard extends StatefulWidget {
  buildCard(this.movie);
  final PeliculaTmdb movie;

  @override
  State<buildCard> createState() => _buildCardState();
}

class _buildCardState extends State<buildCard> {
  late PeliculaTmdb movieState;

  @override
  void initState() {
    super.initState();
    movieState = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        child: Card(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movieState.posterPath}',
                  filterQuality: FilterQuality.high,
                  height: 250,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  movieState.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieInfoWindow(movie: movieState),
            ),
          );
        },
      ),
    );
  }
}
