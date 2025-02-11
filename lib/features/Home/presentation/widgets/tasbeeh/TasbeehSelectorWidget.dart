import 'package:flutter/material.dart';

class TasbeehSelectorWidget extends StatelessWidget {
  final String selectedTasbeeh;
  final List<String> tasbeehOptions;
  final void Function(String?) onChanged;  // Change to accept nullable String?

  const TasbeehSelectorWidget({
    Key? key,
    required this.selectedTasbeeh,
    required this.tasbeehOptions,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedTasbeeh,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: selectedTasbeeh,
            isExpanded: true,
            alignment: AlignmentDirectional.centerEnd,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: onChanged,  // Now accepts nullable String?
            items: tasbeehOptions.map((tasbeeh) {
              return DropdownMenuItem<String>(
                value: tasbeeh,
                child: Text(
                  tasbeeh,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
