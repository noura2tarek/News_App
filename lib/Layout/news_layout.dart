import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Pages/search_screen.dart';
import 'package:news_app/Shared/Bloc/cubit.dart';
import 'package:news_app/Shared/Bloc/states.dart';
import 'package:news_app/Shared/Components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App', style: Theme.of(context).appBarTheme.titleTextStyle),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context: context, widget: SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: (){
                   cubit.changeMode();
                },
                icon: const Icon(
                  Icons.brightness_4,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cubit.currentIndex,
            onTap: (int index){
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.business_sharp),
                label: "Business",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_baseball),
                label: "Sports",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science_outlined),
                  label: "Science",
              ),

            ],
          ),


        );
      },
    );
  }
}
