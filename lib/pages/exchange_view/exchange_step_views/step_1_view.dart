import 'package:epicpay/models/exchange/incomplete_exchange.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_2_view.dart';
import 'package:epicpay/pages/exchange_view/sub_widgets/step_row.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Step1View extends StatefulWidget {
  const Step1View({
    Key? key,
    required this.model,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/exchangeStep1";

  final IncompleteExchangeModel model;
  final ClipboardInterface clipboard;

  @override
  State<Step1View> createState() => _Step1ViewState();
}

class _Step1ViewState extends State<Step1View> {
  late final IncompleteExchangeModel model;
  late final ClipboardInterface clipboard;

  @override
  void initState() {
    model = widget.model;
    clipboard = widget.clipboard;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () async {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
                await Future<void>.delayed(const Duration(milliseconds: 75));
              }
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          centerTitle: true,
          title: const SizedBox(
            width:
                66, // 66 is the width of the StepRow based on the current hardcoded values
            child: StepRow(
              count: 4,
              current: 0,
              width: 6,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // final width = MediaQuery.of(context).size.width / 3;
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 24,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 14,
                          ),
                          Center(
                            child: Text(
                              "Confirm amount",
                              style: STextStyles.titleH3(context),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Network fees and other exchange charges are included in the rate.",
                            style: STextStyles.bodySmallMed(context),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "YOU SEND",
                                style: STextStyles.overLineBold(context)
                                    .copyWith(
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .textDark),
                              ),
                              GestureDetector(
                                onTap: () {
                                  clipboard.setData(ClipboardData(
                                    text:
                                        "${model.sendAmount.toStringAsFixed(8)} ${model.from.ticker.toUpperCase()}",
                                  ));
                                },
                                child: Text(
                                  "${model.sendAmount.toStringAsFixed(8)} ${model.from.ticker.toUpperCase()}",
                                  style: STextStyles.body(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "YOU RECEIVE",
                                style: STextStyles.overLineBold(context)
                                    .copyWith(
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .textDark),
                              ),
                              GestureDetector(
                                onTap: () {
                                  clipboard.setData(ClipboardData(
                                    text:
                                        "~${model.receiveAmount.toStringAsFixed(8)} ${model.to.ticker.toUpperCase()}",
                                  ));
                                },
                                child: Text(
                                  "~${model.receiveAmount.toStringAsFixed(8)} ${model.to.ticker.toUpperCase()}",
                                  style: STextStyles.body(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                model.rateType == SupportedRateType.estimated
                                    ? "ESTIMATED RATE"
                                    : "FIXED RATE",
                                style:
                                    STextStyles.overLineBold(context).copyWith(
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .textDark,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  clipboard.setData(ClipboardData(
                                    text: model.rateInfo,
                                  ));
                                },
                                child: Text(
                                  model.rateInfo,
                                  style: STextStyles.body(context),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                Step2View.routeName,
                                arguments: model,
                              );
                            },
                            style: Theme.of(context)
                                .extension<StackColors>()!
                                .getPrimaryEnabledButtonColor(context),
                            child: Text(
                              "Next",
                              style: STextStyles.buttonText(context).copyWith(
                                color: Theme.of(context)
                                    .extension<StackColors>()!
                                    .overlay,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
