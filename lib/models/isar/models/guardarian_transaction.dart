import 'package:decimal/decimal.dart';
import 'package:epicpay/services/guardarian/enums.dart';
import 'package:isar/isar.dart';

part 'guardarian_transaction.g.dart';

@Collection(accessor: "guardarianTransactions")
class GuardarianTransaction {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  final int transactionId;

  final String statusString;
  @ignore
  EGTransactionStatus get status =>
      EGTransactionStatus.fromString(statusString);

  final String email;
  final String statusDetails;
  final String fromCurrency;
  final String initialFromCurrency;
  final String fromNetwork;
  final String fromCurrencyWithNetwork;

  final String fromAmountString;
  @ignore
  Decimal get fromAmount => Decimal.parse(fromAmountString);

  final String depositType;
  final String payoutType;

  final String expectedFromAmountString;
  @ignore
  Decimal get expectedFromAmount => Decimal.parse(expectedFromAmountString);

  final String initialExpectedFromAmountString;
  @ignore
  Decimal get initialExpectedFromAmount =>
      Decimal.parse(initialExpectedFromAmountString);

  final String toCurrency;
  final String toNetwork;
  final String toCurrencyWithNetwork;

  final String toAmountString;
  @ignore
  Decimal get toAmount => Decimal.parse(toAmountString);

  final String outputHash;

  final String expectedToAmountString;
  @ignore
  Decimal get expectedToAmount => Decimal.parse(expectedToAmountString);

  final String location;
  final String createdAt;
  final String updatedAt;
  final int partnerId;
  final String externalPartnerLinkId;

  final String fromAmountInEurString;
  @ignore
  Decimal get fromAmountInEur => Decimal.parse(fromAmountInEurString);

  final bool customerPayoutAddressChangeable;

  final String estimateBreakdownToAmountString;
  @ignore
  Decimal get estimateBreakdownToAmount =>
      Decimal.parse(estimateBreakdownToAmountString);

  final String estimateBreakdownFromAmountString;
  @ignore
  Decimal get estimateBreakdownFromAmount =>
      Decimal.parse(estimateBreakdownFromAmountString);

  final List<ServiceFeeEmbedded> estimateBreakdownServiceFees;
  final ConvertedAmountEmbedded estimateBreakdownConvertedAmount;

  final String estimateBreakdownEstimatedExchangeRateString;
  @ignore
  Decimal get estimateBreakdownEstimatedExchangeRate =>
      Decimal.parse(estimateBreakdownEstimatedExchangeRateString);

  final NetworkFeeEmbedded estimateBreakdownNetworkFee;
  final PartnerFeeEmbedded estimateBreakdownPartnerFee;
  final String address;
  final String extraId;

  final String depositPaymentCategoryString;
  @ignore
  EGPaymentCategory get depositPaymentCategory =>
      EGPaymentCategory.fromString(depositPaymentCategoryString);

  final String payoutPaymentCategoryString;
  @ignore
  EGPaymentCategory get payoutPaymentCategory =>
      EGPaymentCategory.fromString(payoutPaymentCategoryString);

  final String redirectUrl;
  final String preauthToken;
  final bool skipChoosePayoutAddress;
  final bool skipChoosePaymentCategory;

  @Deprecated(
      "Use GuardarianTransaction.construct instead. This is for Isar compat only.")
  GuardarianTransaction({
    required this.transactionId,
    required this.statusString,
    required this.email,
    required this.statusDetails,
    required this.fromCurrency,
    required this.initialFromCurrency,
    required this.fromNetwork,
    required this.fromCurrencyWithNetwork,
    required this.fromAmountString,
    required this.depositType,
    required this.payoutType,
    required this.expectedFromAmountString,
    required this.initialExpectedFromAmountString,
    required this.toCurrency,
    required this.toNetwork,
    required this.toCurrencyWithNetwork,
    required this.toAmountString,
    required this.outputHash,
    required this.expectedToAmountString,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.partnerId,
    required this.externalPartnerLinkId,
    required this.fromAmountInEurString,
    required this.customerPayoutAddressChangeable,
    required this.estimateBreakdownToAmountString,
    required this.estimateBreakdownFromAmountString,
    required this.estimateBreakdownServiceFees,
    required this.estimateBreakdownConvertedAmount,
    required this.estimateBreakdownEstimatedExchangeRateString,
    required this.estimateBreakdownNetworkFee,
    required this.estimateBreakdownPartnerFee,
    required this.address,
    required this.extraId,
    required this.depositPaymentCategoryString,
    required this.payoutPaymentCategoryString,
    required this.redirectUrl,
    required this.preauthToken,
    required this.skipChoosePayoutAddress,
    required this.skipChoosePaymentCategory,
  });

  GuardarianTransaction.construct({
    required this.transactionId,
    required EGTransactionStatus status,
    required this.email,
    required this.statusDetails,
    required this.fromCurrency,
    required this.initialFromCurrency,
    required this.fromNetwork,
    required this.fromCurrencyWithNetwork,
    required Decimal fromAmount,
    required this.depositType,
    required this.payoutType,
    required Decimal expectedFromAmount,
    required Decimal initialExpectedFromAmount,
    required this.toCurrency,
    required this.toNetwork,
    required this.toCurrencyWithNetwork,
    required Decimal toAmount,
    required this.outputHash,
    required Decimal expectedToAmount,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.partnerId,
    required this.externalPartnerLinkId,
    required Decimal fromAmountInEur,
    required this.customerPayoutAddressChangeable,
    required Decimal estimateBreakdownToAmount,
    required Decimal estimateBreakdownFromAmount,
    required this.estimateBreakdownServiceFees,
    required this.estimateBreakdownConvertedAmount,
    required Decimal estimateBreakdownEstimatedExchangeRate,
    required this.estimateBreakdownNetworkFee,
    required this.estimateBreakdownPartnerFee,
    required this.address,
    required this.extraId,
    required EGPaymentCategory depositPaymentCategory,
    required EGPaymentCategory payoutPaymentCategory,
    required this.redirectUrl,
    required this.preauthToken,
    required this.skipChoosePayoutAddress,
    required this.skipChoosePaymentCategory,
  })  : statusString = status.value,
        fromAmountString = fromAmount.toString(),
        expectedFromAmountString = expectedFromAmount.toString(),
        initialExpectedFromAmountString = initialExpectedFromAmount.toString(),
        toAmountString = toAmount.toString(),
        expectedToAmountString = expectedToAmount.toString(),
        fromAmountInEurString = fromAmountInEur.toString(),
        estimateBreakdownToAmountString = estimateBreakdownToAmount.toString(),
        estimateBreakdownFromAmountString =
            estimateBreakdownFromAmount.toString(),
        estimateBreakdownEstimatedExchangeRateString =
            estimateBreakdownEstimatedExchangeRate.toString(),
        depositPaymentCategoryString = depositPaymentCategory.name,
        payoutPaymentCategoryString = payoutPaymentCategory.name;
}

@Embedded()
class ServiceFeeEmbedded {
  late final String name;
  late final String amountString;
  late final String currency;

  @ignore
  Decimal get amountDecimal => Decimal.parse(amountString);

  @Deprecated(
      "Use ServiceFeeEmbedded.construct instead. This is for Isar compat only.")
  ServiceFeeEmbedded();

  ServiceFeeEmbedded.construct({
    required this.name,
    required Decimal amount,
    required this.currency,
  }) : amountString = amount.toString();
}

@Embedded()
class PartnerFeeEmbedded {
  late final String amountString;
  late final String currency;
  late final String percentage;

  @ignore
  Decimal get amount => Decimal.parse(amountString);

  @Deprecated(
      "Use PartnerFeeEmbedded.construct instead. This is for Isar compat only.")
  PartnerFeeEmbedded();

  PartnerFeeEmbedded.construct({
    required this.currency,
    required Decimal amount,
    required this.percentage,
  }) : amountString = amount.toString();
}

@Embedded()
class NetworkFeeEmbedded {
  late final String amountString;
  late final String currency;

  @ignore
  Decimal get amount => Decimal.parse(amountString);

  @Deprecated(
      "Use NetworkFeeEmbedded.construct instead. This is for Isar compat only.")
  NetworkFeeEmbedded();

  NetworkFeeEmbedded.construct({
    required this.currency,
    required Decimal amount,
  }) : amountString = amount.toString();
}

@Embedded()
class ConvertedAmountEmbedded {
  late final String amountString;
  late final String currency;

  @ignore
  Decimal get amount => Decimal.parse(amountString);

  @Deprecated(
      "Use ConvertedAmountEmbedded.construct instead. This is for Isar compat only.")
  ConvertedAmountEmbedded();

  ConvertedAmountEmbedded.construct({
    required this.currency,
    required Decimal amount,
  }) : amountString = amount.toString();
}
