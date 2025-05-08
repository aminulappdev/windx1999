import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordRow extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onCheckedChanged;
  final VoidCallback ontap;

  const ForgotPasswordRow({
    super.key,
    required this.isChecked,
    required this.onCheckedChanged,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.blue;
                  }
                  return Colors.transparent;
                },
              ),
              side: BorderSide(color: Colors.white, width: 1),
              value: isChecked,
              onChanged: (bool? value) {
                onCheckedChanged(value!);
              },
            ),
            Text(
              'Remember me',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: ontap,
          child: Text(
            'Forgot password?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
