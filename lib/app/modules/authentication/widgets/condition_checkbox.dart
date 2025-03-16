
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionCheckerCheckbox extends StatelessWidget {
  const ConditionCheckerCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged, required this.text,
  });

  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onChanged: onChanged,
        ),
        Expanded(
            child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.italic),
        ))
      ],
    );
  }
}