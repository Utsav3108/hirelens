import 'package:flutter/material.dart';

class CustomMultiSelectField extends StatefulWidget {
  final String placeholder;
  final List<String> options;
  final ValueChanged<List<String>>? onSelectionChanged;
  final int gridCount;
  final bool enableAnimation;

  // optional scroll handling
  final ScrollController? scrollController;
  final double? viewHeight;

  const CustomMultiSelectField({
    super.key,
    required this.placeholder,
    required this.options,
    this.onSelectionChanged,
    this.gridCount = 4,
    this.enableAnimation = true,
    this.scrollController,
    this.viewHeight,
  });

  @override
  State<CustomMultiSelectField> createState() => _CustomMultiSelectFieldState();
}

class _CustomMultiSelectFieldState extends State<CustomMultiSelectField>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  final List<String> _selectedItems = [];

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpanded() {
    final wasExpanded = _expanded;
    setState(() => _expanded = !_expanded);

    if (!wasExpanded && _expanded) {
      // expanding

      _controller.forward().then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.scrollController == null ||
              widget.scrollController!.position.maxScrollExtent == 0) {
            return;
          }

          _scrollIntoVisibleArea();
        });
      });
    } else if (wasExpanded && !_expanded) {
      // collapsing
      _controller.reverse().then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.scrollController == null) return;

          final ScrollController scrollController = widget.scrollController!;

          print("==> Scroll Positions : ${scrollController.position}");
          print(
            "==> maxScrollExtent: ${scrollController.position.maxScrollExtent}",
          );
          print(
            "==> minScrollExtent: ${scrollController.position.minScrollExtent}",
          );
          print("==> extentTotal: ${scrollController.position.extentTotal}");
          print("==> outOfRange: ${scrollController.position.outOfRange}");
          print("==> offset: ${scrollController.offset}");

          _scrollBackAfterCollapse();
        });
      });
    }
  }

  void _toggleSelection(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    widget.onSelectionChanged?.call(_selectedItems);
  }

  /// When expanded, scroll just enough so entire grid fits in view
  void _scrollIntoVisibleArea() {
    if (widget.scrollController == null ||
        widget.viewHeight == null ||
        !_expanded)
      return;

    final context = _containerKey.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final position = box.localToGlobal(Offset.zero);
    final bottomY = position.dy + box.size.height;
    final screenHeight = widget.viewHeight!;

    if (bottomY > screenHeight) {
      final offset =
          widget.scrollController!.offset +
          (bottomY - screenHeight) +
          20; // a bit of margin

      _safeAnimateTo(offset);
    }
  }

  /// When collapsed, scroll up to remove bottom gap if any
  void _scrollBackAfterCollapse() {
    if (widget.scrollController == null || widget.viewHeight == null) return;

    final currentOffset = widget.scrollController!.offset;
    if (currentOffset <= 0) return;

    final context = _containerKey.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final position = box.localToGlobal(Offset.zero);
    final bottomY = position.dy + box.size.height;
    final screenHeight = widget.viewHeight!;

    // if current content bottom is well within visible area, scroll up a bit
    if (bottomY < screenHeight - 100) {
      final targetOffset = (currentOffset - 120).clamp(
        widget.scrollController!.position.minScrollExtent,
        widget.scrollController!.position.maxScrollExtent,
      );
      _safeAnimateTo(targetOffset);
    }
  }

  void _safeAnimateTo(double offset) {
    if (!widget.scrollController!.hasClients) return;
    widget.scrollController!.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 400),
      crossFadeState: _expanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: GestureDetector(
        onTap: _toggleExpanded,
        child: _buildTagContainer(),
      ),
      secondChild: _buildSelectionGrid(),
    );
  }

  Widget _buildTagContainer() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          key: _containerKey,
          padding: const EdgeInsets.all(12),
          width: constraints.maxWidth,
          constraints: const BoxConstraints(minHeight: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: _selectedItems.isEmpty
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.placeholder,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: _selectedItems
                      .map(
                        (item) => Chip(
                          label: Text(item),
                          backgroundColor: Colors.white10,
                          deleteIcon: const Icon(Icons.close, size: 16),
                          onDeleted: () => _toggleSelection(item),
                        ),
                      )
                      .toList(),
                ),
        );
      },
    );
  }

  Widget _buildSelectionGrid() {
    return ScaleTransition(
      scale: widget.enableAnimation
          ? _scaleAnimation
          : const AlwaysStoppedAnimation(1.0),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.gridCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final item = widget.options[index];
              final isSelected = _selectedItems.contains(item);

              return GestureDetector(
                onTap: () => _toggleSelection(item),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blueAccent.withOpacity(0.3)
                        : Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.blueAccent : Colors.white24,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: _toggleExpanded,
              child: const Text("Done"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
