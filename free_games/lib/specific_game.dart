import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_games/constant.dart';
import 'package:free_games/main_cubit.dart';
import 'package:free_games/main_states.dart';
import 'package:url_launcher/link.dart';

class SpecificGame extends StatelessWidget {
  final id;
  const SpecificGame({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    internetConection(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade800,
      ),
    );
    return BlocConsumer<MainCubit, MainState>(
      bloc: MainCubit.get(context)..getSpecificGame(id),
      listener: (context, state) {},
      builder: (context, state) {
        print(id);
        MainCubit ref = MainCubit.get(context);
        return ref.specificGame.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: Colors.grey.shade900,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade800,
                  title: Text(
                    ref.specificGame['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      )),
                ),
                body: state is LoadingGetSpecificGameState
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 220,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(
                                  seconds: 3,
                                ),
                                autoPlayAnimationDuration: const Duration(
                                  seconds: 1,
                                ),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal,
                                viewportFraction: 1,
                              ),
                              items: ref.images.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Image.network(
                                      i,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            ref.specificGame['minimum_system_requirements'] ==
                                    null
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Minimum System Requirements: ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          left: 30.0,
                                        ),
                                        child: Text(
                                          '⚫  OS: ${ref.specificGame['minimum_system_requirements']['os']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          left: 30.0,
                                        ),
                                        child: Text(
                                          '⚫  Processor: ${ref.specificGame['minimum_system_requirements']['processor']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          left: 30.0,
                                        ),
                                        child: Text(
                                          '⚫  Memory: ${ref.specificGame['minimum_system_requirements']['memory']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          left: 30.0,
                                        ),
                                        child: Text(
                                          '⚫  Graphics: ${ref.specificGame['minimum_system_requirements']['graphics']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          left: 30.0,
                                        ),
                                        child: Text(
                                          '⚫  Storage: ${ref.specificGame['minimum_system_requirements']['storage']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                            const Divider(color: Colors.white),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Go To Game: ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Link(
                              target: LinkTarget.self,
                              uri: Uri.parse(ref.specificGame['game_url']),
                              builder: (context, followLink) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: followLink,
                                    child: Text(ref.specificGame['game_url'],
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                );
                              },
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: TextButton(
                            //     onPressed: () async {
                            //       await launchUrlFun(
                            //           ref.specificGame['game_url']);
                            //     },
                            //     child: Text(ref.specificGame['game_url'],
                            //         style: const TextStyle(
                            //           color: Colors.blue,
                            //           decoration: TextDecoration.underline,
                            //           fontWeight: FontWeight.bold,
                            //         )),
                            //   ),
                            // ),
                            const Divider(color: Colors.white),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Description: ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ref.specificGame['description'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
              );
      },
    );
  }
}
