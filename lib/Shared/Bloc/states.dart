abstract class NewsStates{}

class NewsInitialState extends NewsStates{}
class NewsBottomNavState extends NewsStates{}

class NewsSelectBusinessItemState extends NewsStates{}
class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{}

class NewsGetSportsLoadingState extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates{}

class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates{}

class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{}

class NewsSetModeState extends NewsStates{}
class NewsChangeModeState extends NewsStates{}
