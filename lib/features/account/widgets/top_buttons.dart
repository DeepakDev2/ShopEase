import 'package:amazon/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountButton(text: "Your Orders", onTap: (){}),
            AccountButton(text: "Turn Sellers", onTap: (){}),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AccountButton(text: "Log Out", onTap: (){}),
            AccountButton(text: "Your Wish List", onTap: (){}),
          ],
        ),
      ],
    );
  }
}
