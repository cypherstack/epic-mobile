import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:decimal/decimal.dart';
import 'package:epicpay/pages/buy_view/personal_info_dialog.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/services/geo_service.dart';
import 'package:epicpay/services/guardarian/enums.dart';
import 'package:epicpay/services/guardarian/guardarian_api.dart';
import 'package:epicpay/services/guardarian/response_models/g_currency.dart';
import 'package:epicpay/services/guardarian/response_models/g_estimate.dart';
import 'package:epicpay/services/guardarian/response_models/g_transaction.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/list_selection_dialog.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:epicpay/widgets/step_progress_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyWithFiatStep4 extends ConsumerStatefulWidget {
  const BuyWithFiatStep4({
    super.key,
    required this.option,
    required this.epic,
    required this.estimate,
    required this.sendAmount,
  });

  final GCurrency option;
  final GCurrency epic;
  final GEstimate estimate;
  final Decimal sendAmount;

  static const routeName = "/buyWithFiatStep4";

  @override
  ConsumerState<BuyWithFiatStep4> createState() => _BuyWithFiatStep4State();
}

class _BuyWithFiatStep4State extends ConsumerState<BuyWithFiatStep4> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameFirstController;
  late final TextEditingController nameLastController;

  late final TextEditingController dobController;
  late final TextEditingController genderController;

  late final TextEditingController aptNumberController;
  late final TextEditingController streetAddressController;
  late final TextEditingController cityController;
  late final TextEditingController countryController;

  late final TextEditingController regionController;
  late final TextEditingController codeController;

  bool _valid = false;
  DateTime? _dob;
  csc.Country? _country;
  csc.State? _state;

  Future<GTransaction> _createBuy() async {
    final address = await ref.read(walletProvider)!.currentReceivingAddress;

    final tx = await GuardarianAPI.postTransaction(
      fromAmount: widget.sendAmount.toDouble(),
      fromCurrency: widget.estimate.fromCurrency,
      fromNetwork: widget.estimate.fromNetwork,
      toCurrency: widget.estimate.toCurrency,
      toNetwork: widget.estimate.toNetwork,
      skipChoosePaymentCategory: false,
      paymentCategory: EGPaymentCategory.VISA_MC,
      skipChoosePayoutAddress: false,
      customerCountry: _country!.isoCode,
      customer: Customer(
        billingInfo: CustomerBillingInfo(
          countryAlpha2: _country!.isoCode,
          usRegionAlpha2: _state!.isoCode,
          region: _state!.name,
          city: cityController.text,
          streetAddress: streetAddressController.text,
          aptNumber: aptNumberController.text,
          postIndex: codeController.text,
          firstName: nameFirstController.text,
          lastName: nameLastController.text,
          dateOfBirthday: dobController.text,
          gender: genderController.text.substring(0, 1).toUpperCase(),
        ),
      ),
    );

    if (tx.exception != null) {
      throw tx.exception!;
    }

    return tx.value!;
  }

  bool _onNextPressedLock = false;
  void _onNextPressed() async {
    if (_onNextPressedLock) {
      return;
    }
    _onNextPressedLock = true;

    try {
      Exception? ex;
      final result = await showLoading(
        whileFuture: _createBuy(),
        context: context,
        onException: (e) => ex = e,
      );

      if (ex != null) {
        if (mounted) {
          await Logging.uiLog(
            ex,
            title: "Guardarian API Error",
            context: context,
          );
          // await showDialog<void>(
          //   context: context,
          //   builder: (_) => EPErrorDialog(
          //     title: "Guardarian API Error",
          //     info: ex.toString(),
          //   ),
          // );
        }
        return;
      }

      if (mounted) {
        await Logging.uiLog(
          result,
          title: "Guardarian create transaction result",
          context: context,
        );
      }
    } finally {
      _onNextPressedLock = false;
    }
  }

  String? _notEmptyValidator(String? value) {
    if (value?.isNotEmpty == true && value!.trim().isNotEmpty) {
      return null;
    } else {
      return "Missing value";
    }
  }

  Widget get suffixIcon => Row(
        children: [
          SvgPicture.asset(
            Assets.svg.chevronDown,
            width: 12,
            color: Theme.of(context).extension<StackColors>()!.textMedium,
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );

  BoxConstraints get suffixConstraints => const BoxConstraints(
        maxHeight: 22,
        maxWidth: 24,
      );

  MaterialRoundedDatePickerStyle _buildDatePickerStyle() {
    return MaterialRoundedDatePickerStyle(
      backgroundPicker: Theme.of(context).extension<StackColors>()!.coal,
      // backgroundHeader: Theme.of(context).extension<StackColors>()!.textSubtitle2,
      paddingMonthHeader: const EdgeInsets.only(top: 11),
      colorArrowNext: Theme.of(context).extension<StackColors>()!.textGold,
      colorArrowPrevious: Theme.of(context).extension<StackColors>()!.textGold,
      textStyleButtonNegative: STextStyles.datePicker600(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.textMedium,
      ),
      textStyleButtonPositive: STextStyles.datePicker600(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.textGold,
      ),
      textStyleCurrentDayOnCalendar: STextStyles.datePicker400(context),
      textStyleDayHeader: STextStyles.datePicker600(context),
      textStyleDayOnCalendar: STextStyles.datePicker400(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.textLight,
      ),
      textStyleDayOnCalendarDisabled:
          STextStyles.datePicker400(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.textDark,
      ),
      textStyleDayOnCalendarSelected:
          STextStyles.datePicker400(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.coal,
      ),
      textStyleMonthYearHeader: STextStyles.datePicker600(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.textGold,
      ),
      textStyleYearButton: STextStyles.datePicker600(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.coal,
      ),
      backgroundHeader: Theme.of(context).extension<StackColors>()!.textGold,
      decorationDateSelected: BoxDecoration(
        color: Theme.of(context).extension<StackColors>()!.textGold,
        shape: BoxShape.circle,
      ),
    );
  }

  MaterialRoundedYearPickerStyle _buildYearPickerStyle() {
    return MaterialRoundedYearPickerStyle(
      backgroundPicker: Theme.of(context).extension<StackColors>()!.coal,
      textStyleYear: STextStyles.datePicker600(context).copyWith(
        color: Theme.of(context).extension<StackColors>()!.textMedium,
        fontSize: 16,
      ),
      textStyleYearSelected: STextStyles.datePicker600(context).copyWith(
        fontSize: 18,
      ),
    );
  }

  void _validate() {
    final valid = nameFirstController.text.isNotEmpty &&
        nameLastController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        streetAddressController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        regionController.text.isNotEmpty &&
        codeController.text.isNotEmpty;

    if (valid != _valid) {
      setState(() {
        _valid = valid;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    nameFirstController = TextEditingController();
    nameLastController = TextEditingController();
    dobController = TextEditingController();
    genderController = TextEditingController();
    aptNumberController = TextEditingController();
    streetAddressController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    regionController = TextEditingController();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    nameFirstController.dispose();
    nameLastController.dispose();
    dobController.dispose();
    genderController.dispose();
    aptNumberController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    countryController.dispose();
    regionController.dispose();
    codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final formStyle = STextStyles.w400_16(context).copyWith(
      color: Theme.of(context).extension<StackColors>()!.textMedium,
    );

    return Background(
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          appBar: AppBar(
            leading: AppBarIconButton(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF222227),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.svg.arrowLeft,
                    width: 24,
                    height: 24,
                    color:
                        Theme.of(context).extension<StackColors>()!.textMedium,
                  ),
                ),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            centerTitle: true,
            title: const StepProgressDots(
              activeCount: 4,
              totalCount: 4,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AppBarIconButton(
                    key: const Key("guardarianInfoButtonKey"),
                    size: 36,
                    shadows: const [],
                    color: const Color(0xFF222227),
                    icon: SvgPicture.asset(
                      Assets.svg.circleInfo,
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .topNavIconPrimary,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) => const PersonalInfoDialog(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      onChanged: () {
                        _validate();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: height < 600 ? 2 : 10),
                          Text(
                            "Personal information",
                            textAlign: TextAlign.center,
                            style: STextStyles.titleH3(context),
                          ),
                          SizedBox(height: height < 600 ? 8 : 20),
                          RoundedWhiteContainer(
                            child: Text(
                              "This information is required by our purchasing partner Guardarian.com.",
                              style: STextStyles.w400_12_18h(context),
                            ),
                          ),
                          SizedBox(height: height < 600 ? 10 : 32),
                          Text(
                            "ENTER YOUR NAME",
                            style: STextStyles.overLineBold(context),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          TextFormField(
                            style: formStyle,
                            controller: nameFirstController,
                            validator: _notEmptyValidator,
                            decoration: InputDecoration(
                              hintText: "First name",
                              hintStyle: formStyle,
                            ),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          TextFormField(
                            style: formStyle,
                            controller: nameLastController,
                            validator: _notEmptyValidator,
                            decoration: InputDecoration(
                              hintText: "Last name",
                              hintStyle: formStyle,
                            ),
                          ),
                          SizedBox(height: height < 600 ? 10 : 32),
                          Text(
                            "ENTER YOUR BIRTHDAY AND GENDER",
                            style: STextStyles.overLineBold(context),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          GestureDetector(
                            onTap: () async {
                              final color = Theme.of(context)
                                  .extension<StackColors>()!
                                  .accentColorDark;
                              final height = MediaQuery.of(context).size.height;
                              // check and hide keyboard
                              if (FocusScope.of(context).hasFocus) {
                                FocusScope.of(context).unfocus();
                                await Future<void>.delayed(
                                    const Duration(milliseconds: 125));
                              }
                              if (context.mounted) {
                                final date = await showRoundedDatePicker(
                                  context: context,
                                  height: height * 0.5,
                                  theme: ThemeData(
                                    primarySwatch: Util.createMaterialColor(
                                      color,
                                    ),
                                  ),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1890),
                                  lastDate: DateTime.now(),
                                  borderRadius:
                                      Constants.size.circularBorderRadius * 2,
                                  textPositiveButton: "SELECT",
                                  styleDatePicker: _buildDatePickerStyle(),
                                  styleYearPicker: _buildYearPickerStyle(),
                                );

                                if (date != null) {
                                  setState(() {
                                    _dob = date;
                                    dobController.text =
                                        "${date.day < 10 ? "0${date.day}" : date.day}"
                                        ".${date.month < 10 ? "0${date.month}" : date.month}"
                                        ".${date.year}";
                                  });
                                }
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: IgnorePointer(
                                child: TextFormField(
                                  enabled: false,
                                  style: formStyle,
                                  controller: dobController,
                                  validator: _notEmptyValidator,
                                  decoration: InputDecoration(
                                    hintText: "DD.MM.YYYY",
                                    hintStyle: formStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          GestureDetector(
                            onTap: () async {
                              final gender = await showDialog<String>(
                                context: context,
                                useSafeArea: false,
                                builder: (context) => ListSelectionDialog(
                                  title: "Select your gender",
                                  list: const ["Female", "Male", "Other"],
                                  displayName: (s) => s,
                                ),
                              );

                              if (mounted && gender != null) {
                                setState(() {
                                  genderController.text = gender;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: IgnorePointer(
                                child: TextFormField(
                                  enabled: false,
                                  style: formStyle,
                                  controller: genderController,
                                  validator: _notEmptyValidator,
                                  decoration: InputDecoration(
                                    hintText: "Select your gender",
                                    hintStyle: formStyle,
                                    suffixIcon: suffixIcon,
                                    suffixIconConstraints: suffixConstraints,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height < 600 ? 10 : 32),
                          Text(
                            "ENTER YOUR ADDRESS",
                            style: STextStyles.overLineBold(context),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          TextFormField(
                            style: formStyle,
                            controller: streetAddressController,
                            validator: _notEmptyValidator,
                            decoration: InputDecoration(
                              hintText: "Street address",
                              hintStyle: formStyle,
                            ),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          TextFormField(
                            style: formStyle,
                            controller: aptNumberController,
                            decoration: InputDecoration(
                              hintText: "Street address line 2",
                              hintStyle: formStyle,
                            ),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          TextFormField(
                            style: formStyle,
                            controller: cityController,
                            validator: _notEmptyValidator,
                            decoration: InputDecoration(
                              hintText: "City",
                              hintStyle: formStyle,
                            ),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          GestureDetector(
                            onTap: () async {
                              final country = await showDialog<csc.Country>(
                                context: context,
                                useSafeArea: false,
                                builder: (context) => ListSelectionDialog(
                                  title: "Select your country",
                                  list: GeoService.countries,
                                  displayName: (s) => s.name,
                                ),
                              );

                              if (context.mounted && country != null) {
                                if (_country != country) {
                                  _state = null;
                                  regionController.text = "";
                                }

                                setState(() {
                                  _country = country;
                                  countryController.text = country.name;
                                });
                                final matching = GeoService.guardarianCountries
                                    .where((e) =>
                                        e.codeIsoAlpha2 == country.isoCode);

                                if (matching.isNotEmpty &&
                                    !matching.first.supported) {
                                  await showDialog<void>(
                                    context: context,
                                    builder: (_) => EPErrorDialog(
                                      title: "Guardarian API Error",
                                      info:
                                          "Guardarian does not support ${matching.first.countryName} at this time.",
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: IgnorePointer(
                                child: TextFormField(
                                  enabled: false,
                                  style: formStyle,
                                  controller: countryController,
                                  validator: _notEmptyValidator,
                                  decoration: InputDecoration(
                                    hintText: "Country",
                                    hintStyle: formStyle,
                                    suffixIcon: suffixIcon,
                                    suffixIconConstraints: suffixConstraints,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height < 600 ? 7 : 16),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _country == null
                                      ? null
                                      : () async {
                                          final state =
                                              await showDialog<csc.State>(
                                            context: context,
                                            useSafeArea: false,
                                            builder: (context) =>
                                                ListSelectionDialog(
                                              title: "Select your state",
                                              list: GeoService.states
                                                  .where((e) =>
                                                      e.countryCode ==
                                                      _country!.isoCode)
                                                  .toList(growable: false),
                                              displayName: (s) => s.name,
                                            ),
                                          );

                                          if (mounted && state != null) {
                                            setState(() {
                                              _state = state;
                                              regionController.text =
                                                  state.name;
                                            });
                                          }
                                        },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: IgnorePointer(
                                      child: TextFormField(
                                        enabled: false,
                                        style: formStyle,
                                        controller: regionController,
                                        validator: _notEmptyValidator,
                                        decoration: InputDecoration(
                                          hintText: "State/Region",
                                          hintStyle: formStyle,
                                          suffixIcon: suffixIcon,
                                          suffixIconConstraints:
                                              suffixConstraints,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: height < 600 ? 7 : 16),
                              Expanded(
                                child: TextFormField(
                                  style: formStyle,
                                  controller: codeController,
                                  validator: _notEmptyValidator,
                                  decoration: InputDecoration(
                                    hintText: "Post code",
                                    hintStyle: formStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height < 600 ? 2 : 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: PrimaryButton(
                  label: "NEXT",
                  enabled: _valid &&
                      _state != null &&
                      _country != null &&
                      _dob != null,
                  onPressed: _valid &&
                          _state != null &&
                          _country != null &&
                          _dob != null
                      ? _onNextPressed
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
