import 'package:flutter/material.dart';
import 'package:loan_app/features/user_profile/presentation/widgets/widgets.dart';
import 'package:loan_app/i18n/i18n.dart';

class TotalNumberOfLoansCard extends StatelessWidget {
  const TotalNumberOfLoansCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Number of Loans Taken'.tr(),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const StatDivider(),
            Text(
              '23',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'These are the number of loans you have taken through the '
                        'Leaf Loan App.'
                    .tr(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 10,
                    ),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }
}