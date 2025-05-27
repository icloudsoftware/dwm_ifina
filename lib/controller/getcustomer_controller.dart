import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:info_fina/model/get_customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetCuestomerController extends GetxController {
  RxList<getcus> customerData = <getcus>[].obs;

  var isLoading = false.obs;

  Future<void> getCustomerData() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
 var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    isLoading.value = true;
    Map<String, dynamic> data = {
      "user": "getcustomer",
      "mfin": mfin,
      "scode": scode
    };

    logger.w('Request Data >> $data');

    Map<String, dynamic> response =
        await ApiServices.post(slug: ApiConstant.GETCUSTOMER, body: data);

    if (response['success']) {
      customerData.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => getcus.fromJson(json))
          .toList();

      logger.w('Customer Data: $response');
    } else {
      logger.e('API Error: ${response['message']}');
    }
    isLoading.value = false;
  }
}
