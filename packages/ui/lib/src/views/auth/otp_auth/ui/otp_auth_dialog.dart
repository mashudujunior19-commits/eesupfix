import 'dart:async';

import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

class OtpAuthDialog extends StatefulWidget {
  const OtpAuthDialog({
    super.key,
    this.email,
    this.phone,
    this.isSignUp = false,
    required this.type,
  });
  final String? email;
  final String? phone;
  final bool isSignUp;
  final OtpType type;

  @override
  State<OtpAuthDialog> createState() => _OtpAuthDialogState();
}

class _OtpAuthDialogState extends State<OtpAuthDialog> {
  final controller = TextEditingController();
  bool _isVerifying = false;
  bool _isResending = false;
  int _resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    controller.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _resendCooldown = 60);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCooldown--;
        if (_resendCooldown <= 0) {
          timer.cancel();
        }
      });
    });
  }

  OtpType _getOtpType() {
    if (widget.isSignUp) {
      if (widget.phone != null) {
        return OtpType.sms;
      } else if (widget.email != null) {
        return OtpType.signup;
      }
    }
    return widget.type;
  }

  bool _isValidOtp(String otp) {
    return RegExp(r'^\d{6}$').hasMatch(otp);
  }

  Future<void> _handleVerify() async {
    if (_isVerifying) return;

    FocusScope.of(context).unfocus();

    final otp = controller.text.trim();
    if (!_isValidOtp(otp)) {
      context.snackBarError('Please enter a valid 6-digit OTP');
      return;
    }

    setState(() => _isVerifying = true);
    context.loaderOverlay.show();

    final res = await context.read<AuthRepository>().verifyOtp(
          email: widget.email,
          phone: widget.phone,
          otp: otp,
          type: _getOtpType(),
        );

    if (!mounted) return;
    context.loaderOverlay.hide();
    setState(() => _isVerifying = false);

    if (res) {
      Navigator.pop(context, true);
    } else {
      context.snackBarError('Invalid or expired OTP');
    }
  }

  Future<void> _handleResend() async {
    if (_isResending || _resendCooldown > 0) return;

    setState(() => _isResending = true);
    context.loaderOverlay.show();

    final res = await context.read<AuthRepository>().resendOtp(
          email: widget.email,
          phone: widget.phone,
          type: _getOtpType(),
        );

    if (!mounted) return;
    context.loaderOverlay.hide();
    setState(() => _isResending = false);

    res.fold((left) {
      context.snackBarError(left.message);
    }, (right) {
      if (right) {
        context.snackBarSuccess('OTP resent');
        _startCooldown();
      } else {
        context.snackBarError('Failed to resend OTP');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Verify One time pin'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images/verification_person.png',
            ),
          ),
          if (widget.phone != null)
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Text(
                'We have sent an OTP to your phone number, +${widget.phone}',
                textAlign: TextAlign.center,
              ),
            ),
          if (widget.email != null)
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Text(
                'We have sent an OTP to your email address, ${widget.email}',
                textAlign: TextAlign.center,
              ),
            ),
          EESUpTextFormField(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 15),
            hintText: 'Enter 6-digit OTP',
            controller: controller,
            type: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: ElevatedButton(
              onPressed: _isVerifying ? null : _handleVerify,
              child: _isVerifying
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Verify'),
            ),
          ),
          10.sH,
          TextButton(
            onPressed: (_isResending || _resendCooldown > 0) ? null : _handleResend,
            child: _isResending
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _resendCooldown > 0
                        ? 'Resend in ${_resendCooldown}s'
                        : 'Resend',
                  ),
          ),
        ],
      ),
    );
  }
}
