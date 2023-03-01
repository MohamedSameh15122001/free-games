import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_games/main_states.dart';
import 'package:http/http.dart' as http;

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);

  String platformSelectedItem = 'All';
  String categorySelectedItem = 'All';
  String sortBySelectedItem = 'All';

  changePlatformSelectedItem(newValue) {
    platformSelectedItem = newValue;
    emit(ChangePlatformSelectedItem());
  }

  changeCategorySelectedItem(newValue) {
    categorySelectedItem = newValue;
    emit(ChangeCategorySelectedItem());
  }

  changeSortBySelectedItem(newValue) {
    sortBySelectedItem = newValue;
    emit(ChangeSortBySelectedItem());
  }

  List allGames = [];
  bool x = false;
  // getAllGames({platform = '', category = '', sortBy = ''}) async {
  //   platform == 'All' ? platform = '' : x = !x;
  //   category == 'All' ? category = '' : x = !x;
  //   sortBy == 'All' ? sortBy = '' : x = !x;
  //   emit(LoadingGetAllGamesState());
  //   final headers = {
  //     'X-RapidAPI-Key': 'f806056228msh1b0793655feb2bfp13396ajsnb8b056de3ed4',
  //     'X-RapidAPI-Host': 'free-to-play-games-database.p.rapidapi.com',
  //   };
  //   String url = '';
  //   if (platform.isEmpty && category.isEmpty && sortBy.isEmpty) {
  //     url = 'https://free-to-play-games-database.p.rapidapi.com/api/games';
  //   } else if (platform.isNotEmpty && category.isEmpty && sortBy.isEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?platform=$platform';
  //   } else if (platform.isEmpty && category.isNotEmpty && sortBy.isEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?category=$category';
  //   } else if (platform.isEmpty && category.isEmpty && sortBy.isNotEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?sort-by=$sortBy';
  //   } else if (platform.isEmpty && category.isNotEmpty && sortBy.isNotEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?sort-by=$sortBy&category=$category';
  //   } else if (platform.isNotEmpty && category.isEmpty && sortBy.isNotEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?sort-by=$sortBy&platform=$platform';
  //   } else if (platform.isNotEmpty && category.isNotEmpty && sortBy.isEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?category=$category&platform=$platform';
  //   } else if (platform.isNotEmpty &&
  //       category.isNotEmpty &&
  //       sortBy.isNotEmpty) {
  //     url =
  //         'https://free-to-play-games-database.p.rapidapi.com/api/games?category=$category&platform=$platform&sort-by=$sortBy';
  //   } else {
  //     print('shit');
  //   }
  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     allGames = jsonDecode(response.body);
  //     print(allGames);
  //     print(response.statusCode);
  //     print('[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]');
  //     emit(SuccessGetAllGamesState());
  //   } else {
  //     emit(ErrorGetAllGamesState());
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }
  getAllGames({platform = '', category = '', sortBy = ''}) async {
    platform == 'All' ? platform = '' : x = !x;
    category == 'All' ? category = '' : x = !x;
    sortBy == 'All' ? sortBy = '' : x = !x;
    emit(LoadingGetAllGamesState());
    final headers = {
      'X-RapidAPI-Key': 'f806056228msh1b0793655feb2bfp13396ajsnb8b056de3ed4',
      'X-RapidAPI-Host': 'mmo-games.p.rapidapi.com',
    };
    String url = '';
    if (platform.isEmpty && category.isEmpty && sortBy.isEmpty) {
      url = 'https://mmo-games.p.rapidapi.com/games';
    } else if (platform.isNotEmpty && category.isEmpty && sortBy.isEmpty) {
      url = 'https://mmo-games.p.rapidapi.com/games?platform=$platform';
    } else if (platform.isEmpty && category.isNotEmpty && sortBy.isEmpty) {
      url = 'https://mmo-games.p.rapidapi.com/games?category=$category';
    } else if (platform.isEmpty && category.isEmpty && sortBy.isNotEmpty) {
      url = 'https://mmo-games.p.rapidapi.com/games?sort-by=$sortBy';
    } else if (platform.isEmpty && category.isNotEmpty && sortBy.isNotEmpty) {
      url =
          'https://mmo-games.p.rapidapi.com/games?sort-by=$sortBy&category=$category';
    } else if (platform.isNotEmpty && category.isEmpty && sortBy.isNotEmpty) {
      url =
          'https://mmo-games.p.rapidapi.com/games?sort-by=$sortBy&platform=$platform';
    } else if (platform.isNotEmpty && category.isNotEmpty && sortBy.isEmpty) {
      url =
          'https://mmo-games.p.rapidapi.com/games?category=$category&platform=$platform';
    } else if (platform.isNotEmpty &&
        category.isNotEmpty &&
        sortBy.isNotEmpty) {
      url =
          'https://mmo-games.p.rapidapi.com/games?category=$category&platform=$platform&sort-by=$sortBy';
    } else {
      print('shit');
    }
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      allGames = jsonDecode(response.body);
      // print(allGames);
      // print(response.statusCode);
      // print('[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]');
      emit(SuccessGetAllGamesState());
    } else {
      emit(ErrorGetAllGamesState());
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Map specificGame = {};
  List images = [];
  getSpecificGame(id) async {
    emit(LoadingGetSpecificGameState());
    final headers = {
      'X-RapidAPI-Key': 'f806056228msh1b0793655feb2bfp13396ajsnb8b056de3ed4',
      'X-RapidAPI-Host': 'mmo-games.p.rapidapi.com',
    };
    final response = await http.get(
      Uri.parse('https://mmo-games.p.rapidapi.com/game?id=$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      images = [];
      specificGame = jsonDecode(response.body);
      for (var i = 0; i < specificGame['screenshots'].length; i++) {
        images.add(specificGame['screenshots'][i]['image']);
      }
      for (int i = 0; i < specificGame['description'].length; i++) {
        if (specificGame['description'][i] == '<') {
          int j = specificGame['description'].indexOf('>', i);
          specificGame['description'] =
              specificGame['description'].replaceRange(i, j + 1, '');
        }
      }

      emit(SuccessGetSpecificGameState());
    } else {
      emit(ErrorGetSpecificGameState());
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List result = [];
  search(value) {
    result =
        allGames.where((element) => element['title'].contains(value)).toList();
    emit(SearhItem());
  }

  List<String> platforms = ['All', 'pc', 'browser'];

  List<String> categorys = [
    'All',
    'mmorpg',
    'mmo',
    'shooter',
    'strategy',
    'moba',
    'card',
    'Racing',
    'Sports',
    'Social',
    'Fighting',
    'MMOFPS',
    'Action-RPG',
    'Sandbox',
    'Open-World',
    'Survival',
    'Battle-Royale',
    'MMOTPS',
    'Anime',
    'PvP',
    'PvE',
    'Pixel',
    'MMORTS',
    'Fantasy',
    'Sci-Fi',
    'Action',
    'Voxel',
    'Zombie',
    'Turn-Based',
    'First-Person',
    'Third-Person',
    'Top-Down',
    '3D',
    '2D',
    'Tank',
    'Space',
    'Sailing',
    'Side-Scroller',
    'Superhero',
    'Permadeath',
  ];
  List<String> sortBy = [
    'All',
    'Relevance',
    'Popularity',
    'Release-Date',
    'Alphabetical',
  ];
}
// platform 
// category 
// sort_by 
