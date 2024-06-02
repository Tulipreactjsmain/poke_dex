import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  const PokemonListTile({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Pokemon?> pokemon =
        ref.watch(pokemonDataProvider(pokemonURL));
    return pokemon.when(
      data: (data) {
        return _tile(context: context, isLoading: false, pokemon: data);
      },
      error: (err, stacktrace) {
        return Text("Error:  $err");
      },
      loading: () {
        return _tile(context: context, isLoading: true, pokemon: null);
      },
    );
  }

  Widget _tile(
      {required BuildContext context,
      required bool isLoading,
      Pokemon? pokemon}) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        title: Text(pokemon != null
            ? pokemon.name!.toUpperCase()
            : "Currently loading..."),
      ),
    );
  }
}
