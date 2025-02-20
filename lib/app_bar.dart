import 'package:flutter/material.dart';
import 'package:mighty_lube/header_logo.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget link;
  final double height;
  final IconData customIcon;
  int? cartItemCount = -1;

  CustomAppBar(
      {super.key,
      required this.link,
      this.height = 100,
      required this.customIcon,
      this.cartItemCount});

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
                    icon: Icon(customIcon, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => link),
                      );
                    },
                  ),
                  badges.Badge(
                    badgeStyle:
                        const badges.BadgeStyle(badgeColor: Colors.white),
                    badgeContent: Text(
                      cartItemCount.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        // Add Cart functionality
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

  @override
  Size get preferredSize => Size.fromHeight(height);
}
