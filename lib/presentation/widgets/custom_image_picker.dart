
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/helpers/app_router.dart';
import '../resources/color_manger.dart';
import 'dialog/custom_alert_dailog.dart';

class CustomImagePicker extends StatefulWidget {
  Function(ImageSource source) pickFile;
  double? height,width,iconSize;
  CustomImagePicker({required this.pickFile,this.width,this.height,this.iconSize});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 5.0,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => chooseSelectedImage(widget.pickFile));
              },
              child: Container(
                height:widget.height ?? 80.h,
                width:widget.width ?? 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.image,
                  size:widget.iconSize ?? 80.sp,
                ),
              ),
            )),
      ],
    );
  }

  Widget chooseSelectedImage(Function(ImageSource source) onclick) {
    return CustomAlertDialog(
      image: "camera-svgrepo-com.svg",
      title: "Choose Select Image",
      widget: Container(
        height: 120.h,
        width: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: AppColor.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  onclick(ImageSource.camera);
                  AppRouter.back(context);
                },
                child: textChooseImage(
                  "Camera",
                  Icons.linked_camera,
                )),
            InkWell(
                onTap: () {
                  onclick(ImageSource.gallery);
                  AppRouter.back(context);
                },
                child: textChooseImage(
                  "Gallery",
                  Icons.camera_alt_outlined,
                )),
          ],
        ),
      ),
    );
  }

  Widget textChooseImage(String title, IconData icon) {
    return Container(
      height: 40.h,
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColor.primaryAmwaj,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: AppColor.black,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(title),
        ],
      ),
    );
  }
}
