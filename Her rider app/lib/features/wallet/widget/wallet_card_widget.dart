import 'package:flutter/material.dart';

class WalletCardWidget extends StatelessWidget {
  final String walletName;
  final double balance;
  final String userName;

  const WalletCardWidget({
    super.key,
    required this.walletName,
    required this.balance,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF00042F), Color(0xFFFF0383)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(walletName,
              style: const TextStyle(
                  fontSize: 16, color: Colors.white70, letterSpacing: 1)),
          const Spacer(),
          Text(
            "R ${balance.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(userName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              )),
        ],
      ),
    );
  }
}
