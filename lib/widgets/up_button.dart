// widgets/up_button.dart

import 'package:flutter/material.dart';

class UpButton extends StatefulWidget {
  final ScrollController scrollController;

  const UpButton({super.key, required this.scrollController});

  @override
  State<UpButton> createState() => _UpButtonState();
}

class _UpButtonState extends State<UpButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.offset > 300) {
        if (!_isVisible) {
          setState(() => _isVisible = true);
        }
      } else {
        if (_isVisible) {
          setState(() => _isVisible = false);
        }
      }
    });
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: _isVisible
          ? Positioned(
              bottom: 100,
              right: 16,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(Icons.keyboard_arrow_up, size: 28),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
