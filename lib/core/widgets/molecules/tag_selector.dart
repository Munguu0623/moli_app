import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class TagItem {
  final String id;
  final String label;
  final IconData? icon;

  const TagItem({required this.id, required this.label, this.icon});
}

class TagSelector extends StatefulWidget {
  final List<TagItem> tags;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final int maxVisibleTags;
  final bool multiSelect;
  final String expandText;
  final String collapseText;

  const TagSelector({
    super.key,
    required this.tags,
    required this.selectedIds,
    required this.onSelectionChanged,
    this.maxVisibleTags = 5,
    this.multiSelect = true,
    this.expandText = 'Бүгдийг харах',
    this.collapseText = 'Хураах',
  });

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late List<String> _selectedIds;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedIds);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(TagSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIds != widget.selectedIds) {
      setState(() {
        _selectedIds = List.from(widget.selectedIds);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTag(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        if (widget.multiSelect) {
          _selectedIds.add(id);
        } else {
          _selectedIds = [id];
        }
      }
    });
    widget.onSelectionChanged(_selectedIds);
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  List<TagItem> _getVisibleTags() {
    if (_isExpanded || widget.tags.length <= widget.maxVisibleTags) {
      return widget.tags;
    }
    return widget.tags.take(widget.maxVisibleTags).toList();
  }

  Color _getChipColor(int index) {
    final colors = [
      AppColors.chipBlue,
      AppColors.chipPurple,
      AppColors.chipOrange,
      AppColors.chipGreen,
      AppColors.chipPink,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final visibleTags = _getVisibleTags();
    final hasMore = widget.tags.length > widget.maxVisibleTags;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Сонголт',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (_selectedIds.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: AppGradients.brand,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_selectedIds.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                visibleTags.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tag = entry.value;
                  final isSelected = _selectedIds.contains(tag.id);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: InkWell(
                      onTap: () => _toggleTag(tag.id),
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primary
                                  : _getChipColor(index),
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                          border:
                              isSelected
                                  ? Border.all(
                                    color: AppColors.primary,
                                    width: 2,
                                  )
                                  : null,
                          boxShadow: isSelected ? AppShadows.button : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (tag.icon != null) ...[
                              Icon(
                                tag.icon,
                                size: 16,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              tag.label,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 6),
                              Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
        if (hasMore) ...[
          const SizedBox(height: 12),
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(AppRadius.button),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.button),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? widget.collapseText : widget.expandText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
