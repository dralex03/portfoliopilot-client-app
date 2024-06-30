import 'package:androidproject/models/portfolio.dart';
import 'package:androidproject/models/response_object.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../services/service_locator.dart';

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
  String dropdownValue = '';
  // Animation controller for the dropdown icon rotation.
  late AnimationController _controller;
  // Animation for rotating the dropdown icon.
  late Animation<double> _iconTurns;
  // Overlay entry for the dropdown menu.
  OverlayEntry? _overlayEntry;

  final stateController = getIt<DashboardController>();

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
              child:  FutureBuilder(
                future: stateController.loadAllPortfolios(),
                builder: (BuildContext context, AsyncSnapshot<ResponseObject> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.data!.data.map<Widget>((Portfolio portfolio) {
                        return Column(
                          children: [
                            // List tile for each portfolio option.
                            ListTile(
                              title: Center(
                                child: Text(
                                  portfolio.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  dropdownValue = portfolio.name;
                                });
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("current_portfolio_id", portfolio.id);
                                widget.onPortfolioChanged(portfolio.name); // Notify the parent widget of the change.
                                _hideDropdown();
                              },
                            ),
                            if (portfolio.name != snapshot.data!.data.last) // Add a divider except after the last item.
                              const Divider(color: Colors.grey, height: 1),
                          ],
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    /*return Center(
                        child: Text('Error: ${snapshot.error.toString()}'),
                      );*/
                    ResponseObject err = snapshot.error as ResponseObject;
                    return Center(
                      child: Text('Error: ${err.message}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              /*Column(
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
              ),*/
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
            FutureBuilder(
              future: stateController.loadPortfolio(),
              builder: (BuildContext context, AsyncSnapshot<ResponseObject> snapshot) {
                dropdownValue = (snapshot.data!.data as Portfolio).name;
                if (snapshot.hasData) {
                  return Text(
                    dropdownValue,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lato'),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
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
