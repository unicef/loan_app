import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/presentation.dart';

import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.currencyFiat,
    required this.payment,
  }) : super(key: key);
  final String currencyFiat;
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Formatter.formatDate(DateTime.now()),
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.75,
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 2.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Repayment'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.75,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$currencyFiat ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: Formatter.formatMoney(
                            payment.paymentAmount,
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget shimmer(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(
            height: 12.5,
            width: 100,
          ),
          const SizedBox(height: 5),
          ShimmerBox(
            height: 50,
            width: ScreenSize.of(context).width,
          ),
        ],
      ),
    );
  }
}
