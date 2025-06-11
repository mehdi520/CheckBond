import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_details_data_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/analyze_res_model.dart';
import 'package:check_bond/presentation/screens/acc/change_pass_screen.dart';
import 'package:check_bond/presentation/screens/acc/profile_screen.dart';
import 'package:check_bond/presentation/screens/administration/anaylze_draw_result_screen.dart';
import 'package:check_bond/presentation/screens/administration/upload_draw_result_screen.dart';
import 'package:check_bond/presentation/screens/draw_result/draw_result_screen.dart';
import 'package:check_bond/presentation/screens/landing/landing_screen/landing_screen.dart';
import 'package:check_bond/presentation/screens/pub/login/login_screen.dart';
import 'package:check_bond/presentation/screens/pub/signup/signup_screen.dart';
import 'package:check_bond/presentation/screens/pub/splash/splash_screen.dart';
import 'package:check_bond/presentation/screens/yearly_draw/yearly_draw_list_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotRoute = '/forgot';
  static const String landingRoute = '/landing';

  static const String yearly_drawRoute = '/yearly_draw_screen';
  static const String draw_resultRoute = '/draw_result_screen';

  static const String upload_draw_resultRoute = '/uploaddraw_result_screen';
  static const String analyze_draw_result = '/analyze_draw_result';
  static const String accRoute = '/acc';
  static const String chnagePassRoute = '/chnagePassRoute';


  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case landingRoute:
        return MaterialPageRoute(builder: (context) => LandingScreen());
      case yearly_drawRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'] as BondTypeDataModel;
        return MaterialPageRoute(builder: (context) => YearlyDrawListScreen(data: data));

      case draw_resultRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'] as DrawDataModel;
        return MaterialPageRoute(builder: (context) => DrawResultScreen(data: data));

      case upload_draw_resultRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'] as DrawDataModel;
        return MaterialPageRoute(builder: (context) => UploadDrawResultScreen(data: data));

      case analyze_draw_result:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'] as  DrawDetailsDataModel;
        final result = args['result'] as AnalyzeResModel ;
        return MaterialPageRoute(builder: (context) => AnaylzeDrawResultScreen(data: data, result: result,));

      case accRoute:
        return MaterialPageRoute(builder: (context) => ProfileScreen());

      case chnagePassRoute:
        return MaterialPageRoute(builder: (context) => ChangePassScreen());

      default:
        return null;
    }
  }
}
