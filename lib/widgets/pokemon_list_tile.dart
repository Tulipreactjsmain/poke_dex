import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  late FavoritePokemonsController _favoritePokemonsProvider;
  late List<String> _favoritePokemons;

  PokemonListTile({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonsProvider = ref.watch(favoritePokemonsProvider.notifier);
    _favoritePokemons = ref.watch(favoritePokemonsProvider);

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
        leading: pokemon != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),
              )
            : const CircleAvatar(),
        title: Text(pokemon != null
            ? pokemon.name!.toUpperCase()
            : "Currently loading..."),
        subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves"),
        trailing: IconButton(
          onPressed: () {
            if (_favoritePokemons.contains(pokemonURL)) {
              _favoritePokemonsProvider.removeFavoritePokemon(pokemonURL);
            } else {
              _favoritePokemonsProvider.addFavoritePokemon(pokemonURL);
            }
            // _favoritePokemonsProvider.update(_favoritePokemons);
          },
          icon: Icon(_favoritePokemons.contains(pokemonURL)
              ? Icons.favorite
              : Icons.favorite_border),
          color: Colors.red,
        ),
      ),
    );
  }
}
