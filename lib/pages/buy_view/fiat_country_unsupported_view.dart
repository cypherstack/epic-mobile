import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';

class FiatCountryUnsupportedView extends StatelessWidget {
  const FiatCountryUnsupportedView({
    super.key,
    required this.unsupportedCountry,
  });

  static const routeName = "/fiatCountryUnsupportedView";

  final String unsupportedCountry;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          leading: AppBarBackButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: RoundedWhiteContainer(
                  child: Text(
                    "Unfortunately, this service is currently not"
                    " available in $unsupportedCountry.",
                    style: STextStyles.titleH3(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
