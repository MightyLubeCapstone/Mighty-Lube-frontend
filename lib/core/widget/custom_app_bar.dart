import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../features/cart/repositories/cart_repositories.dart';
import '../../features/cart/screens/shopping_page.dart';
import 'app_bar_icon_button.dart';
import '../../core/widget/header_logo.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget link;
  final double height;
  final IconData customIcon;

  int? cartItemCount;

  final bool? reload;
  final void Function(int)? callback;

  // Search
  final bool showSearch;
  final ValueChanged<String>? onSearchChanged;

  CustomAppBar({
    super.key,
    required this.link,
    required this.customIcon,
    this.height = 56,
    this.cartItemCount = 0,
    this.reload,
    this.callback,
    this.showSearch = false,
    this.onSearchChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  // =========================================================
  // CART COUNT
  // =========================================================

  Future<void> getOrders() async {
    try {
      final response = await CartRepository.getOrders();

      if (!response.success || response.data == null) {
        return;
      }

      int totalQuantities = 0;

      for (final order in response.data!) {
        if (order is Map) {
          totalQuantities += int.tryParse(
            order['quantity']?.toString() ?? '0',
          ) ??
              0;
        }
      }

      widget.cartItemCount = totalQuantities;

      if (widget.callback != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.callback!(totalQuantities);
        });
      }

      if (mounted) {
        setState(() {});
      }
    } catch (_) {
      // AppBar should continue working
      // even if cart API fails.
    }
  }

  // =========================================================
  // SEARCH
  // =========================================================

  void _openSearch() {
    setState(() {
      _isSearching = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _closeSearch() {
    _searchController.clear();

    widget.onSearchChanged?.call('');

    _searchFocusNode.unfocus();

    setState(() {
      _isSearching = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF579AF6),
      elevation: 1,
      toolbarHeight: widget.height,
      titleSpacing: 0,
      title: _isSearching ? _buildSearchBar() : _buildNormalBar(context),
    );
  }

  // =========================================================
  // NORMAL APP BAR
  // =========================================================

  Widget _buildNormalBar(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ===================================================
          // MENU
          // ===================================================

          Builder(
            builder: (context) {
              return AppBarIconButton(
                icon: Icons.menu_rounded,
                tooltip: 'Menu',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),

          // ===================================================
          // LOGO
          // ===================================================

          const SizedBox(
            width: 120,
            height: 44,
            child: Center(
              child: HeaderLogo(
                pressable: true,
              ),
            ),
          ),

          // Push remaining icons to right
          const Spacer(),

          // ===================================================
          // SEARCH
          // ===================================================

          if (widget.showSearch)
            AppBarIconButton(
              icon: Icons.search_rounded,
              tooltip: 'Search',
              onPressed: _openSearch,
            ),

          // ===================================================
          // CUSTOM ICON
          // ===================================================

          AppBarIconButton(
            icon: widget.customIcon,
            tooltip: 'Application',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => widget.link,
                ),
              );
            },
          ),

          // ===================================================
          // CART
          // ===================================================

          Padding(
            padding: const EdgeInsets.only(
              right: 6,
            ),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(
                top: -2,
                end: -2,
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.white,
              ),
              badgeContent: Text(
                widget.cartItemCount?.toString() ?? '0',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: AppBarIconButton(
                icon: Icons.shopping_cart_outlined,
                tooltip: 'Cart',
                onPressed: () {
                  if (widget.reload == false) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ShoppingPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SEARCH MODE
  // =========================================================

  Widget _buildSearchBar() {
    return SizedBox(
      height: widget.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                textInputAction: TextInputAction.search,
                onChanged: widget.onSearchChanged,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 23,
                    color: Colors.black54,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            width: 4,
          ),

          // Same common button for close
          AppBarIconButton(
            icon: Icons.close_rounded,
            tooltip: 'Close search',
            onPressed: _closeSearch,
          ),

          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}