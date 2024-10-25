import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/presentation/screens/auth/login_view_model.dart';
import 'package:pg_photo_track/presentation/string_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/value_manager.dart';

import '../../color_manager.dart';
import '../../font_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginViewModelController? _loginViewModelController;

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
    EasyLoading.dismiss();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _loginViewModelController = LoginViewModelController(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: ColorManager.primary,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PG VISIT PICS",
                      style: TextStyle(
                          fontFamily: "nova", fontSize: FontSize.extraBigSize),
                    ),
                    Text("Login to IT Applications",
                        style: getBoldStyle(fontColor: Colors.black)),
                  ],
                )),
              ),

              SizedBox(height: AppSize.s20),

              // SizedBox(height: AppSize.s24),
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
              // SizedBox(height: 48.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 42),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();
                      // var user = await AppServiceClient.login(_controllerEmpId.text, _controllerPassword.text);
                      var result = await _loginViewModelController?.login(
                          _userIdController.text, _passwordController.text);

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
              SizedBox(
                height: AppSize.s12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
