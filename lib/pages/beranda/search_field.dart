import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const SearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Cari obat, multivitamin...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 22),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
