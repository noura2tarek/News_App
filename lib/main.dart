import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layout/news_layout.dart';
import 'package:news_app/Network/Local/cache_helper.dart';
import 'package:news_app/Network/Remote/dio_helper.dart';
import 'package:news_app/Shared/Bloc/cubit.dart';
import 'package:news_app/Shared/Bloc/states.dart';
import 'package:news_app/Styles/themes.dart';

import 'Shared/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // to ensure that all methods finished before executing run app() method
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDarkTheme = CacheHelper.getBoolean(key: 'isDark');
  runApp( MyApp(isDarkTheme));
}

class MyApp extends StatelessWidget {
 final bool? issDark;
  MyApp(this.issDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..setMode(fromShared: issDark)..getBusinessData()..getScienceData()..getSportsData(),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'News App',
            debugShowCheckedModeBanner: false,
            //theme parameter executed when the theme mode is light
            //dark theme will executed when the theme mode is dark
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),

          );
        },

      ),
    );
  }
}

