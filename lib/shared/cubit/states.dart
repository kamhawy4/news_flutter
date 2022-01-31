abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewsChangeSectionState extends NewsState {}

class NewsChangeLangState extends NewsState {}


// State Category
class NewsGetCategoryLoadingState extends NewsState {}
class NewsGetCategorySuccessState extends NewsState {}
class NewsGetCategoryErrorState extends NewsState {}

// State artical
class NewsGetArticlesLoadingState extends NewsState {}
class NewsGetArticlesSuccessState extends NewsState {}
class NewsGetArticlesErrorState extends NewsState {}


//  Change theme app
class AppChangeModeState extends NewsState {}


class NewsGetSearchLoadingState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchErrorState extends NewsState {}
