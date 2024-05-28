import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatus extends StatelessWidget {
  final String status;
  final bool isOverDue;

  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatus({super.key, required this.status, required this.isOverDue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusDot(title: 'Pedido confirmado', isActive: true),
        const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('|')),
        if (currentStatus == 1) ...[
          const _StatusDot(
            title: 'Pix extornado',
            isActive: false,
            backGroundColor: Colors.orange,
          )
        ] else if (isOverDue) ...[
          const _StatusDot(
            isActive: true,
            title: 'Pagamento PIX vencido',
            backGroundColor: Colors.red,
          )
        ] else ...[
          _StatusDot(isActive: currentStatus >= 2, title: 'Pagamento'),
          const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('|')),
          _StatusDot(isActive: currentStatus >= 3, title: 'Preparando'),
          const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('|')),
          _StatusDot(isActive: currentStatus >= 4, title: 'Envio'),
          const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('|')),
          _StatusDot(isActive: currentStatus == 5, title: 'Entregue'),
        ]
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backGroundColor;

  const _StatusDot(
      {super.key,
      required this.isActive,
      required this.title,
      this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //DOT
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.customSwatchColor),
            color: isActive
                ? backGroundColor ?? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
