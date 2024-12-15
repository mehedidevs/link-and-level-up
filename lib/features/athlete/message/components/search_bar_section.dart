import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_defaults.dart';


class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          hintText: 'Search chats',
          hintStyle: AppDefaults.bodyTextStyle.copyWith(color: Colors.grey.shade300),
          filled: true,
          fillColor: AppColors.background500,
          prefixIcon: Icon(Icons.search_sharp,size: 25,color: Colors.grey.shade300,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
