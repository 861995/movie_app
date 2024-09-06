import 'package:Keeto_Movies/core/env/app_env.dart';
import 'package:Keeto_Movies/presentation/utils/app_const_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/movie_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/app_bar.dart';
import '../widgets/moview_widgets/movie_list_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        Provider.of<MovieProvider>(context, listen: false)
            .fetchMovies(AppEnv.popularKey),
        Provider.of<MovieProvider>(context, listen: false)
            .fetchMovies(AppEnv.topRateKey),
        Provider.of<MovieProvider>(context, listen: false)
            .fetchMovies(AppEnv.upcomingKey),
      ]);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: const CustomAppBar(
        title: "K-Movies",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            MovieListBuilder(
                title: AppConst.popularMovie, movieKey: AppEnv.popularKey),
            MovieListBuilder(
                title: AppConst.topRatedMovie, movieKey: AppEnv.topRateKey),
            MovieListBuilder(
                title: AppConst.upcomingMovie, movieKey: AppEnv.upcomingKey)
          ],
        ),
      ),
    );
  }
}
