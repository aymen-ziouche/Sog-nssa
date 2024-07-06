import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatelessWidget {
  final void Function(String? value) onChanged;
  final List<String> items;
  final String hint;
  const DropDownMenuComponent({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      dropdownColor: Colors.black87,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      isExpanded: true,
      elevation: 16,
      style: Theme.of(context).textTheme.headlineSmall,
      hint: FittedBox(
        child: Text(
          hint,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }
}
