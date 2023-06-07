import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../template_2/presentation/screens/Favourite/favourite.dart';
import '../../template_2/presentation/screens/cart/cart.dart';
import '../../template_2/presentation/screens/compare/widgets/compare.dart';
import '../../template_2/presentation/screens/home/home.dart';
import '../../template_2/presentation/screens/main.dart';
import '../../template_2/presentation/screens/settings/settings.dart';


part 'main_template_state.dart';

class MainTemplateCubit extends Cubit<MainTemplateState> {
  MainTemplateCubit() : super(MainTemplateInitial());

  static MainTemplateCubit get(context) => BlocProvider.of(context);

  int selectIndex = 2;

  List<Widget> screens = [
    CartTemplateScreen(),
    FavouriteTemplateScreen(),
    HomeTemplateScreen(),
    CompareTemplateScreen(),
    SettingTemplateScreen(),
  ];


  Item selectedItem = items[2];

  void changeBottomNavigator(Item item){
    selectedItem = item;
    emit(ChangeNavigatorBottom());
  }




}
