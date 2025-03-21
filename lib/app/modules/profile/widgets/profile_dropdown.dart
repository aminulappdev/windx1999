import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDropdown extends StatelessWidget {
  final String selectedOption;
  final ValueChanged<String?> onOptionChanged;

  const FilterDropdown({super.key, 
    required this.selectedOption,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String?>(
        value: selectedOption,
        dropdownColor: const Color.fromARGB(255, 191, 186, 186),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        onChanged: onOptionChanged,
        items: <String>['All', 'Images', 'Videos']
            .map<DropdownMenuItem<String?>>((String value) {
          return DropdownMenuItem<String?>(
            value: value,
            child: Row(
              children: [
                Icon(
                  value == 'All'
                      ? Icons.grid_on
                      : value == 'Images'
                          ? Icons.image
                          : Icons.video_library,
                  color: Colors.white,
                ),
                SizedBox(width: 10.w),
                Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
