import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/services/http_services.dart';

final pokemonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, url) async {
  HTTPService _httpService = GetIt.instance.get<HTTPService>();
  Response? res = await _httpService.get(url);

  if (res != null && res.data != 
  null) {
    return Pokemon.fromJson(res.data!);
  }
  return null;
});

final favoritePokemonsProvider =
    StateNotifierProvider((ref) => FavoritePokemonsProvider([]));

class FavoritePokemonsProvider extends StateNotifier<List<String>> {
  FavoritePokemonsProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {}
}
