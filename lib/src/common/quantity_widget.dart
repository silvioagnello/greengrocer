import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
  final int value;
  final String suffix;
  final bool isRemovable;
  final Function(int quantity) result;

  const QuantityWidget(
      {super.key,
      required this.value,
      required this.suffix,
      required this.result,
      this.isRemovable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, spreadRadius: 0, blurRadius: 1),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BOTÃO MINUS
          CustomButtomOper(
              icon: !isRemovable || value > 1 ? Icons.remove : Icons.delete,
              color: !isRemovable || value > 1 ? Colors.grey : Colors.red,
              onPressed: () {
                if (value == 1 && !isRemovable) {
                  return;
                }
                if (value > 0) {
                  int resultCount = value - 1;
                  result(resultCount);
                }
              }),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '$value $suffix',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          CustomButtomOper(
              icon: Icons.add,
              color: CustomColors.customSwatchColor,
              onPressed: () {
                int resultCount = value + 1;
                result(resultCount);
              })
        ],
      ),
    );
  }
}

class CustomButtomOper extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomButtomOper({
    super.key,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
