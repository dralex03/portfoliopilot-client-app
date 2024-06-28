import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A custom app bar that allows the user to select a portfolio from a dropdown menu.
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  // Callback for when the portfolio changes.
  final Function(String) onPortfolioChanged;

  const CustomAppBar({super.key, required this.onPortfolioChanged});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  // The currently selected portfolio.
  String dropdownValue = 'Main Portfolio';
  // Animation controller for the dropdown icon rotation.
  late AnimationController _controller;
  // Animation for rotating the dropdown icon.
  late Animation<double> _iconTurns;
  // Overlay entry for the dropdown menu.
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _toggleDropdown() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  // Shows the dropdown menu by inserting the overlay entry.
  void _showDropdown(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    _toggleDropdown();
  }


  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _toggleDropdown();
  }


  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox!.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideDropdown,
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),

          Positioned(
            left: offset.dx + size.width / 2 - 100,
            top: offset.dy + size.height,
            width: 200,
            child: Material(
              color: AppColors.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <String>['Main Portfolio', 'Second Portfolio'].map<Widget>((String value) {
                  return Column(
                    children: [
                      ListTile(
                        title: Center(
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            dropdownValue = value;
                          });
                          widget.onPortfolioChanged(value);
                          _hideDropdown();
                        },
                      ),
                      if (value != 'Second Portfolio')
                        const Divider(color: Colors.grey, height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          if (_overlayEntry == null) {
            _showDropdown(context);
          } else {
            _hideDropdown();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dropdownValue,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lato'),
            ),
            RotationTransition(
              turns: _iconTurns,
              child: const Icon(Icons.expand_more, color: Colors.white),
            ),
          ],
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
