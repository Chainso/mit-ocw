import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mit_ocw/routes.dart';

class HomeHeader extends StatefulWidget {
  final Function(String)? onSearch;

  const HomeHeader({Key? key, this.onSearch}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _isExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (!_isExpanded) {
        _searchController.clear();
      }
    });
  }

  void _submitSearch() {
    if (_searchController.text.isNotEmpty) {
      if (widget.onSearch != null) {
        widget.onSearch!(_searchController.text);
      } else {
        SearchScreenRoute(q: _searchController.text).go(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              if (!_isExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SvgPicture.asset(
                    'assets/images/mit-ocw-logo.svg',
                    height: 36,
                    color: Colors.white,
                  ),
                ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isExpanded
                      ? TextField(
                          controller: _searchController,
                          autofocus: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search courses...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onSubmitted: (_) => _submitSearch(),
                        )
                      : const SizedBox(),
                ),
              ),
              IconButton(
                icon: Icon(_isExpanded ? Icons.close : Icons.search, color: Colors.white),
                onPressed: _toggleSearch,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2.0), // Added space before the divider
        const Divider(color: Colors.white24, thickness: 1, height: 1),
      ],
    );
  }
}