import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/controller/caht_controller.dart';
import 'package:info_fina/widget/receiver_bubble_widget.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController chatCntrlr = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  bool showWelcomeMessage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showWelcomeMessage = false; // Hide welcome message after animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: TextField(
          controller: chatCntrlr,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            hintText: 'Type here...',
            suffixIcon: IconButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (chatCntrlr.text.isNotEmpty) {
                  await chatController
                      .sendMessage(message: chatCntrlr.text)
                      .then(
                    (value) {
                      chatCntrlr.clear(); // Clear input field after sending
                      setState(() {
                        chatController.chatList.value =
                            chatController.chatList.value;
                      });
                    },
                  );
                }
              },
              icon: Icon(
                Icons.send,
                size: 22.sp,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13.sp),
              child: Image.asset(
                'asset/ilogo2.jpg',
                height: 4.h,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              'Fina Ai',
              style: TextStyle(color: Colors.white, fontSize: 17.sp),
            ),
          ],
        ),
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.only(bottom: 10.h),
          itemCount: chatController.chatList.value.length,
          itemBuilder: (context, index) {
            // ignore: invalid_use_of_protected_member
            final message = chatController.chatList.value[index];
            final lastElement =
                // ignore: invalid_use_of_protected_member
                index == chatController.chatList.value.length - 1;
            // logger.e('index $lastElement');
            return ReceiverBubbleWidget(
              isSender: message["user"] == "ai" ? false : true,
              txtMsg: message["chat"],
              isLastMsg: lastElement,
            );
          },
        ),
      ),
    );
  }
}
