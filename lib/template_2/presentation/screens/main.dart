import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/screens/comparison/comparison.dart';
import 'package:resort_store/presentation/screens/favourite/favourite.dart';
import 'package:resort_store/template_2/presentation/screens/settings/settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/main_template/main_template_cubit.dart';
import '../../../core/constants/strings_app.dart';
import 'Favourite/favourite.dart';
import 'cart/cart.dart';
import 'compare/widgets/compare.dart';
import 'home/home.dart';


class MainNewTemplate extends StatefulWidget {
  const MainNewTemplate({super.key});

  @override
  State<MainNewTemplate> createState() => _MainNewTemplateState();
}

class _MainNewTemplateState extends State<MainNewTemplate> {
  Item _selectedItem = items[2];
  late final double _itemWidth;

  @override
  void didChangeDependencies() {
    _itemWidth = MediaQuery.of(context).size.width / 5.w;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:_selectedItem.screen,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 45.h,
              child: Container(
                color: AppColor.spareTKTemplate,
              ),
            ),
            ...items
                .map(
                  (item) => Positioned(
                    left: _getxAxis(item.xAxis),
                    top: 10,
                    bottom: 0,
                    child: IconButton(
                      onPressed:  () {
                        //  print("----------------- 1");
                        // context.read<MainTemplateCubit>().changeBottomNavigator(item);
                        //  print("----------------- 2");
                        print("/*****//*/*");
                        print(_selectedItem.title);
                        setState(() {
                          _selectedItem = item;
                        });
                      },
                      icon:_selectedItem == item
                          ?  const SizedBox.shrink()
                          : SvgPicture.asset(
                              item.icon,
                              width: 24,
                              color: Colors.white,
                            ),
                    ),
                  ),
                )
                .toList(),
            AnimatedPositioned(
              left: _getxAxis(_selectedItem.xAxis),
              duration: const Duration(milliseconds: 200),
              child: FloatingActionButton(
                onPressed: () {
                  print("-------------------------------||");
                },
                backgroundColor: AppColor.spareTKTemplate,
                child: SvgPicture.asset(
                  _selectedItem.icon,
                  width: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getxAxis(double value) => (value * _itemWidth) + ((_itemWidth / 2) - 3);
}

class Item {

  final String title;
  late final int index;
  final String icon;
  final Widget screen;
  final double xAxis;

  Item({
    required this.title,
    required this.index,
    required this.icon,
    required this.screen,
    required this.xAxis,
  });
}

final items = [
  Item(
    title: AppStrings.myPag.tr(),
    index: 0,
    icon: 'assets/icons/Group 2205.svg',
    screen: CartTemplateScreen(),
    xAxis: 0,
  ),
  Item(
    index: 1,
    title:  AppStrings.favourite.tr(),
    icon: 'assets/icons/Mask Group -2.svg',
    screen: FavouriteTemplateScreen(),
    xAxis: 1,
  ),
  Item(
    index: 2,
    title:  AppStrings.home.tr(),
    icon: 'assets/icons/Group -1.svg',
    screen: HomeTemplateScreen(),
    xAxis: 2,
  ),
  Item(
    index: 3,
    title: AppStrings.comparison.tr(),
    icon: 'assets/icons/Mask Group 6.svg',
    screen: CompareTemplateScreen(),
    xAxis: 3,
  ),
  Item(
    index: 4,
    title: AppStrings.setting.tr(),
    icon: 'assets/icons/menu-svgrepo-com.svg',
    screen: SettingTemplateScreen(),
    xAxis: 4,
  ),
];
