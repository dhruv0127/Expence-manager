import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance});

  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50),
      padding: const EdgeInsets.only(left: 12, right: 12),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        boxShadow: [
          //bottom right
          BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(5, 5)),

          //top left
          const BoxShadow(
              color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
        ],
        color: Colors.grey[300],
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Current Balance"),
          Text(
            balance,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
