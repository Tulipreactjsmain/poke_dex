import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/providers/pokemon_data_providers.dart';

class PokemonCard extends ConsumerWidget {
  const PokemonCard({super.key, required this.pokemonURL});
  final String pokemonURL;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Pokemon?> pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return pokemon.when(
        data: (data) {
          return _card(context, false, data);
        },
        error: (error, stackTrace) {
          return Text("error: $error");
        },
        loading: () => _card(context, true, null));
  }

  Widget _card(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03,
          vertical: MediaQuery.sizeOf(context).height * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03,
          vertical: MediaQuery.sizeOf(context).height * 0.01),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ]),
    );
  }
}
