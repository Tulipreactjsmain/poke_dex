import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_dex/controllers/home_page_controller.dart';

import 'pokemon.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>(
        (ref) => HomePageController(HomePageData.initial()));

class HomePageData {
  PokemonListData? data;

  HomePageData({
    required this.data,
  });

  HomePageData.initial() : data = null;

  HomePageData copyWith({PokemonListData? data}) {
    return HomePageData(
      data: data ?? this.data,
    );
  }
}

class NewState {
  PokemonListData? data;
}
