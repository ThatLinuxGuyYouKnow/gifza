import 'package:flutter/material.dart';

class FilterPill extends StatelessWidget {
  final String filterText;
  final Function(String value) onFilter;
  final Icon filterIcon;

  const FilterPill({
    super.key,
    required this.filterText,
    required this.onFilter,
    required this.filterIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        color: const Color(0xFF1A2744),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        offset: const Offset(0, 60),
        onSelected: (value) => onFilter(value),
        itemBuilder: (_) => [
          const PopupMenuItem(
            value: 'asc',
            child: Text('Oldest First', style: TextStyle(color: Colors.white)),
          ),
          const PopupMenuItem(
            value: 'desc',
            child: Text('Newest First', style: TextStyle(color: Colors.white)),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFF141f38),
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              filterIcon,
              const SizedBox(width: 10),
              Text(
                filterText,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
