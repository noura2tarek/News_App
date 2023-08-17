import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/Local/cache_helper.dart';
import 'package:news_app/Network/Remote/dio_helper.dart';
import 'package:news_app/Pages/business_screen.dart';
import 'package:news_app/Pages/science_screen.dart';
import 'package:news_app/Pages/sports_screen.dart';
import 'package:news_app/Shared/Bloc/states.dart';
class NewsCubit extends Cubit<NewsStates>{
NewsCubit() : super(NewsInitialState());

int currentIndex = 0;

List<Widget> screens = [
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
];
List<dynamic> business =[];
List<dynamic> science =[];
List<dynamic> sports =[];
List<dynamic> search =[];

bool isDark = false;
static NewsCubit get(context){
  return BlocProvider.of(context);
}

void changeIndex(int index){
  currentIndex = index;
  emit(NewsBottomNavState());
}
//method to get business data from api by using dio
void getBusinessData (){

  emit(NewsGetBusinessLoadingState());
  DioHelper.getHttp(
      url: 'v2/top-headlines',
      query: {
        "country" : "eg",
        "category" : 'business' ,
        "apiKey" : '65f7f556ec76449fa7dc7c0069f040ca',
      }
  ).then((value) {
    business = value.data["articles"];
    print(business[0]);
    emit(NewsGetBusinessSuccessState());
  }).catchError(
          (error){
        print(error.toString());
        emit(NewsGetBusinessErrorState());
      }
  );
}
//method to get Science data from api
void getScienceData (){
  emit(NewsGetScienceLoadingState());
  DioHelper.getHttp(
      url: 'v2/top-headlines',
      query: {
        "country" : 'eg' ,
        "category" : 'science' ,
        "apiKey" : '65f7f556ec76449fa7dc7c0069f040ca',
      }
  ).then((value) {
    science = value.data["articles"];
   // print(science[0]);
    emit(NewsGetScienceSuccessState());
  }).catchError(
          (error){
        print(error.toString());
        emit(NewsGetScienceErrorState());
      }
  );
}
//method to get Sports data from api
void getSportsData (){
  emit(NewsGetSportsLoadingState());
  DioHelper.getHttp(
      url: 'v2/top-headlines',
      query: {
        "country" : 'eg' ,
        "category" : 'sports' ,
        "apiKey" : '65f7f556ec76449fa7dc7c0069f040ca',
      }
  ).then((value) {
    sports = value.data["articles"];
    //print(sports[0]);
    emit(NewsGetSportsSuccessState());
  }).catchError(
          (error){
        print(error.toString());
        emit(NewsGetSportsErrorState());
      }
  );
}
//method to get Search data from api
void getSearchData ({required String value}){
  emit(NewsGetSearchLoadingState());
  DioHelper.getHttp(
      url: 'v2/everything',
      query: {
        'q' : value, // the value which the api search for
        "apiKey" : '65f7f556ec76449fa7dc7c0069f040ca',
      }
  ).then((value) {
    search = value.data["articles"];
    emit(NewsGetSearchSuccessState());
  }).catchError(
          (error){
        print(error.toString());
        emit(NewsGetSearchErrorState());
      }
  );
}
//method to get shared pref data to see the latest mode from api
void setMode({ required bool? fromShared}) {
  if (fromShared != null) {
    isDark = fromShared;
    emit(NewsSetModeState());
  }
  else {
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsSetModeState());
    });
  }
}

void changeMode ({required BuildContext context}) {
    isDark = !isDark;
     CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeState());
    });

}


}