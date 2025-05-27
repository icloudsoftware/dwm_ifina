import 'package:get/get.dart';
import 'package:info_fina/auth/Login.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';


class OtpController extends GetxController {
  Future<void> verifyOtp({String? mail, String? otp}) async {
    Map<String, dynamic> data = {
      "user": "otpverifed",
      "mail": mail,
      "otp": otp,
    };
    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.OTPVERIFICATION, body: data);
    logger.e(data);
    if (response['success'] == true) {
      logger.w(response);
      Get.to(() => LoginPage());
    } else {
      logger.w(response);
    }
  }
}
