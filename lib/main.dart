import 'package:info_fina/auth/Login.dart';
import 'package:info_fina/home.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/splash.dart';
import 'package:get/route_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:info_fina/services/update_service.dart';
import 'package:info_fina/sucess_screen/success_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures native plugins are registered
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateService.checkForUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          builder: BotToastInit(), // Initialize bot toast
          navigatorObservers: [BotToastNavigatorObserver()], // Attach observer
          home:
              SplashScreen(), // Ensure SplashScreen has const constructor if possible
        );
      },
    );
  }
}
