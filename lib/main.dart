import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/data/providers/category_provider.dart';
import 'package:pg_photo_track/data/providers/login_provider.dart';
import 'package:pg_photo_track/data/providers/user_provider.dart';
import 'package:pg_photo_track/data/providers/visit_detail_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/route_manager.dart';
import 'presentation/theme_manager.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserDetailProvider()),
      ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => VisitDetailProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      builder: EasyLoading.init(),
    );
  }
}
