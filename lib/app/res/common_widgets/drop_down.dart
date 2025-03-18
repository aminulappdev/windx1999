import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart'; // Assuming custom sizes are defined here.

class DropDownButton extends StatefulWidget {
  final List<Map<dynamic, dynamic>> option;

  const DropDownButton({
    super.key,
    required this.option,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  bool _isDropdownOpen = false;
  String _selectedValue = '';

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.option.isNotEmpty ? widget.option[0]['name'] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The main dropdown button
        Container(
          height: 24.h,
          width: 93.w,
          decoration: BoxDecoration(
            color: const Color(0xffEBF5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [           
                Row(
                  children: [
                    Icon(Icons.group, size: 14),
                    widthBox4,
                    Text(
                      _selectedValue,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Dropdown toggle button (arrow up/down)
                GestureDetector(
                  onTap: _toggleDropdown,
                  child: CircleAvatar(
                    radius: 8.r,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Icon(
                        _isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: const Color.fromARGB(255, 43, 123, 242),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Dropdown options
        if (_isDropdownOpen) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.option.map((val) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedValue = val['name'];
                        _isDropdownOpen = false; 
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2.0.h),
                      child: Row(
                        children: [
                          Icon(val['icon'],size: 12,), 
                          SizedBox(width: 8.w),
                          Text(
                            val['name'], 
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
