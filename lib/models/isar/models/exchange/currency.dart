import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:isar/isar.dart';

part 'currency.g.dart';

@Collection(accessor: "currencies")
class Currency {
  Id? id;

  @Index()
  final String exchangeName;

  @Index(unique: true, replace: true, composite: [
    CompositeIndex("exchangeName"),
    CompositeIndex("name"),
    CompositeIndex("network"),
  ])
  final String ticker;

  final String network;
  final String name;
  final String image;
  final bool hasExternalId;
  final bool isFiat;
  final String? tokenContract;
  final bool buy;
  final bool sell;

  @enumerated
  final SupportedRateType rateType;

  @ignore
  bool get supportsFixedRate =>
      rateType == SupportedRateType.fixed || rateType == SupportedRateType.both;

  @ignore
  bool get supportsEstimatedRate =>
      rateType == SupportedRateType.estimated ||
      rateType == SupportedRateType.both;

  Currency({
    required this.exchangeName,
    required this.ticker,
    required this.name,
    required this.image,
    required this.hasExternalId,
    required this.isFiat,
    required this.network,
    this.tokenContract,
    required this.buy,
    required this.sell,
    required this.rateType,
  });

  Currency.fromJson(Map<String, dynamic> json, this.exchangeName)
      : ticker = json['ticker'] as String,
        name = json['name'] as String,
        image = json['image'] as String,
        hasExternalId = json['hasExternalId'] as bool,
        isFiat = json['isFiat'] as bool,
        rateType = (json["supportsFixedRate"] as bool)
            ? SupportedRateType.both
            : SupportedRateType.estimated,
        network = json['network'] as String,
        tokenContract = json['tokenContract'] as String?,
        buy = json['buy'] as bool,
        sell = json['sell'] as bool;

  Currency copyWith({
    String? ticker,
    String? name,
    String? image,
    bool? hasExternalId,
    bool? isFiat,
    SupportedRateType? rateType,
    String? network,
    String? tokenContract,
    bool? buy,
    bool? sell,
  }) {
    return Currency(
      exchangeName: exchangeName,
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      image: image ?? this.image,
      hasExternalId: hasExternalId ?? this.hasExternalId,
      isFiat: isFiat ?? this.isFiat,
      rateType: rateType ?? this.rateType,
      network: network ?? this.network,
      tokenContract: tokenContract ?? this.tokenContract,
      buy: buy ?? this.buy,
      sell: sell ?? this.sell,
    );
  }

  @override
  String toString() {
    return 'Currency('
        'ticker: $ticker, '
        'name: $name, '
        'image: $image, '
        'hasExternalId: $hasExternalId, '
        'isFiat: $isFiat, '
        'supportsFixedRate: $rateType, '
        'network: $network, '
        'tokenContract: $tokenContract, '
        'buy: $buy, '
        'sell: $sell)';
  }
}
