import 'package:flutter/material.dart';

class BottomSheetOptions extends StatelessWidget {
  const BottomSheetOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        color:  const Color(0xFF282828),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(
            children: [
              Divider(
                color: Colors.white.withOpacity(0.1),
                thickness: 5,
                endIndent: 64,
                indent: 64,
              ),
              ListTile(
                trailing: const Icon(Icons.copy, color: Colors.white),
                title: const Text('Copy', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  // Implement Copy functionality
                },
              ),
              Divider(
                color: Colors.white.withOpacity(0.1),
                thickness: 2,
                endIndent: 8,
                indent: 8,
              ),
              ListTile(
                trailing: const Icon(Icons.delete, color: Colors.white),
                title: const Text('Delete', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  // Implement Delete functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
