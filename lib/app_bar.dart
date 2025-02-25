import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/header_logo.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mighty_lube/shoppingCart.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget link;
  final double height;
  final IconData customIcon;
  int? cartItemCount = -1;
  bool? reload;
  void Function(int)? callback;

  CustomAppBar(
      {super.key,
      required this.link,
      this.height = 100,
      required this.customIcon,
      this.cartItemCount,
      this.reload,
      this.callback});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  void getOrders() async {
    dynamic temp = await FormAPI().getOrders();
    int totalQuantities = 0;
    for (var order in temp) {
      totalQuantities += order["quantity"] as int;
    }
    widget.cartItemCount = totalQuantities;
    if (widget.callback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.callback!(totalQuantities);
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // load all orders :D
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), // Larger AppBar
      child: AppBar(
        backgroundColor: const Color(0xFF579AF6),
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            const HeaderLogo(),
            Positioned(
              top: 50, // Adjust position
              right: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(widget.customIcon, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => widget.link),
                      );
                    },
                  ),
                  badges.Badge(
                    badgeStyle:
                        const badges.BadgeStyle(badgeColor: Colors.white),
                    badgeContent: Text(
                      widget.cartItemCount != null
                          ? widget.cartItemCount!.toString()
                          : "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        if (widget.reload == false) {
                          // do nothing
                        } else {
                          // Add Cart functionality
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShoppingPage(),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
