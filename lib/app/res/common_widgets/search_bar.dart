import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.all(8),
        hintText: 'Search',
        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
        fillColor: Color.fromARGB(116, 255, 255, 255),
        filled: true,
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
      ),
    );
  }
}


OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(50),
  );
}
