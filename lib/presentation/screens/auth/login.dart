import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/data/providers/login_provider.dart';
import 'package:pg_photo_track/model/response.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';
import 'package:pg_photo_track/presentation/screens/auth/login_view_model.dart';
import 'package:pg_photo_track/presentation/screens/auth/otp_screen.dart';
import 'package:pg_photo_track/presentation/string_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/value_manager.dart';
import 'package:provider/provider.dart';

import '../../color_manager.dart';
import '../../font_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginViewModelController? _loginViewModelController;
  LoginProvider? _loginProvider;

  final _formKey = GlobalKey<FormState>();

  // Future<void> _fetchData() async {
  //   var result = await AppServiceClient.getAllCompanyMaster();
  //   // print("result " + result.toString());
  //   if (result is Failure) {
  //     EasyLoading.dismiss();
  //     EasyLoading.showError(result.messege);
  //   } else {
  //     setState(() {
  //       _companies = List<CompanyMaster>.from(result);
  //     });
  //   }
  // }

  @override
  void initState() {
    _loginViewModelController = LoginViewModelController(context);
    EasyLoading.show();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    // _loginViewModelController?.autoLogin().then((res) {
    //   if (res is User) {
    //     EasyLoading.dismiss();
    //     String userType = res.userType!;
    //     bool isAdmin = isAdminUser(userType);
    //     isAdmin
    //         ? Navigator.pushReplacementNamed(context, Routes.navigationScreen)
    //         : Navigator.pushReplacementNamed(context, Routes.homeRoute,
    //             arguments: {});
    //   }
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    // await _fetchData();
    _loginProvider = Provider.of<LoginProvider>(context);
    EasyLoading.dismiss();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _loginViewModelController = LoginViewModelController(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        //do your logic here:

        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want    to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        );

        // Return    the result to the previous route
        return shouldPop;
      },
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  // height: MediaQuery.of(context).size.height * 0.3,
                  // color: ColorManager.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pgvclicon.jpg',
                        width: 150,
                        height: 150,
                      ),
                      // Text(
                      //   "PG VISIT PICS",
                      //   style: TextStyle(
                      //       fontFamily: "nova", fontSize: FontSize.mediumSize),
                      // ),
                      Text("Login to IT Applications",
                          style: getBoldStyle(fontColor: Colors.black)),
                    ],
                  ),
                ),

                // SizedBox(height: AppSize.s20),

                SizedBox(height: AppSize.s60),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 42),
                  child: TextFormField(
                    controller: _userIdController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.loginIDHint,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: AppStrings.passwordHint,
                      // labelText: AppStrings.passwordHint,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      }
                      return "Username must not be empty";
                    },
                  ),
                ),
                SizedBox(height: 26.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        EasyLoading.show();
                        // var user = await AppServiceClient.login(_controllerEmpId.text, _controllerPassword.text);
                        // var result = await _loginViewModelController?.login(
                        //     _userIdController.text, _passwordController.text);
                        final result = await _loginProvider!.loginUser(
                            _userIdController.text, _passwordController.text);
                        if (_loginProvider!.isLoginSuccess == true) {
                          Navigator.pushNamed(context, Routes.homeRoute);
                        } else if (_loginProvider!.errorMessage == null) {
                          Navigator.pushNamed(context, Routes.otpRoute);
                        }

                        if (_loginProvider!.errorMessage != null) {
                          EasyLoading.showError(_loginProvider!.errorMessage!);
                        }
                        // print("user detail " + result!.empName);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                color: ColorManager.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
