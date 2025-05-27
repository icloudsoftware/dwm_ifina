import 'package:get/get.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/model/search_model.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchController extends GetxController {
  RxList<searchModel> someList = <searchModel>[].obs;

  var isLoading = false.obs;

  Future<void> searchLoans(
      {String? phone,
      String? name,
      String? loanno,
      String? area,
      String? line}) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scode = await prefs.getString('Scode');
    var mfin = await prefs.getString('Mfin');
    Map<String, dynamic> data = {
      "user": "yes",
      "hpl": loanno,
      "pno": phone,
      "area": area,
      "name": name,
      "line": line,
      "scode": scode,
      "mfin": mfin
    };

    logger.w('Request body >> $data');

    Map<String, dynamic> response = await ApiServices.post(
      slug: ApiConstant.SEARCHAPI,
      body: data,
    );

    if (response['success']) {
      someList.value = List<Map<String, dynamic>>.from(response['result'])
          .map((json) => searchModel.fromJson(json))
          .toList();

      logger.w('Response >> $response');
    } else {
      logger.e('API Error >> $response');
    }
  }
}
