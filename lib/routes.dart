import 'package:firebaseauth/screens/loginScreen.dart';
import 'package:firebaseauth/screens/registerScreen.dart';
import 'package:get/get.dart';
import 'screens/quizScreen.dart';
import 'screens/resultScreen.dart';

class Approutes {
  static const String QUIZSCREEN = '/';
  static const String RESULTSCREEN = '/result';
  static const String LOGINSCREEN = '/login';
  static const String REGISTERSCREEN = '/register';

  static final routes = [
    GetPage(name: QUIZSCREEN, page: () =>  quizScreen()),
    GetPage(name: RESULTSCREEN, page: () =>  resultScreen()),
    GetPage(name: LOGINSCREEN, page: () =>  loginScreen()),
    GetPage(name: REGISTERSCREEN, page: () =>  registerScreen()),
  ];
}
