import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class UploadPhotoColumn extends StatelessWidget {
  final VoidCallback? onTap;

  const UploadPhotoColumn({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //  mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Upload Aadhar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        SizedBox(
          height: 1.h,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              "Choose file",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
