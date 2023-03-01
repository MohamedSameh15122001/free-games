import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_games/constant.dart';
import 'package:free_games/search.dart';
import 'package:free_games/specific_game.dart';
import 'main_cubit.dart';
import 'main_states.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    internetConection(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade800,
      ),
    );
    return BlocConsumer<MainCubit, MainState>(
      bloc: MainCubit.get(context)..getAllGames(),
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit ref = MainCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            elevation: 0,
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(Icons.filter_list_rounded,
                        color: Colors.white),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Search();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
            backgroundColor: Colors.grey.shade800,
            title: const Text(
              'Top Free Games',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: state is LoadingGetAllGamesState
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: ref.allGames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SpecificGame(
                              id: ref.allGames[index]['id'],
                            );
                          },
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ref.allGames[index]['title'],
                              // textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'release_date: ${ref.allGames[index]['release_date']}',
                              // textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.network(
                            ref.allGames[index]['thumbnail'],
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ref.allGames[index]['short_description'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'genre: ${ref.allGames[index]['genre']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'platform: ${ref.allGames[index]['platform']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'publisher: ${ref.allGames[index]['publisher']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'developer: ${ref.allGames[index]['developer']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  },
                ),
          //----------------------------------------
          //the Drawer
          //----------------------------------------
          endDrawer: Drawer(
            backgroundColor: Colors.grey[900],
            child: SafeArea(
              child: Column(
                children: [
                  //platform
                  DropdownSearch<String>(
                    onChanged: (newValue) async {
                      await ref.changePlatformSelectedItem(newValue);
                      await ref.getAllGames(
                        platform: ref.platformSelectedItem,
                        category: ref.categorySelectedItem,
                        sortBy: ref.sortBySelectedItem,
                      );
                    },
                    dropdownButtonProps:
                        const DropdownButtonProps(color: Colors.white),
                    dropdownBuilder: (context, selectedItem) {
                      return Container(
                        // height: 40,
                        // padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          // color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              // const Icon(Icons.arrow_drop_down,
                              //     color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    },
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        );
                      },
                      containerBuilder: (ctx, popupWidget) {
                        return Container(
                          color: Colors.grey[900],
                          child: popupWidget,
                        );
                      },
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: ref.platforms,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: "Platform",
                        labelStyle: TextStyle(color: Colors.grey[500]),
                        // hintText: "country in menu mode",
                      ),
                    ),
                    selectedItem: ref.platformSelectedItem,
                  ),
                  const Divider(color: Colors.white),
                  //category
                  DropdownSearch<String>(
                    onChanged: (newValue) async {
                      await ref.changeCategorySelectedItem(newValue);
                      await ref.getAllGames(
                        platform: ref.platformSelectedItem,
                        category: ref.categorySelectedItem,
                        sortBy: ref.sortBySelectedItem,
                      );
                    },
                    dropdownButtonProps:
                        const DropdownButtonProps(color: Colors.white),
                    dropdownBuilder: (context, selectedItem) {
                      return Container(
                        // height: 40,
                        decoration: BoxDecoration(
                          // color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              // const Icon(Icons.arrow_drop_down,
                              //     color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    },
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        );
                      },
                      containerBuilder: (ctx, popupWidget) {
                        return Container(
                          color: Colors.grey[900],
                          child: popupWidget,
                        );
                      },
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: ref.categorys,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: "Category",
                        // hintText: "country in menu mode",
                        labelStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    selectedItem: ref.categorySelectedItem,
                  ),
                  const Divider(color: Colors.white),
                  DropdownSearch<String>(
                    onChanged: (newValue) async {
                      await ref.changeSortBySelectedItem(newValue);
                      await ref.getAllGames(
                        platform: ref.platformSelectedItem,
                        category: ref.categorySelectedItem,
                        sortBy: ref.sortBySelectedItem,
                      );
                    },
                    dropdownButtonProps:
                        const DropdownButtonProps(color: Colors.white),
                    dropdownBuilder: (context, selectedItem) {
                      return Container(
                        // height: 40,
                        decoration: BoxDecoration(
                          // color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              // const Icon(Icons.arrow_drop_down,
                              //     color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    },
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        );
                      },
                      containerBuilder: (ctx, popupWidget) {
                        return Container(
                          color: Colors.grey[900],
                          child: popupWidget,
                        );
                      },
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: ref.sortBy,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        labelStyle: TextStyle(color: Colors.grey[500]),
                        // hintStyle: TextStyle(color: Colors.white),
                        // iconColor: Colors.white,
                        labelText: "Sort By",
                        // hintText: "country in menu mode",
                      ),
                    ),
                    selectedItem: ref.sortBySelectedItem,
                  ),
                  const Divider(color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
