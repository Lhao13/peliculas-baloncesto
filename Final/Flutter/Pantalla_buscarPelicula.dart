import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:proyecto_pelis/modelos/pelicula_search_TMBD.dart';
import 'package:proyecto_pelis/Pantalla_AgregarPelicula.dart';
import 'package:proyecto_pelis/widgets/appbar_default.dart';
import 'package:http/http.dart' as http;

import 'package:proyecto_pelis/globals.dart'as globals;


class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({super.key});

  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
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
    http
        .get(Uri.parse(
          query == ' '
              ? '${globals.urif}/pelicula/?limit=200'
            :'${globals.urif}/pelicula/?search=$query&limit=200'))
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarDefault(title: 'Buscar Pelicula'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 68, 0, 0),
              Color.fromARGB(198, 162, 0, 0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 80),
              TextField(
                //controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Buscar pelicula',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                onChanged: (String string) => (subject.add(string==''?' ':string)),
              ),
              const SizedBox(height: 20),
              hasLoaded ? Container() : const CircularProgressIndicator(),
              Expanded(
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new MovieView(movies[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieView extends StatefulWidget {
  MovieView(this.movie);
  final PeliculaTmdb movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late PeliculaTmdb movieState;

  @override
  void initState() {
    super.initState();
    movieState = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            child: Card(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Row(
                children: [
                  movieState.posterPath == null
                  ?Image.asset(
                      'assets/imagenes/Kronii.png',
                      height: 200,
                  )
                  :ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      filterQuality: FilterQuality.high,
                      height: 200,
                      'https://image.tmdb.org/t/p/w500/${movieState.posterPath}',
                    ),
                  ),
                  const SizedBox(width: 5),
                   Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 13),
                        Text(
                          movieState.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Lanzamiento: ${movieState.releaseDate.year}-${movieState.releaseDate.month}-${movieState.releaseDate.day}',
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'sinopsis: ${movieState.overview}',
                          softWrap: true,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
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
        ),
        const SizedBox(height: 20), 
      ],
    );
  }
}
