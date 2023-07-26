import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Layout/news_layout.dart';
import 'package:news_app/Network/Local/cache_helper.dart';
import 'package:news_app/Network/Remote/dio_helper.dart';
import 'package:news_app/Shared/Bloc/cubit.dart';
import 'package:news_app/Shared/Bloc/states.dart';

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
            theme: ThemeData(
              dividerTheme: DividerThemeData(
                color: Colors.grey[400],
              ),
              primarySwatch: Colors.indigo,
              primaryColor: Colors.indigo,
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                  bodySmall: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
              ),
              appBarTheme: const AppBarTheme(
                titleSpacing: 16.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  )
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),

              //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //useMaterial3: true,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.grey,
              dividerTheme: DividerThemeData(
                color: Colors.grey[200],
              ),
              inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                prefixIconColor: Colors.white,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),

              ),
              scaffoldBackgroundColor: HexColor('333739'),

              textTheme: const TextTheme(
                  bodySmall: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  )
              ),
              appBarTheme: AppBarTheme(
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                elevation: 8.0,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
              ),
            ),
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),

          );
        },

      ),
    );
  }
}

