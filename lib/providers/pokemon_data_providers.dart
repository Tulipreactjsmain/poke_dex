// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/services/database_service.dart';
import 'package:poke_dex/services/http_services.dart';

final pokemonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, url) async {
  HTTPService _httpService = GetIt.instance.get<HTTPService>();
  Response? res = await _httpService.get(url);

  if (res != null && res.data != null) {
    return Pokemon.fromJson(res.data!);
  }
  return null;
});

final favoritePokemonsProvider =
    StateNotifierProvider<FavoritePokemonsController, List<String>>(
        (ref) => FavoritePokemonsController([]));

class FavoritePokemonsController extends StateNotifier<List<String>> {
  final DatabaseService _databaseService =
      GetIt.instance.get<DatabaseService>();

  static const String FAVORITE_POKEMON_LIST_KEY = " FAVORITE_POKEMON_LIST_KEY ";

  FavoritePokemonsController(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    final List<String>? result = await _databaseService.getList(FAVORITE_POKEMON_LIST_KEY);
    state = result?? [];
  }

  void addFavoritePokemon(String url) {
    state = [...state, url];
    _databaseService.saveList(FAVORITE_POKEMON_LIST_KEY, state);
  }

  void removeFavoritePokemon(String url) {
    state = state.where((element) => element != url).toList();
    _databaseService.saveList(FAVORITE_POKEMON_LIST_KEY, state);
  }
}
