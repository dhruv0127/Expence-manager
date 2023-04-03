import 'package:flutter/material.dart';

class Txwidget extends StatelessWidget {
  const Txwidget({
    super.key,
    required this.txname,
    required this.money,
    required this.incomeorexpence,
  });

  final String txname;
  final String money;
  final String incomeorexpence;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 12, left: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 53,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              //bottom right
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 15,
                  offset: const Offset(5, 5)),

              const BoxShadow(
                  color: Color.fromARGB(255, 255, 255, 255),
                  blurRadius: 15,
                  offset: Offset(-5, -5))
            ],
            color: const Color.fromARGB(255, 27, 27, 60),
            shape: BoxShape.rectangle),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txname,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              incomeorexpence == 'income' ? '+  ₹ $money' : '-  ₹ $money',
              style: TextStyle(
                  color:
                      incomeorexpence == 'income' ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBG extends StatelessWidget {
  const CustomBG({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.only(top: 15, bottom: 2),
      color: const Color.fromARGB(255, 255, 17, 0),
      child: Icon(
        Icons.delete_outline_rounded,
        // color: Color.fromARGB(255, 255, 255, 255),
        color: Colors.grey[300],
        size: 25,
      ),
    );
  }
}
