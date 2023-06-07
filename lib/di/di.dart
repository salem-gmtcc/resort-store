import 'package:resort_store/business_logic/contact/cubit.dart';
import 'package:resort_store/business_logic/country/cubit.dart';
import 'package:resort_store/business_logic/coupon/coupon_cubit.dart';
import 'package:resort_store/business_logic/currencies/currencies_cubit.dart';
import 'package:resort_store/business_logic/getCalculation/calculation_cubit.dart';
import 'package:resort_store/business_logic/payment_address/cubit.dart';
import 'package:resort_store/business_logic/return_order/cubit.dart';
import 'package:resort_store/business_logic/session/cubit.dart';
import 'package:resort_store/business_logic/shipping_address/cubit.dart';
import 'package:resort_store/business_logic/wishlist/cubit.dart';
import 'package:resort_store/core/constants/header.dart';
import 'package:resort_store/data/model/payment_methods/payment_methods.dart';
import 'package:resort_store/data/repository/banners/banners.dart';
import 'package:resort_store/data/repository/categories/categories.dart';
import 'package:resort_store/data/repository/country/country.dart';
import 'package:resort_store/data/repository/currencies/currencies.dart';
import 'package:resort_store/data/repository/getCalculations/getCalculations.dart';
import 'package:resort_store/data/repository/getLocationDetails.dart';
import 'package:resort_store/data/repository/information/information.dart';
import 'package:resort_store/data/repository/languages/languages.dart';
import 'package:resort_store/data/repository/order/order.dart';
import 'package:resort_store/data/repository/payment_address/payment_address.dart';
import 'package:resort_store/data/repository/payment_method/payment_method.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:resort_store/data/repository/register/register.dart';
import 'package:resort_store/data/repository/session/session.dart';
import 'package:resort_store/data/repository/shipping_address/shipping_address.dart';
import 'package:resort_store/data/repository/wishlist/wishlist.dart';
import 'package:resort_store/data/services/banner/banner.dart';
import 'package:resort_store/data/services/cart/cart.dart';
import 'package:resort_store/data/services/categories/categories.dart';
import 'package:resort_store/data/services/contacts/contacts.dart';
import 'package:resort_store/data/services/country/country.dart';
import 'package:resort_store/data/services/currencies/currencies.dart';
import 'package:resort_store/data/services/edit_profile/edit_profile.dart';
import 'package:resort_store/data/services/getCalculations/getCalculations.dart';
import 'package:resort_store/data/services/getLocationDetails/getLocationDetails.dart';
import 'package:resort_store/data/services/information/information.dart';
import 'package:resort_store/data/services/languages/languages.dart';
import 'package:resort_store/data/services/login/login.dart';
import 'package:resort_store/data/services/order/order.dart';
import 'package:resort_store/data/services/payment_address/payment_address.dart';
import 'package:resort_store/data/services/product/product.dart';
import 'package:resort_store/data/services/register/register.dart';
import 'package:resort_store/data/services/return_order/return_order.dart';
import 'package:resort_store/data/services/session/session.dart';
import 'package:resort_store/data/services/shipping_address/shipping_address.dart';
import 'package:get_it/get_it.dart';

import '../business_logic/edit_profile/cubit.dart';
import '../business_logic/getLocationDetails/get_location_details_cubit.dart';
import '../business_logic/payment_method/cubit.dart';
import '../data/network/api_client.dart';
import '../data/repository/cart/cart.dart';
import '../data/repository/edit_profile/edit_profile.dart';
import '../data/repository/login/login.dart';
import '../data/repository/logout/logout.dart';
import '../data/repository/return_order/return_order.dart';
import '../data/services/logout/logout.dart';
import '../data/services/payment_method/payment_method.dart';
import '../data/services/wishlist/wishlist.dart';

final instance = GetIt.I;

class Injection {
  const Injection._();

  static init() {
    instance.allowReassignment = true;
    //TODO: api client
    instance.registerLazySingleton(() => ApiClient());
    //TODO : Header Apis
    instance.registerLazySingleton(() => HeaderApis());
    //TODO: login
    instance.registerLazySingleton(() => LoginRepo(loginServices: instance()));
    instance.registerLazySingleton(() => LoginServices(instance()));
    //TODO: Register
    instance.registerLazySingleton(
        () => RegisterRepository(registerService: instance()));
    instance.registerLazySingleton(() => RegisterService(instance()));
    //TODO: Session
    instance.registerLazySingleton(
        () => SessionCubit(sessionRepository: instance<SessionRepository>()));
    instance.registerLazySingleton(
        () => SessionRepository(sessionService: instance<SessionService>()));
    instance.registerLazySingleton(() => SessionService(instance()));
    //TODO: LogOut
    instance.registerLazySingleton(
        () => LogoutRepository(logOutService: instance()));
    instance.registerLazySingleton(() => LogOutService(instance()));
    //TODO: Banner
    instance.registerLazySingleton(
        () => BannerRepository(bannerService: instance()));
    instance.registerLazySingleton(() => BannerService(instance()));
    //TODO: Categories
    instance.registerLazySingleton(
        () => CategoriesRepository(categoriesService: instance()));
    instance.registerLazySingleton(() => CategoriesService(instance()));
    //TODO: Product
    instance.registerLazySingleton(
        () => ProductRepository(productService: instance()));
    instance.registerLazySingleton(() => ProductService(instance()));
    //TODO: Cart
    instance
        .registerLazySingleton(() => CartRepository(cartService: instance()));
    instance.registerLazySingleton(() => CartService(instance()));
    instance.registerLazySingleton(() => CouponCubit(cartRepository:instance<CartRepository>()));

    //TODO: Order *****
    instance.registerLazySingleton(
        () => ConfirmOrderRepository(confirmOrderService: instance()));
    instance.registerLazySingleton(() => ConfirmOrderService(instance()));

    //TODO : Currencies

    instance.registerLazySingleton(() => CurrenciesRepo(currenciesService: instance<CurrenciesService>()));
    instance.registerLazySingleton(() => CurrenciesService(instance()));
    instance.registerLazySingleton(() => CurrenciesCubit(currenciesRepo: instance<CurrenciesRepo>()));


    //TODO: Information Screen *****
    instance.registerLazySingleton(
        () => InformationRepository(informationService: instance()));
    instance.registerLazySingleton(() => InformationService(instance()));
    //TODO: Languages ****
    instance.registerLazySingleton(
        () => LanguagesRepository(languagesService: instance()));
    instance.registerLazySingleton(() => LanguagesService(instance()));
    //TODO: Languages ****
    instance.registerLazySingleton(() => ContactCubit(instance()));
    instance.registerLazySingleton(() => ContactService(instance()));
    //TODO: Shipping Address ****
    instance.registerLazySingleton(() => ShippingAddressCubit(
        shippingAddressRepository: instance<ShippingAddressRepository>()));
    instance.registerLazySingleton(() => ShippingAddressService(instance()));
    instance.registerLazySingleton(() => ShippingAddressRepository(
        shippingAddressService: instance<ShippingAddressService>()));
    //TODO:Favourite Screen ****
    instance.registerLazySingleton(() =>
        WishListCubit(wishListRepository: instance<WishListRepository>()));
    instance.registerLazySingleton(() => WishListService(instance()));
    instance.registerLazySingleton(
        () => WishListRepository(wishListService: instance<WishListService>()));

    //TODO:Edit Profile ****
    instance.registerLazySingleton(() => EditProfileCubit(
        editProfileRepository: instance<EditProfileRepository>()));
    instance.registerLazySingleton(() => EditProfileService(instance()));
    instance.registerLazySingleton(() => EditProfileRepository(
        editProfileService: instance<EditProfileService>()));

    //TODO:Payment Address ****
    instance.registerLazySingleton(
        () => PaymentAddressRepository(paymentAddressService: instance()));
    instance.registerLazySingleton(() => PaymentAddressService(instance()));
    instance.registerLazySingleton(() => PaymentAddressCubit(
        paymentAddressRepository: instance<PaymentAddressRepository>()));

    //TODO: Get Country ****
    instance.registerLazySingleton(
        () => CountryCubit(countryRepository: instance<CountryRepository>()));
    instance.registerLazySingleton(() => CountryService(instance()));
    instance.registerLazySingleton(
        () => CountryRepository(countryService: instance<CountryService>()));

    //TODO: Return Order
    instance.registerLazySingleton(() => ReturnOrderCubit(
        returnOrderRepository: instance<ReturnOrderRepository>()));
    instance.registerLazySingleton(() => ReturnOrderService(instance()));
    instance.registerLazySingleton(() => ReturnOrderRepository(
        returnOrderService: instance<ReturnOrderService>()));

    //TODO: Payment Methods
    instance.registerLazySingleton(() => PaymentMethodsCubit(
        paymentMethodRepository: instance<PaymentMethodRepository>()));
    instance.registerLazySingleton(() => PaymentMethodsService(instance()));
    instance.registerLazySingleton(
        () => PaymentMethodRepository(instance<PaymentMethodsService>()));


    //TODO: getLocation Data --------- on the map
    instance.registerLazySingleton(() => GetLocationDetailsCubit(
        getLocationDetailsRepo: instance<GetLocationDetailsRepo>()));

    instance.registerLazySingleton(() => GetLocationDetailsService());
    instance.registerLazySingleton(() => GetLocationDetailsRepo(
        getLocationDetailsService: instance<GetLocationDetailsService>()));

    //TODO : get Calculation Data

    instance.registerLazySingleton(
        () => GetCalculationRepo(instance<GetCalculationServices>()));

    instance.registerLazySingleton(() => GetCalculationServices(instance()));
    instance.registerLazySingleton(() =>
        CalculationCubit(getCalculationRepo: instance<GetCalculationRepo>()));
  }
}
