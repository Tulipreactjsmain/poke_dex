// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_dex/controllers/home_page_controller.dart';
import 'package:poke_dex/models/page_data.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomePageController _homePageController;
  late HomePageData _homePageData;
  
  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);

    return Scaffold(
        body: _buildUI(
      context,
    ));
  }
}

Widget _buildUI(BuildContext context) {
  return SafeArea(
      child: SingleChildScrollView(
    child: Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_allPokemonList(context)],
      ),
    ),
  ));
}

Widget _allPokemonList(BuildContext context) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Pokemon',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.60,
          child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) {
                return ListTile();
              }),
        ),
      ],
    ),
  );
}
