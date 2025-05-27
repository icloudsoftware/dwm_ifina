import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class ReceiverBubbleWidget extends StatefulWidget {
  final bool isSender;
  final String? txtMsg;
  final bool isLastMsg;
  final bool isFirstTime; // New flag for first-time chat

  const ReceiverBubbleWidget({
    required this.isSender,
    required this.txtMsg,
    required this.isLastMsg,
    this.isFirstTime = false, // Default is false
    super.key,
  });

  @override
  State<ReceiverBubbleWidget> createState() => _ReceiverBubbleWidgetState();
}

class _ReceiverBubbleWidgetState extends State<ReceiverBubbleWidget> {
  bool showWelcomeMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.isFirstTime) {
      showWelcomeMessage = true;
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          showWelcomeMessage = false; // Hide welcome message after animation
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment:
            widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!widget.isSender)
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(23.sp),
            //   child: Image.asset(
            //     'assets/images/ilogo2.jpg',
            //     height: 4.h,
            //   ),
            // ),
          if (!widget.isSender) SizedBox(width: 2.w),

          // Message Container
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: widget.isSender
                  ? Colors.white
                  : Colors.indigo.shade900,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: _buildMessageContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    if (showWelcomeMessage) {
      // Show Animated Welcome Message
      return SizedBox(
        width: 40.w,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TyperAnimatedText(
              "👋 Welcome! I'm Fina AI How can I assist you today?",
              textStyle: TextStyle(color:Colors.white),
              speed: const Duration(milliseconds: 50),
            ),
          ],
        ),
      );
    } else if (widget.isSender) {
      // Normal sent message
      return Text(
        widget.txtMsg ?? "Hello",
        style: TextStyle(fontSize: 10.sp, color: Colors.black),
      );
    } else if (widget.isLastMsg) {
      // Normal received message with animation
      return SizedBox(
        width: 40.w,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TyperAnimatedText(
              widget.txtMsg ?? 'Result',
              textStyle: TextStyle(color: Colors.white),
              speed: Duration(milliseconds: 50),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: 40.w,
        child: Text(
          widget.txtMsg ?? "Hello",
          style: TextStyle(fontSize: 10.sp, color: Colors.white),
        ),
      );
    }
  }
}
