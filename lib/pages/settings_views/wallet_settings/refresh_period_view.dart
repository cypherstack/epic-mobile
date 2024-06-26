import 'dart:async';

import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/icon_widgets/x_icon.dart';
import 'package:epicpay/widgets/textfield_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshPeriodView extends ConsumerStatefulWidget {
  const RefreshPeriodView({
    Key? key,
    // this.secureStore = const SecureStorageWrapper(
    //   FlutterSecureStorage(),
    // ),
  }) : super(key: key);

  static const String routeName = "/RefreshPeriod";

  // final FlutterSecureStorageInterface secureStore;

  @override
  ConsumerState<RefreshPeriodView> createState() => _RefreshPeriodViewState();
}

class _RefreshPeriodViewState extends ConsumerState<RefreshPeriodView>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  late bool saveEnabled;

  late final TextEditingController _refreshPeriodController;

  final _refreshPeriodFocusNode = FocusNode();

  @override
  void initState() {
    _refreshPeriodController = TextEditingController();
    _refreshPeriodController.text =
        "${ref.read(prefsChangeNotifierProvider).refreshPeriod ?? 60}";

    ref.refresh(refreshPeriodFormDataProvider);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurveTween(
      curve: Curves.bounceInOut,
    ).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          title: Text(
            "Refresh period",
            style: STextStyles.titleH4(context),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(
          //       top: 10,
          //       bottom: 10,
          //       right: 16,
          //     ),
          //     child: AspectRatio(
          //       aspectRatio: 1,
          //       child: AppBarIconButton(
          //         key: const Key("addressBookAddNewContactViewButton"),
          //         size: 36,
          //         shadows: const [],
          //         color: Theme.of(context).extension<StackColors>()!.background,
          //         icon: SvgPicture.asset(
          //           Assets.svg.ellipsis,
          //         ),
          //         onPressed: () {
          //           print('TODO implement 1');
          //         },
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight - 8),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "REFRESH PERIOD (IN SECONDS)",
                            textAlign: TextAlign.left,
                            style: STextStyles.overLineBold(context),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextField(
                            textAlignVertical: TextAlignVertical.center,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: _refreshPeriodController,
                            // readOnly: widget.readOnly,
                            // enabled: enableField(_refreshPeriodController),\
                            focusNode: _refreshPeriodFocusNode,
                            style: STextStyles.body(context),
                            decoration: InputDecoration(
                              hintText: "Refresh period (in seconds)",
                              fillColor: _refreshPeriodFocusNode.hasFocus
                                  ? Theme.of(context)
                                      .extension<StackColors>()!
                                      .textFieldActiveBG
                                  : Theme.of(context)
                                      .extension<StackColors>()!
                                      .textFieldDefaultBG,
                              isCollapsed: true,
                              hintStyle: STextStyles.body(context).copyWith(
                                color: Theme.of(context)
                                    .extension<StackColors>()!
                                    .textMedium,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: UnconstrainedBox(
                                  child: Row(
                                    children: [
                                      if (/*!widget.readOnly &&*/
                                      _refreshPeriodController.text.isNotEmpty)
                                        TextFieldIconButton(
                                          child: const XIcon(),
                                          onTap: () async {
                                            _refreshPeriodController.text = "";
                                            // _updateState();
                                          },
                                        ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              // _updateState();
                              setState(() {});
                            },
                            inputFormatters: [
                              // Thank you Julian
                              TextInputFormatter.withFunction((oldValue,
                                      newValue) =>
                                  RegExp(r'^([0-9]*)$').hasMatch(newValue.text)
                                      ? newValue
                                      : oldValue),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              // Expanded(
                              //   child: SecondaryButton(
                              //     label: "TEST",
                              //     // enabled: editable,
                              //     desktopMed: true,
                              //     onPressed: () {
                              //       print(222);
                              //     },
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 16,
                              // ),
                              Expanded(
                                child: PrimaryButton(
                                  label: "SAVE",
                                  // enabled: editable,
                                  onPressed: () {
                                    Logging.instance.log(
                                        'Update refresh button pushed',
                                        level: LogLevel.Info);
                                    try {
                                      int? refreshPeriod = int.parse(
                                          _refreshPeriodController.text);
                                      if (refreshPeriod !=
                                          ref
                                              .read(prefsChangeNotifierProvider)
                                              .refreshPeriod) {
                                        Logging.instance.log(
                                            'Attempting to update refresh period',
                                            level: LogLevel.Info);
                                        ref
                                            .read(prefsChangeNotifierProvider)
                                            .refreshPeriod = refreshPeriod;
                                        Logging.instance.log(
                                            "Updated refresh period to $refreshPeriod",
                                            level: LogLevel.Info);
                                      } else {
                                        Logging.instance.log(
                                            "No need to update refresh period; already $refreshPeriod",
                                            level: LogLevel.Info);
                                      }
                                      Navigator.of(context).pop();
                                    } catch (e, s) {
                                      Logging.instance.log(
                                          "Error updating refresh period: $e, $s",
                                          level: LogLevel.Error);
                                    }
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class RefreshPeriodFormData {
  int? refreshPeriod;

  @override
  String toString() {
    return "{ refreshPeriod: $refreshPeriod }";
  }
}

final refreshPeriodFormDataProvider =
    Provider<RefreshPeriodFormData>((_) => RefreshPeriodFormData());

class RefreshPeriodForm extends ConsumerStatefulWidget {
  const RefreshPeriodForm({
    Key? key,
    required this.readOnly,
    this.onChanged,
  }) : super(key: key);

  final bool readOnly;
  final void Function(bool canSave, bool canTestConnection)? onChanged;

  @override
  ConsumerState<RefreshPeriodForm> createState() => _RefreshPeriodFormState();
}

class _RefreshPeriodFormState extends ConsumerState<RefreshPeriodForm> {
  late final TextEditingController _refreshPeriodController;

  final _refreshPeriodFocusNode = FocusNode();

  bool enableField(TextEditingController controller) {
    bool enable = true;
    if (widget.readOnly) {
      enable = controller.text.isNotEmpty;
    }
    return enable;
  }

  void _updateState() {
    ref.read(refreshPeriodFormDataProvider).refreshPeriod =
        int.parse(_refreshPeriodController.text);
    setState(() {});
  }

  @override
  void initState() {
    _refreshPeriodController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _refreshPeriodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          textAlignVertical: TextAlignVertical.center,
          autocorrect: false,
          enableSuggestions: false,
          key: const Key("refreshPeriodFieldKey"),
          readOnly: widget.readOnly,
          enabled: enableField(_refreshPeriodController),
          controller: _refreshPeriodController,
          focusNode: _refreshPeriodFocusNode,
          style: STextStyles.body(context),
          decoration: InputDecoration(
            hintText: "Server name",
            fillColor: _refreshPeriodFocusNode.hasFocus
                ? Theme.of(context).extension<StackColors>()!.textFieldActiveBG
                : Theme.of(context)
                    .extension<StackColors>()!
                    .textFieldDefaultBG,
            isCollapsed: true,
            hintStyle: STextStyles.body(context).copyWith(
              color: Theme.of(context).extension<StackColors>()!.textMedium,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: UnconstrainedBox(
                child: Row(
                  children: [
                    if (_refreshPeriodController.text.isNotEmpty)
                      TextFieldIconButton(
                        child: const XIcon(),
                        onTap: () async {
                          _refreshPeriodController.text = "";
                          _updateState();
                        },
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          onChanged: (newValue) {
            _updateState();
            setState(() {});
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
