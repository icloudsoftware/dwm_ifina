import 'package:get/get.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/const/global_const.dart';
import 'package:info_fina/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatController extends GetxController {
  RxList<Map<String, String>> chatList = <Map<String, String>>[].obs;
  var isLoading = false.obs;

  Future<void> sendMessage({required String message}) async {
    if (message.isEmpty) return;

    // Add user message
    chatList.add({"user": "user", "chat": message});
    try {
      isLoading.value = true;
       final SharedPreferences prefs = await SharedPreferences.getInstance();
        var code = await prefs.getString('code');
         var mfin = await prefs.getString('Mfin');
      Map<String, dynamic> response = await ApiServices.post(
        slug: ApiConstant.AI,
        body: {"user": "ai", "chat": message,'scode':code,'mfin':mfin},
      );

      if (response.containsKey('success') && response['success'] == true) {
        String botReply = response['message'] ?? "I'm still learning! 😊";


        chatList.add({"user": "ai", "chat": botReply});
        logger.d("AI Response: $botReply");
      }

      chatList.removeWhere(
        (element) => (element['chat']?.contains('Typing') ?? false),
      );
      chatList.forEach(
        (element) {
          logger.w(element);
        },
      );
    } catch (e) {
      isLoading.value = false;

      chatList.add({"user": "ai", "chat": "Error: Unable to fetch response."});
      logger.e("Error sending message: $e");
    }
    isLoading.value = false;
  }
}
