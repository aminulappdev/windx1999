import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PaymentSuccessScreen extends StatefulWidget {
  static const String routeName = '/payment-success-screen';
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    _movetoNewScreen();
    super.initState();
  }

  Future<void> _movetoNewScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    // Navigator.pushReplacementNamed(
    //   context,
    //   PaymentDetailsScreen.routeName,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsPath.payment),
                        fit: BoxFit.fill)),
              ),
            ),
            heightBox8,
            Text(
              'Congratulation',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600),
            ),
            heightBox8,
            SizedBox(
              width: 280.w,
              child: Text(
                textAlign: TextAlign.center,
                'Payment completed successfully. A confirmation has been sent to your email.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                    
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
