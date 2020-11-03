import 'package:expenses/constants.dart';
import 'package:flutter/material.dart';
import 'package:expenses/screens/screens.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: pinkColor,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
        primarySwatch: MaterialColor(0xFFFF3378, {
          50: pinkColor,
          100: pinkColor,
          200: pinkColor,
          300: pinkColor,
          400: pinkColor,
          500: pinkColor,
          600: pinkColor,
          700: pinkColor,
          800: pinkColor,
          900: pinkColor,
        }),
        primaryColor: Color(0xFFFDFDFD),
        accentColor: pinkColor,
        cursorColor: pinkColor,
        // fontFamily: 'GT-Walsheim-Pro',
        textTheme: TextTheme(
          bodyText2: TextStyle(fontWeight: FontWeight.w600),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomeScreen(),
    );
  }
}
