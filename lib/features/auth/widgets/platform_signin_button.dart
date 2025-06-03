import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_bloc.dart';
import 'package:luvial_app/features/auth/bloc/auth_event.dart';
import 'package:luvial_app/features/auth/bloc/auth_state.dart';

class PlatformSignInButtons extends StatelessWidget {
  const PlatformSignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is AuthCodeSent) {
        //   _showOtpDialog(context, authBloc, state.verificationId);
        // }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //   _phoneSignInButton(context, authBloc),
          _googleSignInButton(authBloc),
          if (Platform.isIOS) _appleSignInButton(authBloc),
        ],
      ),
    );
  }

  //   IconButton _phoneSignInButton(BuildContext context, AuthBloc authBloc) => IconButton(
  //     onPressed: () => _showPhoneLoginDialog(context, authBloc),
  //     icon: const Icon(Icons.phone_android, size: 48),
  //     tooltip: 'Sign in with Phone',
  //   );

  IconButton _googleSignInButton(AuthBloc authBloc) => IconButton(
    onPressed: () => authBloc.add(AuthGoogleLoginRequested()),
    icon: const Icon(Icons.g_mobiledata, size: 48),
    tooltip: 'Sign in with Google',
  );

  IconButton _appleSignInButton(AuthBloc authBloc) => IconButton(
    onPressed: () => authBloc.add(AuthAppleLoginRequested()),
    icon: const Icon(Icons.apple, size: 48),
    tooltip: 'Sign in with Apple',
  );

  //   void _showPhoneLoginDialog(BuildContext context, AuthBloc authBloc) {
  //     final phoneController = TextEditingController();

  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Enter your phone number'),
  //         content: TextField(
  //           controller: phoneController,
  //           keyboardType: TextInputType.phone,
  //           decoration: const InputDecoration(hintText: '+1234567890'),
  //         ),
  //         actions: [
  //           TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
  //           ElevatedButton(
  //             onPressed: () {
  //               final phoneNumber = phoneController.text.trim();
  //               if (phoneNumber.isNotEmpty && phoneNumber.startsWith('+') && phoneNumber.length > 8) {
  //                 authBloc.add(AuthPhoneLoginRequested(phoneNumber));
  //                 Navigator.of(context).pop();
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text('Enter valid phone number with country code')),
  //                 );
  //               }
  //             },
  //             child: const Text('Send Code'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   void _showOtpDialog(BuildContext context, AuthBloc authBloc, String verificationId) {
  //     final smsCodeController = TextEditingController();

  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Enter the OTP code'),
  //         content: TextField(
  //           controller: smsCodeController,
  //           keyboardType: TextInputType.number,
  //           decoration: const InputDecoration(hintText: '123456'),
  //           maxLength: 6,
  //         ),
  //         actions: [
  //           TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
  //           ElevatedButton(
  //             onPressed: () {
  //               final smsCode = smsCodeController.text.trim();
  //               if (smsCode.length == 6) {
  //                 authBloc.add(
  //                   AuthPhoneCodeSubmitted(verificationId: verificationId, smsCode: smsCode),
  //                 );
  //                 Navigator.of(context).pop();
  //               } else {
  //                 ScaffoldMessenger.of(
  //                   context,
  //                 ).showSnackBar(const SnackBar(content: Text('Please enter a 6-digit code')));
  //               }
  //             },
  //             child: const Text('Verify'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}
