import 'package:resort_store/business_logic/country/cubit.dart';
import 'package:resort_store/business_logic/country/state.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/data/model/country/country.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/repository/country/country.dart';
import '../../../di/di.dart';

class CustomSearchAlertDialog extends StatefulWidget {
  TextEditingController? country;

  CustomSearchAlertDialog({required this.country});

  @override
  State<CustomSearchAlertDialog> createState() =>
      _CustomSearchAlertDialogState();
}

class _CustomSearchAlertDialogState extends State<CustomSearchAlertDialog> {
  List<CountryDataModel> list = [];

  List<CountryDataModel> resultSearch = [];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountryCubit(countryRepository: instance<CountryRepository>())
            ..getCountryCubit(),
      child: SizedBox(
        width: 250.w,
        child: Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  searchCountries(value);
                  print("--------------------------------------- ${value}");
                },
                controller: widget.country,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: AppColor.primaryAmwaj),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: AppColor.primaryAmwaj),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: AppColor.primaryAmwaj),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: AppColor.primaryAmwaj),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: AppColor.primaryAmwaj),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: AppColor.primaryAmwaj),
                  ),
                ),
              ),

              BlocBuilder<CountryCubit, CountryStates>(
                  builder: (context, state) {
                print("----------state------------ ${state}");
                if (state is SuccessCountryState) {
                  list = state.countryModel.countryDataModel!;
                  print("************************** ----- ${list.length}");
                } else if (state is LoadingCountryState) {
                  Center(
                    child: CircularProgressIndicator(
                        backgroundColor: AppColor.primaryAmwaj),
                  );
                } else if (state is ErrorCountryState) {
                  showToast(
                      text: state.error.toString(), color: ToastColors.ERROR);
                }
                return Scrollbar(
                  thickness: 10.0,
                  showTrackOnHover: true,
                  child: SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                        itemCount: resultSearch.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          print(
                              "------------------------- ${resultSearch[index].name}");
                          return Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  print(
                                      "****************  name ${resultSearch[index].name}");
                                  widget.country!.text = resultSearch[index].name.toString();
                                });
                                AppRouter.back(context);
                              },
                              child: Text(
                                resultSearch[index].name.toString(),
                                style: TextStyle(color: AppColor.primaryAmwaj),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              })
              // Add any other content below the search bar
            ],
          ),
        ),
      ),
    );
  }

  void searchCountries(String query) {
    if (query.isEmpty) {
      resultSearch = list;
      print(
          "------------------------------------------------ list 1 ${resultSearch.length}");
    } else {
      resultSearch = list
          .where(
              (text) => text.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      print(""
          "----------------------------- ||"
          " -----------------------------[]"
          " ${resultSearch.length}");
    }
    print(" *** ${resultSearch.length}");
    setState(() {
      list = resultSearch;
    });
  }
}
