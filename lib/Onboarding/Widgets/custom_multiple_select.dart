import 'package:flutter/material.dart';

class CustomMultiSelectField extends StatefulWidget {
  final String placeholder;
  final List<String> options;
  final ValueChanged<List<String>>? onSelectionChanged;
  final int gridCount;
  final bool enableAnimation;

  const CustomMultiSelectField({
    super.key,
    required this.placeholder,
    required this.options,
    this.onSelectionChanged,
    this.gridCount = 4,
    this.enableAnimation = true,
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
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
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
          padding: const EdgeInsets.all(12),
          width: constraints.maxWidth,
          constraints: BoxConstraints(minHeight: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: _selectedItems.isEmpty
              ? Center(
                  child: Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: Text(
                      widget.placeholder,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
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
          ElevatedButton(onPressed: _toggleExpanded, child: const Text("Done")),
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
