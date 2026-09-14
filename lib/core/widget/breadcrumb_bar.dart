import 'package:flutter/material.dart';

class BreadcrumbBar extends StatefulWidget {
  final List<String> items;
  final VoidCallback onHomeTap;
  final ValueChanged<int> onItemTap;

  const BreadcrumbBar({
    super.key,
    required this.items,
    required this.onHomeTap,
    required this.onItemTap,
  });

  @override
  State<BreadcrumbBar> createState() =>
      _BreadcrumbBarState();
}

class _BreadcrumbBarState extends State<BreadcrumbBar> {
  final ScrollController _scrollController =
  ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  @override
  void didUpdateWidget(
      covariant BreadcrumbBar oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length != widget.items.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToEnd();
      });
    }
  }

  void _scrollToEnd() {
    if (!_scrollController.hasClients) {
      return;
    }

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: widget.onHomeTap,
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 2,
                ),
                child: Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: 22,
                ),
              ),
            ),

            ...List.generate(
              widget.items.length,
                  (index) {
                final bool isLast =
                    index == widget.items.length - 1;

                return Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Text(
                        '>',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: isLast
                          ? null
                          : () {
                        widget.onItemTap(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 2,
                        ),
                        child: Text(
                          widget.items[index],
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: isLast
                                ? Colors.black87
                                : Colors.blue,
                            fontWeight: isLast
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}