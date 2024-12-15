import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/app_defaults.dart';


class CommunityCreatePostScreen extends StatefulWidget {
  const CommunityCreatePostScreen({super.key});

  @override
  _CommunityCreatePostScreenState createState() => _CommunityCreatePostScreenState();
}

class _CommunityCreatePostScreenState extends State<CommunityCreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isPostEnabled = false;
  final List<String> _images = [];

  void _onTextChanged(String text) {
    setState(() {
      _isPostEnabled = text.isNotEmpty;
    });
  }

  void _onPost() {
    // Handle post action
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close,color: Colors.white,size: 25,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/profile_holder2.png'), // Replace with the user's profile image
            ),
            const SizedBox(width: 10),
            Text('Create post',style: AppDefaults.titleHeadlineStyle,),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: _isPostEnabled ? _onPost : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isPostEnabled ? const Color(0xFFB79654) : const Color(0xFF41351E),
              elevation: _isPostEnabled ? 4 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              'Post',
              style: AppDefaults.buttonTextStyle
            ),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                border: InputBorder.none,
                hintStyle: AppDefaults.buttonTextStyle
              ),
            ),
            const SizedBox(height: 16),
            if (_images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(_images.length, (index) {
                  return Stack(
                    children: [
                      Image.network(
                        _images[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => _removeImage(index),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            // if (_images.isEmpty)
            //   // IconButton(
            //   //   icon: Icon(Icons.photo_library),
            //   //   onPressed: () {
            //   //     // Logic to pick images and add to _images list
            //   //   },
            //   // ),
          ],
        ),
      ),
      floatingActionButton: SvgPicture.asset('icons/ic_gallery.svg',height: 25,width: 25,),
    );
  }
}
