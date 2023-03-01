import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_games/home.dart';
import 'package:free_games/main_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'free games',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        themeMode: ThemeMode.dark,
        home: const Home(),
      ),
    );
  }
}
