import 'package:resort_store/business_logic/banner/cubit.dart';
import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/categories/cubit.dart';
import 'package:resort_store/business_logic/counter/cubit.dart';
import 'package:resort_store/business_logic/getCalculation/calculation_cubit.dart';
import 'package:resort_store/business_logic/information/cubit.dart';
import 'package:resort_store/business_logic/languages/cubit.dart';
import 'package:resort_store/business_logic/login/cubit.dart';
import 'package:resort_store/business_logic/logout/cubit.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/business_logic/main_template/main_template_cubit.dart';
import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/register/cubit.dart';
import 'package:resort_store/business_logic/return_order/cubit.dart';
import 'package:resort_store/business_logic/session/cubit.dart';
import 'package:resort_store/business_logic/shipping_address/cubit.dart';
import 'package:resort_store/business_logic/wishlist/cubit.dart';
import 'package:resort_store/data/model/information/information.dart';
import 'package:resort_store/data/repository/banners/banners.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:resort_store/data/repository/categories/categories.dart';
import 'package:resort_store/data/repository/getCalculations/getCalculations.dart';
import 'package:resort_store/data/repository/languages/languages.dart';
import 'package:resort_store/data/repository/logout/logout.dart';
import 'package:resort_store/data/repository/order/order.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:resort_store/data/repository/return_order/return_order.dart';
import 'package:resort_store/data/repository/session/session.dart';
import 'package:resort_store/data/repository/shipping_address/shipping_address.dart';
import 'package:resort_store/data/repository/wishlist/wishlist.dart';
import 'package:resort_store/presentation/screens/categories/sub_categories_screen.dart';
import 'package:resort_store/presentation/screens/favourite/favourite.dart';
import 'package:resort_store/presentation/screens/main/main.dart';
import 'package:resort_store/presentation/screens/myOrder/myOrder.dart';
import 'package:resort_store/presentation/screens/myOrder/order_Details_screen.dart';
import 'package:resort_store/presentation/screens/myOrder/reason_return_order_screen.dart';
import 'package:resort_store/presentation/screens/my_pag/my_pag.dart';
import 'package:resort_store/presentation/screens/product_details/product_details.dart';
import 'package:resort_store/presentation/screens/return_order/return_order.dart';
import 'package:resort_store/template_2/presentation/screens/main.dart';
import 'package:resort_store/template_2/presentation/screens/screen_template_details.dart';
import 'package:resort_store/template_2/presentation/screens/home/home.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/product/cubit.dart';
import '../../core/constants/route_constant.dart';
import '../../data/model/category/category.dart';
import '../../data/repository/information/information.dart';
import '../../di/di.dart';
import '../../template_2/presentation/screens/Favourite/favourite.dart';
import '../../template_2/presentation/screens/cart/cart.dart';
import '../../template_2/presentation/screens/compare/widgets/compare.dart';
import '../../template_2/presentation/screens/settings/settings.dart';
import '../screens/categories/show_all_sub_category.dart';
import '../screens/categories/show_product_by_categoryId_screen.dart';
import '../screens/information/information_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/products/product.dart';
import '../screens/register/register_screen.dart';
import '../screens/return_order/return_order_details.dart';
import '../screens/splash/splash.dart';

class RouteManger {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      //TODO: splash screen
      case RouteConstants.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      //TODO: login screen
      case RouteConstants.login:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (context) => LoginCubit(loginRepo: instance())),
                  BlocProvider(
                      create: (context) => SessionCubit(
                          sessionRepository: instance<SessionRepository>())),
                ], child: const LoginScreen()));

      //TODO: register Screen
      case RouteConstants.register:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (context) =>
                          RegisterCubit(registerRepository: instance())),
                  BlocProvider(
                      create: (context) => LoginCubit(loginRepo: instance())),
                  BlocProvider(
                      create: (context) => SessionCubit(
                          sessionRepository: instance<SessionRepository>())),
                ], child: const RegisterScreen()));

      //TODO: main Screen
      case RouteConstants.main:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (context) => LanguagesCubit(
                          languagesRepository: instance<LanguagesRepository>())
                        ..getAllLanguagesCubit()),
                  BlocProvider(
                      create: (context) =>
                          CartCubit(cartRepository: instance<CartRepository>())
                            ..getCartCubit()),
                  BlocProvider(
                      create: (context) => LogOutCubit(
                          logoutRepository: instance<LogoutRepository>())),
                  BlocProvider(
                      create: (context) => ShippingAddressCubit(
                          shippingAddressRepository:
                              instance<ShippingAddressRepository>())
                        ..getAllAddressCubit()),
                  BlocProvider(
                      create: (context) => OrderCubit(
                          confirmOrderRepository:
                              instance<ConfirmOrderRepository>())),
                ], child: MainScreen()));

      //TODO: myPag Screen
      case RouteConstants.myPag:
        return MaterialPageRoute(builder: (context) => MyPagScreen());

      //TODO: Product Details
      case RouteConstants.productDetails:
        int? id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => ProductCubit(
                            productRepository: instance<ProductRepository>())
                          ..getProductDetailsCubit(id.toString())),
                  ],
                  child: ProductDetails(
                    id: id,
                  ),
                ));

      //TODO: Return Order
      case RouteConstants.returnOrder:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => ReturnOrderCubit(
                    returnOrderRepository: instance<ReturnOrderRepository>())
                  ..getReturnOrderCubit(),
                child: const ReturnOrder()));

      //TODO: My Order
      case RouteConstants.myOrder:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => OrderCubit(
                    confirmOrderRepository: instance<ConfirmOrderRepository>())
                  ..getOrdersCubit(),
                child: const MyOrderScreen()));
      //TODO:  Order Details
      case RouteConstants.orderDetails:
        String? id = settings.arguments as String;
        print("*******************- $id");
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => OrderCubit(
                    confirmOrderRepository: instance<ConfirmOrderRepository>())
                  ..getOrderDetailsCubit(id),
                child: OrderDetailsScreen()));

      //TODO: Sub Category
      case RouteConstants.subCategory:
        SubCategoryScreen subCategoryScreen =
            settings.arguments as SubCategoryScreen;
        print("*********-id ${subCategoryScreen.id}");

        print("*********-name ${subCategoryScreen.name}");
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CategoriesCubit(
                      categoriesRepository: instance<CategoriesRepository>())
                    ..getSubCategories(subCategoryScreen.id.toString()),
                  child: SubCategoryScreen(
                    id: subCategoryScreen.id.toString(),
                    name: subCategoryScreen.name.toString(),
                  ),
                ));

      //TODO: All Category
      case RouteConstants.allCategory:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CategoriesCubit(
                      categoriesRepository: instance<CategoriesRepository>())
                    ..getAllCategories(),
                  child: ShowAllSubCategories(),
                ));

      //TODO: ProductScreen
      case RouteConstants.productScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProductCubit(
                      productRepository: instance<ProductRepository>())
                    ..getAllProductCubit(),
                  child: const ProductScreen(),
                ));

      //TODO: ProductScreen
      case RouteConstants.informationScreen:
        InformationDataModel? informationDataModel =
            settings.arguments as InformationDataModel;
        print("/// #${informationDataModel.description}");
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InformationCubit(
                      informationRepository: instance<InformationRepository>())
                    ..getOneInformationCubit(
                        informationDataModel.id.toString()),
                  child: InformationScreen(
                    informationDataModel: informationDataModel,
                  ),
                ));

      //TODO: show product by categoryId Screen
      case RouteConstants.showProductByCategoryId:
        final Map data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProductCubit(
                      productRepository: instance<ProductRepository>())
                    ..getProductByCategoryIdCubit(data["id"]),
                  child: ShowProductByCategoryId(
                      id: data["id"], name: data["name"]),
                ));

      //TODO : Reason Return Order Screen
      case RouteConstants.reasonReturnOrder:
        Map data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => OrderCubit(
                    confirmOrderRepository: instance<ConfirmOrderRepository>()),
                child: ReasonReturnOrderScreen(
                  data: data,
                )));

      //TODO :  Return Order Details Screen
      case RouteConstants.returnOrderDetails:
        String? returnId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => ReturnOrderCubit(
                    returnOrderRepository: instance<ReturnOrderRepository>())
                  ..getReturnOrderDetailsCubit(returnId),
                child: const ReturnOrderDetailsScreen()));

      //TODO : ***********************************************************************************

      //TODO :  Home Template 2
      case RouteConstants.homeTemplateScreen:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (context) => LanguagesCubit(
                          languagesRepository: instance<LanguagesRepository>())
                        ..getAllLanguagesCubit()),
                  BlocProvider(
                      create: (context) =>
                          CartCubit(cartRepository: instance<CartRepository>())
                            ..getCartCubit()),
                  BlocProvider(
                      create: (context) => LogOutCubit(
                          logoutRepository: instance<LogoutRepository>())),
                  BlocProvider(
                      create: (context) => ShippingAddressCubit(
                          shippingAddressRepository:
                              instance<ShippingAddressRepository>())
                        ..getAllAddressCubit()),
                  BlocProvider(
                      create: (context) => OrderCubit(
                          confirmOrderRepository:
                              instance<ConfirmOrderRepository>())),
                ], child: const HomeTemplateScreen()));

      //TODO: Details Template Screen
      case RouteConstants.detailsTemplateScreen:
        int? id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => ProductCubit(
                            productRepository: instance<ProductRepository>())
                          ..getProductDetailsCubit(id.toString())),
                  ],
                  child: DetailsTemplateScreen(
                    id: id,
                  ),
                ));

      //TODO : Main Template Screen
      case RouteConstants.mainNewTemplate:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (context) => LogOutCubit(
                          logoutRepository: instance<LogoutRepository>())),
              BlocProvider(
                  create: (context) => MainTemplateCubit()),
                ], child: MainNewTemplate()));

      //TODO : Cart Template Screen
      case RouteConstants.cartTemplateScreen:
        return MaterialPageRoute(builder: (context) => CartTemplateScreen());

      //TODO : Favourite Template Screen
      case RouteConstants.favouriteTemplateScreen:
        return MaterialPageRoute(
            builder: (context) => FavouriteTemplateScreen());

      //TODO : Settings Template Screen
      case RouteConstants.settingsTemplateScreen:
        return MaterialPageRoute(builder: (context) => SettingTemplateScreen());

      //TODO : Compare Template Screen
      case RouteConstants.compareTemplateScreen:
        return MaterialPageRoute(builder: (context) => CompareTemplateScreen());
    }
  }
}
