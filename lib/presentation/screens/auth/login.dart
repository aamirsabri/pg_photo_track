import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pg_photo_track/data/providers/login_provider.dart';
import 'package:pg_photo_track/presentation/color_manager.dart';
import 'package:pg_photo_track/presentation/font_manager.dart';

import 'package:pg_photo_track/presentation/route_manager.dart';

import 'package:pg_photo_track/presentation/string_manager.dart';
import 'package:pg_photo_track/presentation/style_manager.dart';
import 'package:pg_photo_track/presentation/value_manager.dart';
import 'package:pg_photo_track/presentation/widgets/custom_button.dart';
import 'package:pg_photo_track/presentation/widgets/custom_form_field.dart';
import 'package:pg_photo_track/utils/validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginProvider? _loginProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    EasyLoading.show();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    _loginProvider = Provider.of<LoginProvider>(context);
    EasyLoading.dismiss();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        final shouldPop = await showExitDialogue();
        return shouldPop;
      },
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // buildIconWithLabel(
                //     'Login to IT Applications', 'assets/images/pgvclicon.jpg'),
                // SizedBox(
                //   width: 100,
                // ),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pgvclicon.jpg',
                        width: 75,
                        height: 75,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('FIELD PHOTO PGVCL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 21,
                              fontFamily: 'nova')),
                    ],
                  ),
                ),

                const SizedBox(height: AppSize.s60),
                CustomTextFormField(
                  controller: _userIdController,
                  hintText: AppStrings.loginIDHint,
                  validator: (value) {
                    return Validators.validateNotEmpty(value, 'User Id');
                  },
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: AppStrings.passwordHint,
                  validator: (value) {
                    return Validators.validateNotEmpty(value, 'Password');
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 26.0),
                CustomButton(
                    label: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        EasyLoading.show();
                        await _loginProvider!.loginUser(
                            _userIdController.text, _passwordController.text);
                        EasyLoading.dismiss();
                        if (_loginProvider!.isLoginSuccess == true) {
                          Navigator.pushNamed(context, Routes.visetDetail);
                        } else if (_loginProvider!.errorMessage == null) {
                          Navigator.pushNamed(context, Routes.otpRoute);
                        }

                        if (_loginProvider!.errorMessage != null) {
                          EasyLoading.showError(_loginProvider!.errorMessage!);
                        }
                        // print("user detail " + result!.empName);
                      }
                    }),
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

  Future<void> showExitDialogue() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Are you sure you want    to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget buildIconWithLabel(String label, String imageAssetPath) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageAssetPath,
            width: 150,
            height: 150,
          ),
          Text(label, style: getBoldStyle(fontColor: Colors.black)),
        ],
      ),
    );
  }
}
