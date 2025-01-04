import 'package:flutter/material.dart';

class Member {
  final String name;
  final String imageUrl;

  const Member({
    required this.name,
    required this.imageUrl,
  });
}

class MemberSelector extends StatefulWidget {
  final List<Member> availableMembers;
  final Function(List<Member>) onMembersChanged;

  const MemberSelector({
    super.key,
    required this.availableMembers,
    required this.onMembersChanged,
  });

  @override
  MemberSelectorState createState() => MemberSelectorState();
}

class MemberSelectorState extends State<MemberSelector> {
  List<Member> selectedMembers = [];
  List<Member> filteredMembers = [];
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    filteredMembers = widget.availableMembers;
  }

  void filterMembers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembers = widget.availableMembers;
      } else {
        filteredMembers = widget.availableMembers
            .where((member) =>
            member.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Widget buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: searchController,
        focusNode: searchFocusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search trainers...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          filled: true,
          fillColor: const Color(0xFF2C2C2E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
        onChanged: filterMembers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with red asterisk
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Members',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        // Dropdown container
        MenuAnchor(
          style: MenuStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF1C1C1E)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          builder: (context, controller, child) {
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                    searchFocusNode.requestFocus();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enter your members here',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20.0,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          menuChildren: [
            // Search field
            buildSearchField(),
            // Divider
            Divider(color: Colors.grey[800], height: 1),
            // Member list
            ...filteredMembers
                .where((member) => !selectedMembers.contains(member))
                .map((member) {
              return MenuItemButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedMembers.add(member);
                    searchController.clear();
                    filterMembers('');
                  });
                  widget.onMembersChanged(selectedMembers);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(member.imageUrl),
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      member.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
        const SizedBox(height: 16.0),
        // Selected members chips
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: selectedMembers.map((member) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(member.imageUrl),
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMembers.remove(member);
                      });
                      widget.onMembersChanged(selectedMembers);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[600],
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}

