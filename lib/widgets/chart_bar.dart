import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? spendingAmount;
  final double? spendingPercentage;

  const ChartBar({
    super.key,
    @required this.label,
    @required this.spendingAmount,
    @required this.spendingPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Total Amount Spent
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("\$${spendingAmount!.toStringAsFixed(0)}"),
              ),
            ),

            // Spacing
            SizedBox(height: constraints.maxHeight * 0.05),

            // Bar
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Spacing
            SizedBox(height: constraints.maxHeight * 0.05),

            // Day of the week
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label!)),
            ),
          ],
        );
      },
    );
  }
}
