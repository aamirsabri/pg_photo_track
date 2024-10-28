// presentation/pages/otp_screen.dart
import 'package:flutter/material.dart';
import 'package:pg_photo_track/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/login_provider.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  Future<void> _submitOtp() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final result = await loginProvider.submitOtp(_otpController.text.trim());

    if (result) {
      // OTP is valid, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginProvider.errorMessage.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please enter the 6-digit OTP sent to your mobile number.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            loginProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitOtp,
                    child: const Text("Submit OTP"),
                  ),
          ],
        ),
      ),
    );
  }
}
