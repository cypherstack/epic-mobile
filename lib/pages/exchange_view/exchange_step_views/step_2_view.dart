/*
 * This file is part of Stack Wallet.
 *
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:epicpay/models/exchange/incomplete_exchange.dart';
import 'package:epicpay/pages/exchange_view/exchange_form.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_3_view.dart';
import 'package:epicpay/pages/exchange_view/sub_widgets/step_row.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/utilities/address_utils.dart';
import 'package:epicpay/utilities/barcode_scanner_interface.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/icon_widgets/clipboard_icon.dart';
import 'package:epicpay/widgets/icon_widgets/qrcode_icon.dart';
import 'package:epicpay/widgets/icon_widgets/x_icon.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:epicpay/widgets/stack_text_field.dart';
import 'package:epicpay/widgets/textfield_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step2View extends ConsumerStatefulWidget {
  const Step2View({
    Key? key,
    required this.model,
    this.clipboard = const ClipboardWrapper(),
    this.barcodeScanner = const BarcodeScannerWrapper(),
  }) : super(key: key);

  static const String routeName = "/exchangeStep2";

  final IncompleteExchangeModel model;
  final ClipboardInterface clipboard;
  final BarcodeScannerInterface barcodeScanner;

  @override
  ConsumerState<Step2View> createState() => _Step2ViewState();
}

class _Step2ViewState extends ConsumerState<Step2View> {
  late final IncompleteExchangeModel model;
  late final ClipboardInterface clipboard;
  late final BarcodeScannerInterface scanner;

  late final TextEditingController _toController;
  late final TextEditingController _refundController;

  late final FocusNode _toFocusNode;
  late final FocusNode _refundFocusNode;

  bool enableNext = false;

  bool isStackCoin(String ticker) {
    try {
      coinFromTickerCaseInsensitive(ticker);
      return true;
    } on ArgumentError catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    model = widget.model;
    clipboard = widget.clipboard;
    scanner = widget.barcodeScanner;

    _toController = TextEditingController();
    _refundController = TextEditingController();

    _toFocusNode = FocusNode();
    _refundFocusNode = FocusNode();

    final tuple = ref.read(exchangeSendFromWalletIdStateProvider.state).state;
    if (tuple != null) {
      final manager = ref.read(walletProvider)!;
      if (model.to.ticker.toLowerCase() == tuple.item2.ticker.toLowerCase()) {
        if (manager.walletId != tuple.item1) {
          Logging.instance.log(
            "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
            level: LogLevel.Fatal,
          );
        } else {
          manager.currentReceivingAddress.then((value) {
            _toController.text = value;
            model.recipientAddress = _toController.text;
          });
        }
      } else {
        if (model.from.ticker.toUpperCase() ==
            tuple.item2.ticker.toUpperCase()) {
          if (manager.walletId != tuple.item1) {
            Logging.instance.log(
              "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
              level: LogLevel.Fatal,
            );
          } else {
            manager.currentReceivingAddress.then((value) {
              _refundController.text = value;
              model.refundAddress = _refundController.text;
            });
          }
        }
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    _toController.dispose();
    _refundController.dispose();

    _toFocusNode.dispose();
    _refundFocusNode.dispose();

    super.dispose();
  }

  static const supportsRefund = true;

  @override
  Widget build(BuildContext context) {
    // final supportsRefund =
    //     ref.watch(efExchangeProvider).name != MajesticBankExchange.exchangeName;

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StepRow(
                count: 4,
                current: 1,
                width: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 7,
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = MediaQuery.of(context).size.width - 32;
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
                          // StepRow(
                          //   count: 4,
                          //   current: 1,
                          //   width: width,
                          // ),
                          const SizedBox(
                            height: 14,
                          ),
                          Center(
                            child: Text(
                              "Exchange details",
                              style: STextStyles.pageTitleH1(context),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Enter your recipient and refund addresses",
                            style: STextStyles.itemSubtitle(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textMedium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recipient Wallet",
                                style: STextStyles.smallMed12(context),
                              ),
                              // if (isStackCoin(model.receiveTicker))
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Constants.size.circularBorderRadius,
                            ),
                            child: TextField(
                              onTap: () {},
                              key: const Key(
                                  "recipientExchangeStep2ViewAddressFieldKey"),
                              controller: _toController,
                              readOnly: false,
                              autocorrect: false,
                              enableSuggestions: false,
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]{34}")),
                              // ],
                              toolbarOptions: const ToolbarOptions(
                                copy: false,
                                cut: false,
                                paste: true,
                                selectAll: false,
                              ),
                              focusNode: _toFocusNode,
                              style: STextStyles.field(context),
                              onChanged: (value) {
                                model.recipientAddress = _toController.text;
                                setState(() {
                                  enableNext = _toController.text.isNotEmpty &&
                                      (_refundController.text.isNotEmpty ||
                                          !supportsRefund);
                                });
                              },
                              decoration: standardInputDecoration(
                                "Enter the ${model.to.ticker.toUpperCase()} payout address",
                                _toFocusNode,
                                context,
                              ).copyWith(
                                contentPadding: const EdgeInsets.only(
                                  left: 16,
                                  top: 6,
                                  bottom: 8,
                                  right: 5,
                                ),
                                suffixIcon: Padding(
                                  padding: _toController.text.isEmpty
                                      ? const EdgeInsets.only(right: 8)
                                      : const EdgeInsets.only(right: 0),
                                  child: UnconstrainedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _toController.text.isNotEmpty
                                            ? TextFieldIconButton(
                                                key: const Key(
                                                  "sendViewClearAddressFieldButtonKey",
                                                ),
                                                onTap: () {
                                                  _toController.text = "";
                                                  model.recipientAddress =
                                                      _toController.text;

                                                  setState(() {
                                                    enableNext = _toController
                                                            .text.isNotEmpty &&
                                                        (_refundController.text
                                                                .isNotEmpty ||
                                                            !supportsRefund);
                                                  });
                                                },
                                                child: const XIcon(),
                                              )
                                            : TextFieldIconButton(
                                                key: const Key(
                                                    "sendViewPasteAddressFieldButtonKey"),
                                                onTap: () async {
                                                  final ClipboardData? data =
                                                      await clipboard.getData(
                                                          Clipboard.kTextPlain);
                                                  if (data?.text != null &&
                                                      data!.text!.isNotEmpty) {
                                                    final content =
                                                        data.text!.trim();

                                                    _toController.text =
                                                        content;
                                                    model.recipientAddress =
                                                        _toController.text;

                                                    setState(() {
                                                      enableNext = _toController
                                                              .text
                                                              .isNotEmpty &&
                                                          (_refundController
                                                                  .text
                                                                  .isNotEmpty ||
                                                              !supportsRefund);
                                                    });
                                                  }
                                                },
                                                child:
                                                    _toController.text.isEmpty
                                                        ? const ClipboardIcon()
                                                        : const XIcon(),
                                              ),
                                        if (_toController.text.isEmpty)
                                          TextFieldIconButton(
                                            key: const Key(
                                              "sendViewScanQrButtonKey",
                                            ),
                                            onTap: () async {
                                              try {
                                                final qrResult =
                                                    await scanner.scan();

                                                final results =
                                                    AddressUtils.parseUri(
                                                        qrResult.rawContent);
                                                if (results.isNotEmpty) {
                                                  // auto fill address
                                                  _toController.text =
                                                      results["address"] ?? "";
                                                  model.recipientAddress =
                                                      _toController.text;

                                                  setState(() {
                                                    enableNext = _toController
                                                            .text.isNotEmpty &&
                                                        (_refundController.text
                                                                .isNotEmpty ||
                                                            !supportsRefund);
                                                  });
                                                } else {
                                                  _toController.text =
                                                      qrResult.rawContent;
                                                  model.recipientAddress =
                                                      _toController.text;

                                                  setState(() {
                                                    enableNext = _toController
                                                            .text.isNotEmpty &&
                                                        (_refundController.text
                                                                .isNotEmpty ||
                                                            !supportsRefund);
                                                  });
                                                }
                                              } on PlatformException catch (e, s) {
                                                Logging.instance.log(
                                                  "Failed to get camera permissions while trying to scan qr code in SendView: $e\n$s",
                                                  level: LogLevel.Warning,
                                                );
                                              }
                                            },
                                            child: const QrCodeIcon(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          RoundedWhiteContainer(
                            child: Text(
                              "Your ${model.to.ticker.toUpperCase()} will be sent to this wallet.",
                              style: STextStyles.label(context),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          // IF EPIC TO BTC
                          // if (supportsRefund)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Refund Wallet (REQUIRED)",
                                style: STextStyles.smallMed12(context),
                              ),
                            ],
                          ),
                          // if (supportsRefund)
                          const SizedBox(
                            height: 4,
                          ),
                          // if (supportsRefund)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Constants.size.circularBorderRadius,
                            ),
                            child: TextField(
                              key: const Key(
                                  "refundExchangeStep2ViewAddressFieldKey"),
                              controller: _refundController,
                              readOnly: false,
                              autocorrect: false,
                              enableSuggestions: false,
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]{34}")),
                              // ],
                              toolbarOptions: const ToolbarOptions(
                                copy: false,
                                cut: false,
                                paste: true,
                                selectAll: false,
                              ),
                              focusNode: _refundFocusNode,
                              style: STextStyles.field(context),
                              onChanged: (value) {
                                model.refundAddress = _refundController.text;
                                setState(() {
                                  enableNext = _toController.text.isNotEmpty &&
                                      _refundController.text.isNotEmpty;
                                });
                              },
                              decoration: standardInputDecoration(
                                "Enter ${model.from.ticker.toUpperCase()} refund address",
                                _refundFocusNode,
                                context,
                              ).copyWith(
                                contentPadding: const EdgeInsets.only(
                                  left: 16,
                                  top: 6,
                                  bottom: 8,
                                  right: 5,
                                ),
                                suffixIcon: Padding(
                                  padding: _refundController.text.isEmpty
                                      ? const EdgeInsets.only(right: 16)
                                      : const EdgeInsets.only(right: 0),
                                  child: UnconstrainedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _refundController.text.isNotEmpty
                                            ? TextFieldIconButton(
                                                key: const Key(
                                                  "sendViewClearAddressFieldButtonKey",
                                                ),
                                                onTap: () {
                                                  _refundController.text = "";
                                                  model.refundAddress =
                                                      _refundController.text;

                                                  setState(() {
                                                    enableNext = _toController
                                                            .text.isNotEmpty &&
                                                        _refundController
                                                            .text.isNotEmpty;
                                                  });
                                                },
                                                child: const XIcon(),
                                              )
                                            : TextFieldIconButton(
                                                key: const Key(
                                                  "sendViewPasteAddressFieldButtonKey",
                                                ),
                                                onTap: () async {
                                                  final ClipboardData? data =
                                                      await clipboard.getData(
                                                          Clipboard.kTextPlain);
                                                  if (data?.text != null &&
                                                      data!.text!.isNotEmpty) {
                                                    final content =
                                                        data.text!.trim();

                                                    _refundController.text =
                                                        content;
                                                    model.refundAddress =
                                                        _refundController.text;

                                                    setState(() {
                                                      enableNext = _toController
                                                              .text
                                                              .isNotEmpty &&
                                                          _refundController
                                                              .text.isNotEmpty;
                                                    });
                                                  }
                                                },
                                                child: _refundController
                                                        .text.isEmpty
                                                    ? const ClipboardIcon()
                                                    : const XIcon(),
                                              ),
                                        if (_refundController.text.isEmpty)
                                          TextFieldIconButton(
                                            key: const Key(
                                              "sendViewScanQrButtonKey",
                                            ),
                                            onTap: () async {
                                              try {
                                                final qrResult =
                                                    await scanner.scan();

                                                final results =
                                                    AddressUtils.parseUri(
                                                        qrResult.rawContent);
                                                if (results.isNotEmpty) {
                                                  // auto fill address
                                                  _refundController.text =
                                                      results["address"] ?? "";
                                                  model.refundAddress =
                                                      _refundController.text;

                                                  setState(() {
                                                    enableNext = _toController
                                                            .text.isNotEmpty &&
                                                        _refundController
                                                            .text.isNotEmpty;
                                                  });
                                                } else {
                                                  _refundController.text =
                                                      qrResult.rawContent;
                                                  model.refundAddress =
                                                      _refundController.text;

                                                  setState(() {
                                                    enableNext = _toController
                                                            .text.isNotEmpty &&
                                                        _refundController
                                                            .text.isNotEmpty;
                                                  });
                                                }
                                              } on PlatformException catch (e, s) {
                                                Logging.instance.log(
                                                  "Failed to get camera permissions while trying to scan qr code in SendView: $e\n$s",
                                                  level: LogLevel.Warning,
                                                );
                                              }
                                            },
                                            child: const QrCodeIcon(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // if (supportsRefund)
                          const SizedBox(
                            height: 6,
                          ),
                          // if (supportsRefund)
                          Text(
                            "In case something goes wrong during the exchange, we might need a refund address so we can return your coins back to you.",
                            style: STextStyles.label(context),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  label: "Next",
                                  enabled: true,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      Step3View.routeName,
                                      // arguments: model,
                                    );
                                  },
                                ),
                              ),
                            ],
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
