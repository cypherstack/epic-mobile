// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCurrencyCollection on Isar {
  IsarCollection<Currency> get currencies => this.collection();
}

const CurrencySchema = CollectionSchema(
  name: r'Currency',
  id: 8290149502090171821,
  properties: {
    r'buy': PropertySchema(
      id: 0,
      name: r'buy',
      type: IsarType.bool,
    ),
    r'exchangeName': PropertySchema(
      id: 1,
      name: r'exchangeName',
      type: IsarType.string,
    ),
    r'hasExternalId': PropertySchema(
      id: 2,
      name: r'hasExternalId',
      type: IsarType.bool,
    ),
    r'image': PropertySchema(
      id: 3,
      name: r'image',
      type: IsarType.string,
    ),
    r'isFiat': PropertySchema(
      id: 4,
      name: r'isFiat',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'network': PropertySchema(
      id: 6,
      name: r'network',
      type: IsarType.string,
    ),
    r'rateType': PropertySchema(
      id: 7,
      name: r'rateType',
      type: IsarType.byte,
      enumMap: _CurrencyrateTypeEnumValueMap,
    ),
    r'sell': PropertySchema(
      id: 8,
      name: r'sell',
      type: IsarType.bool,
    ),
    r'ticker': PropertySchema(
      id: 9,
      name: r'ticker',
      type: IsarType.string,
    ),
    r'tokenContract': PropertySchema(
      id: 10,
      name: r'tokenContract',
      type: IsarType.string,
    )
  },
  estimateSize: _currencyEstimateSize,
  serialize: _currencySerialize,
  deserialize: _currencyDeserialize,
  deserializeProp: _currencyDeserializeProp,
  idName: r'id',
  indexes: {
    r'exchangeName': IndexSchema(
      id: 3599278165711581955,
      name: r'exchangeName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'exchangeName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'ticker_exchangeName_network': IndexSchema(
      id: 3239534738008339353,
      name: r'ticker_exchangeName_network',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'ticker',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'exchangeName',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'network',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _currencyGetId,
  getLinks: _currencyGetLinks,
  attach: _currencyAttach,
  version: '3.0.5',
);

int _currencyEstimateSize(
  Currency object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.exchangeName.length * 3;
  bytesCount += 3 + object.image.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.network.length * 3;
  bytesCount += 3 + object.ticker.length * 3;
  {
    final value = object.tokenContract;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _currencySerialize(
  Currency object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.buy);
  writer.writeString(offsets[1], object.exchangeName);
  writer.writeBool(offsets[2], object.hasExternalId);
  writer.writeString(offsets[3], object.image);
  writer.writeBool(offsets[4], object.isFiat);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.network);
  writer.writeByte(offsets[7], object.rateType.index);
  writer.writeBool(offsets[8], object.sell);
  writer.writeString(offsets[9], object.ticker);
  writer.writeString(offsets[10], object.tokenContract);
}

Currency _currencyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Currency(
    buy: reader.readBool(offsets[0]),
    exchangeName: reader.readString(offsets[1]),
    hasExternalId: reader.readBool(offsets[2]),
    image: reader.readString(offsets[3]),
    isFiat: reader.readBool(offsets[4]),
    name: reader.readString(offsets[5]),
    network: reader.readString(offsets[6]),
    rateType:
        _CurrencyrateTypeValueEnumMap[reader.readByteOrNull(offsets[7])] ??
            SupportedRateType.fixed,
    sell: reader.readBool(offsets[8]),
    ticker: reader.readString(offsets[9]),
    tokenContract: reader.readStringOrNull(offsets[10]),
  );
  object.id = id;
  return object;
}

P _currencyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (_CurrencyrateTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          SupportedRateType.fixed) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CurrencyrateTypeEnumValueMap = {
  'fixed': 0,
  'estimated': 1,
  'both': 2,
};
const _CurrencyrateTypeValueEnumMap = {
  0: SupportedRateType.fixed,
  1: SupportedRateType.estimated,
  2: SupportedRateType.both,
};

Id _currencyGetId(Currency object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _currencyGetLinks(Currency object) {
  return [];
}

void _currencyAttach(IsarCollection<dynamic> col, Id id, Currency object) {
  object.id = id;
}

extension CurrencyByIndex on IsarCollection<Currency> {
  Future<Currency?> getByTickerExchangeNameNetwork(
      String ticker, String exchangeName, String network) {
    return getByIndex(
        r'ticker_exchangeName_network', [ticker, exchangeName, network]);
  }

  Currency? getByTickerExchangeNameNetworkSync(
      String ticker, String exchangeName, String network) {
    return getByIndexSync(
        r'ticker_exchangeName_network', [ticker, exchangeName, network]);
  }

  Future<bool> deleteByTickerExchangeNameNetwork(
      String ticker, String exchangeName, String network) {
    return deleteByIndex(
        r'ticker_exchangeName_network', [ticker, exchangeName, network]);
  }

  bool deleteByTickerExchangeNameNetworkSync(
      String ticker, String exchangeName, String network) {
    return deleteByIndexSync(
        r'ticker_exchangeName_network', [ticker, exchangeName, network]);
  }

  Future<List<Currency?>> getAllByTickerExchangeNameNetwork(
      List<String> tickerValues,
      List<String> exchangeNameValues,
      List<String> networkValues) {
    final len = tickerValues.length;
    assert(exchangeNameValues.length == len && networkValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tickerValues[i], exchangeNameValues[i], networkValues[i]]);
    }

    return getAllByIndex(r'ticker_exchangeName_network', values);
  }

  List<Currency?> getAllByTickerExchangeNameNetworkSync(
      List<String> tickerValues,
      List<String> exchangeNameValues,
      List<String> networkValues) {
    final len = tickerValues.length;
    assert(exchangeNameValues.length == len && networkValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tickerValues[i], exchangeNameValues[i], networkValues[i]]);
    }

    return getAllByIndexSync(r'ticker_exchangeName_network', values);
  }

  Future<int> deleteAllByTickerExchangeNameNetwork(List<String> tickerValues,
      List<String> exchangeNameValues, List<String> networkValues) {
    final len = tickerValues.length;
    assert(exchangeNameValues.length == len && networkValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tickerValues[i], exchangeNameValues[i], networkValues[i]]);
    }

    return deleteAllByIndex(r'ticker_exchangeName_network', values);
  }

  int deleteAllByTickerExchangeNameNetworkSync(List<String> tickerValues,
      List<String> exchangeNameValues, List<String> networkValues) {
    final len = tickerValues.length;
    assert(exchangeNameValues.length == len && networkValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tickerValues[i], exchangeNameValues[i], networkValues[i]]);
    }

    return deleteAllByIndexSync(r'ticker_exchangeName_network', values);
  }

  Future<Id> putByTickerExchangeNameNetwork(Currency object) {
    return putByIndex(r'ticker_exchangeName_network', object);
  }

  Id putByTickerExchangeNameNetworkSync(Currency object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'ticker_exchangeName_network', object,
        saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTickerExchangeNameNetwork(List<Currency> objects) {
    return putAllByIndex(r'ticker_exchangeName_network', objects);
  }

  List<Id> putAllByTickerExchangeNameNetworkSync(List<Currency> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'ticker_exchangeName_network', objects,
        saveLinks: saveLinks);
  }
}

extension CurrencyQueryWhereSort on QueryBuilder<Currency, Currency, QWhere> {
  QueryBuilder<Currency, Currency, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CurrencyQueryWhere on QueryBuilder<Currency, Currency, QWhereClause> {
  QueryBuilder<Currency, Currency, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause> exchangeNameEqualTo(
      String exchangeName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'exchangeName',
        value: [exchangeName],
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause> exchangeNameNotEqualTo(
      String exchangeName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeName',
              lower: [],
              upper: [exchangeName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeName',
              lower: [exchangeName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeName',
              lower: [exchangeName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeName',
              lower: [],
              upper: [exchangeName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause>
      tickerEqualToAnyExchangeNameNetwork(String ticker) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ticker_exchangeName_network',
        value: [ticker],
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause>
      tickerNotEqualToAnyExchangeNameNetwork(String ticker) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [],
              upper: [ticker],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [],
              upper: [ticker],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause>
      tickerExchangeNameEqualToAnyNetwork(String ticker, String exchangeName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ticker_exchangeName_network',
        value: [ticker, exchangeName],
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause>
      tickerEqualToExchangeNameNotEqualToAnyNetwork(
          String ticker, String exchangeName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker],
              upper: [ticker, exchangeName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker, exchangeName],
              includeLower: false,
              upper: [ticker],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker, exchangeName],
              includeLower: false,
              upper: [ticker],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker],
              upper: [ticker, exchangeName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause>
      tickerExchangeNameNetworkEqualTo(
          String ticker, String exchangeName, String network) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ticker_exchangeName_network',
        value: [ticker, exchangeName, network],
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterWhereClause>
      tickerExchangeNameEqualToNetworkNotEqualTo(
          String ticker, String exchangeName, String network) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker, exchangeName],
              upper: [ticker, exchangeName, network],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker, exchangeName, network],
              includeLower: false,
              upper: [ticker, exchangeName],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker, exchangeName, network],
              includeLower: false,
              upper: [ticker, exchangeName],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ticker_exchangeName_network',
              lower: [ticker, exchangeName],
              upper: [ticker, exchangeName, network],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CurrencyQueryFilter
    on QueryBuilder<Currency, Currency, QFilterCondition> {
  QueryBuilder<Currency, Currency, QAfterFilterCondition> buyEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buy',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> exchangeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      exchangeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> exchangeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> exchangeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      exchangeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exchangeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> exchangeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exchangeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> exchangeNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exchangeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> exchangeNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exchangeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      exchangeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      exchangeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exchangeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> hasExternalIdEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasExternalId',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> isFiatEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFiat',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'network',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'network',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'network',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'network',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'network',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'network',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'network',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'network',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'network',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> networkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'network',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> rateTypeEqualTo(
      SupportedRateType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rateType',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> rateTypeGreaterThan(
    SupportedRateType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rateType',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> rateTypeLessThan(
    SupportedRateType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rateType',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> rateTypeBetween(
    SupportedRateType lower,
    SupportedRateType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rateType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> sellEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sell',
        value: value,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ticker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ticker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ticker',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ticker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ticker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ticker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ticker',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticker',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tickerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ticker',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      tokenContractIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tokenContract',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      tokenContractIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tokenContract',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tokenContractEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenContract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      tokenContractGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tokenContract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tokenContractLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tokenContract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tokenContractBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tokenContract',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      tokenContractStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tokenContract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tokenContractEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tokenContract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tokenContractContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tokenContract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition> tokenContractMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tokenContract',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      tokenContractIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenContract',
        value: '',
      ));
    });
  }

  QueryBuilder<Currency, Currency, QAfterFilterCondition>
      tokenContractIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tokenContract',
        value: '',
      ));
    });
  }
}

extension CurrencyQueryObject
    on QueryBuilder<Currency, Currency, QFilterCondition> {}

extension CurrencyQueryLinks
    on QueryBuilder<Currency, Currency, QFilterCondition> {}

extension CurrencyQuerySortBy on QueryBuilder<Currency, Currency, QSortBy> {
  QueryBuilder<Currency, Currency, QAfterSortBy> sortByBuy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buy', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByBuyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buy', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByExchangeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByExchangeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByHasExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasExternalId', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByHasExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasExternalId', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByIsFiat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFiat', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByIsFiatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFiat', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByRateType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateType', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByRateTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateType', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortBySell() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sell', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortBySellDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sell', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByTicker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticker', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByTickerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticker', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByTokenContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenContract', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> sortByTokenContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenContract', Sort.desc);
    });
  }
}

extension CurrencyQuerySortThenBy
    on QueryBuilder<Currency, Currency, QSortThenBy> {
  QueryBuilder<Currency, Currency, QAfterSortBy> thenByBuy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buy', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByBuyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buy', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByExchangeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByExchangeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByHasExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasExternalId', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByHasExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasExternalId', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByIsFiat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFiat', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByIsFiatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFiat', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'network', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByRateType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateType', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByRateTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rateType', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenBySell() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sell', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenBySellDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sell', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByTicker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticker', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByTickerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticker', Sort.desc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByTokenContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenContract', Sort.asc);
    });
  }

  QueryBuilder<Currency, Currency, QAfterSortBy> thenByTokenContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenContract', Sort.desc);
    });
  }
}

extension CurrencyQueryWhereDistinct
    on QueryBuilder<Currency, Currency, QDistinct> {
  QueryBuilder<Currency, Currency, QDistinct> distinctByBuy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'buy');
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByExchangeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByHasExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasExternalId');
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByIsFiat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFiat');
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByNetwork(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'network', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByRateType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rateType');
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctBySell() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sell');
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByTicker(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ticker', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Currency, Currency, QDistinct> distinctByTokenContract(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tokenContract',
          caseSensitive: caseSensitive);
    });
  }
}

extension CurrencyQueryProperty
    on QueryBuilder<Currency, Currency, QQueryProperty> {
  QueryBuilder<Currency, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Currency, bool, QQueryOperations> buyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'buy');
    });
  }

  QueryBuilder<Currency, String, QQueryOperations> exchangeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeName');
    });
  }

  QueryBuilder<Currency, bool, QQueryOperations> hasExternalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasExternalId');
    });
  }

  QueryBuilder<Currency, String, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<Currency, bool, QQueryOperations> isFiatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFiat');
    });
  }

  QueryBuilder<Currency, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Currency, String, QQueryOperations> networkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'network');
    });
  }

  QueryBuilder<Currency, SupportedRateType, QQueryOperations>
      rateTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rateType');
    });
  }

  QueryBuilder<Currency, bool, QQueryOperations> sellProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sell');
    });
  }

  QueryBuilder<Currency, String, QQueryOperations> tickerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticker');
    });
  }

  QueryBuilder<Currency, String?, QQueryOperations> tokenContractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tokenContract');
    });
  }
}
