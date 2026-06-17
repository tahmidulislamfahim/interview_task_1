import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBox({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search airport, code, city...",
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}