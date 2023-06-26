// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetTradeCollection on Isar {
  IsarCollection<Trade> get trades => this.collection();
}

const TradeSchema = CollectionSchema(
  name: r'Trade',
  id: 4394246318675225554,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'exchangeName': PropertySchema(
      id: 1,
      name: r'exchangeName',
      type: IsarType.string,
    ),
    r'flow': PropertySchema(
      id: 2,
      name: r'flow',
      type: IsarType.string,
    ),
    r'fromAmount': PropertySchema(
      id: 3,
      name: r'fromAmount',
      type: IsarType.string,
    ),
    r'fromCurrency': PropertySchema(
      id: 4,
      name: r'fromCurrency',
      type: IsarType.string,
    ),
    r'fromNetwork': PropertySchema(
      id: 5,
      name: r'fromNetwork',
      type: IsarType.string,
    ),
    r'payinAddress': PropertySchema(
      id: 6,
      name: r'payinAddress',
      type: IsarType.string,
    ),
    r'payinHash': PropertySchema(
      id: 7,
      name: r'payinHash',
      type: IsarType.string,
    ),
    r'payoutAddress': PropertySchema(
      id: 8,
      name: r'payoutAddress',
      type: IsarType.string,
    ),
    r'payoutExtraId': PropertySchema(
      id: 9,
      name: r'payoutExtraId',
      type: IsarType.string,
    ),
    r'payoutHash': PropertySchema(
      id: 10,
      name: r'payoutHash',
      type: IsarType.string,
    ),
    r'refundAddress': PropertySchema(
      id: 11,
      name: r'refundAddress',
      type: IsarType.string,
    ),
    r'refundExtraId': PropertySchema(
      id: 12,
      name: r'refundExtraId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 13,
      name: r'status',
      type: IsarType.string,
    ),
    r'toAmount': PropertySchema(
      id: 14,
      name: r'toAmount',
      type: IsarType.string,
    ),
    r'toCurrency': PropertySchema(
      id: 15,
      name: r'toCurrency',
      type: IsarType.string,
    ),
    r'toNetwork': PropertySchema(
      id: 16,
      name: r'toNetwork',
      type: IsarType.string,
    ),
    r'tradeId': PropertySchema(
      id: 17,
      name: r'tradeId',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 18,
      name: r'type',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 19,
      name: r'updatedAt',
      type: IsarType.string,
    )
  },
  estimateSize: _tradeEstimateSize,
  serialize: _tradeSerialize,
  deserialize: _tradeDeserialize,
  deserializeProp: _tradeDeserializeProp,
  idName: r'id',
  indexes: {
    r'tradeId_exchangeName': IndexSchema(
      id: 8333166771988835565,
      name: r'tradeId_exchangeName',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'tradeId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'exchangeName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _tradeGetId,
  getLinks: _tradeGetLinks,
  attach: _tradeAttach,
  version: '3.0.5',
);

int _tradeEstimateSize(
  Trade object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.createdAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.exchangeName.length * 3;
  bytesCount += 3 + object.flow.length * 3;
  bytesCount += 3 + object.fromAmount.length * 3;
  bytesCount += 3 + object.fromCurrency.length * 3;
  bytesCount += 3 + object.fromNetwork.length * 3;
  bytesCount += 3 + object.payinAddress.length * 3;
  {
    final value = object.payinHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.payoutAddress.length * 3;
  bytesCount += 3 + object.payoutExtraId.length * 3;
  {
    final value = object.payoutHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.refundAddress.length * 3;
  bytesCount += 3 + object.refundExtraId.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.toAmount.length * 3;
  bytesCount += 3 + object.toCurrency.length * 3;
  bytesCount += 3 + object.toNetwork.length * 3;
  bytesCount += 3 + object.tradeId.length * 3;
  bytesCount += 3 + object.type.length * 3;
  {
    final value = object.updatedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tradeSerialize(
  Trade object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.exchangeName);
  writer.writeString(offsets[2], object.flow);
  writer.writeString(offsets[3], object.fromAmount);
  writer.writeString(offsets[4], object.fromCurrency);
  writer.writeString(offsets[5], object.fromNetwork);
  writer.writeString(offsets[6], object.payinAddress);
  writer.writeString(offsets[7], object.payinHash);
  writer.writeString(offsets[8], object.payoutAddress);
  writer.writeString(offsets[9], object.payoutExtraId);
  writer.writeString(offsets[10], object.payoutHash);
  writer.writeString(offsets[11], object.refundAddress);
  writer.writeString(offsets[12], object.refundExtraId);
  writer.writeString(offsets[13], object.status);
  writer.writeString(offsets[14], object.toAmount);
  writer.writeString(offsets[15], object.toCurrency);
  writer.writeString(offsets[16], object.toNetwork);
  writer.writeString(offsets[17], object.tradeId);
  writer.writeString(offsets[18], object.type);
  writer.writeString(offsets[19], object.updatedAt);
}

Trade _tradeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Trade(
    createdAt: reader.readStringOrNull(offsets[0]),
    exchangeName: reader.readString(offsets[1]),
    flow: reader.readString(offsets[2]),
    fromAmount: reader.readString(offsets[3]),
    fromCurrency: reader.readString(offsets[4]),
    fromNetwork: reader.readString(offsets[5]),
    payinAddress: reader.readString(offsets[6]),
    payinHash: reader.readStringOrNull(offsets[7]),
    payoutAddress: reader.readString(offsets[8]),
    payoutExtraId: reader.readString(offsets[9]),
    payoutHash: reader.readStringOrNull(offsets[10]),
    refundAddress: reader.readString(offsets[11]),
    refundExtraId: reader.readString(offsets[12]),
    status: reader.readString(offsets[13]),
    toAmount: reader.readString(offsets[14]),
    toCurrency: reader.readString(offsets[15]),
    toNetwork: reader.readString(offsets[16]),
    tradeId: reader.readString(offsets[17]),
    type: reader.readString(offsets[18]),
    updatedAt: reader.readStringOrNull(offsets[19]),
  );
  object.id = id;
  return object;
}

P _tradeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tradeGetId(Trade object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tradeGetLinks(Trade object) {
  return [];
}

void _tradeAttach(IsarCollection<dynamic> col, Id id, Trade object) {
  object.id = id;
}

extension TradeByIndex on IsarCollection<Trade> {
  Future<Trade?> getByTradeIdExchangeName(String tradeId, String exchangeName) {
    return getByIndex(r'tradeId_exchangeName', [tradeId, exchangeName]);
  }

  Trade? getByTradeIdExchangeNameSync(String tradeId, String exchangeName) {
    return getByIndexSync(r'tradeId_exchangeName', [tradeId, exchangeName]);
  }

  Future<bool> deleteByTradeIdExchangeName(
      String tradeId, String exchangeName) {
    return deleteByIndex(r'tradeId_exchangeName', [tradeId, exchangeName]);
  }

  bool deleteByTradeIdExchangeNameSync(String tradeId, String exchangeName) {
    return deleteByIndexSync(r'tradeId_exchangeName', [tradeId, exchangeName]);
  }

  Future<List<Trade?>> getAllByTradeIdExchangeName(
      List<String> tradeIdValues, List<String> exchangeNameValues) {
    final len = tradeIdValues.length;
    assert(exchangeNameValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tradeIdValues[i], exchangeNameValues[i]]);
    }

    return getAllByIndex(r'tradeId_exchangeName', values);
  }

  List<Trade?> getAllByTradeIdExchangeNameSync(
      List<String> tradeIdValues, List<String> exchangeNameValues) {
    final len = tradeIdValues.length;
    assert(exchangeNameValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tradeIdValues[i], exchangeNameValues[i]]);
    }

    return getAllByIndexSync(r'tradeId_exchangeName', values);
  }

  Future<int> deleteAllByTradeIdExchangeName(
      List<String> tradeIdValues, List<String> exchangeNameValues) {
    final len = tradeIdValues.length;
    assert(exchangeNameValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tradeIdValues[i], exchangeNameValues[i]]);
    }

    return deleteAllByIndex(r'tradeId_exchangeName', values);
  }

  int deleteAllByTradeIdExchangeNameSync(
      List<String> tradeIdValues, List<String> exchangeNameValues) {
    final len = tradeIdValues.length;
    assert(exchangeNameValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([tradeIdValues[i], exchangeNameValues[i]]);
    }

    return deleteAllByIndexSync(r'tradeId_exchangeName', values);
  }

  Future<Id> putByTradeIdExchangeName(Trade object) {
    return putByIndex(r'tradeId_exchangeName', object);
  }

  Id putByTradeIdExchangeNameSync(Trade object, {bool saveLinks = true}) {
    return putByIndexSync(r'tradeId_exchangeName', object,
        saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTradeIdExchangeName(List<Trade> objects) {
    return putAllByIndex(r'tradeId_exchangeName', objects);
  }

  List<Id> putAllByTradeIdExchangeNameSync(List<Trade> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'tradeId_exchangeName', objects,
        saveLinks: saveLinks);
  }
}

extension TradeQueryWhereSort on QueryBuilder<Trade, Trade, QWhere> {
  QueryBuilder<Trade, Trade, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TradeQueryWhere on QueryBuilder<Trade, Trade, QWhereClause> {
  QueryBuilder<Trade, Trade, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Trade, Trade, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idBetween(
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

  QueryBuilder<Trade, Trade, QAfterWhereClause> tradeIdEqualToAnyExchangeName(
      String tradeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tradeId_exchangeName',
        value: [tradeId],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause>
      tradeIdNotEqualToAnyExchangeName(String tradeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [],
              upper: [tradeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [tradeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [tradeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [],
              upper: [tradeId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> tradeIdExchangeNameEqualTo(
      String tradeId, String exchangeName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tradeId_exchangeName',
        value: [tradeId, exchangeName],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause>
      tradeIdEqualToExchangeNameNotEqualTo(
          String tradeId, String exchangeName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [tradeId],
              upper: [tradeId, exchangeName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [tradeId, exchangeName],
              includeLower: false,
              upper: [tradeId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [tradeId, exchangeName],
              includeLower: false,
              upper: [tradeId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tradeId_exchangeName',
              lower: [tradeId],
              upper: [tradeId, exchangeName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TradeQueryFilter on QueryBuilder<Trade, Trade, QFilterCondition> {
  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameEqualTo(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameGreaterThan(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameLessThan(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameBetween(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameStartsWith(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameEndsWith(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameContains(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameMatches(
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exchangeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exchangeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'flow',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'flow',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flow',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> flowIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'flow',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromNetwork',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromNetwork',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> fromNetworkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payinAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payinAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payinAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payinAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payinAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payinAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payinAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payinAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payinAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payinAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payinHash',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payinHash',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payinHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payinHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payinHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payinHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payinHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payinHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payinHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payinHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payinHash',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payinHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payinHash',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payoutAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payoutAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payoutAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payoutAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payoutAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payoutAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payoutAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payoutAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payoutExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payoutExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payoutExtraId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payoutExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payoutExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payoutExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payoutExtraId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutExtraId',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutExtraIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payoutExtraId',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payoutHash',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payoutHash',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payoutHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payoutHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payoutHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payoutHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payoutHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payoutHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payoutHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutHash',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> payoutHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payoutHash',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refundAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'refundAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'refundAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'refundAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'refundAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'refundAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'refundAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'refundAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refundAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'refundAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refundExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'refundExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'refundExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'refundExtraId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'refundExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'refundExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'refundExtraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'refundExtraId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refundExtraId',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> refundExtraIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'refundExtraId',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toNetwork',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toNetwork',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> toNetworkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tradeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tradeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tradeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tradeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tradeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tradeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tradeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tradeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tradeId',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> tradeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tradeId',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }
}

extension TradeQueryObject on QueryBuilder<Trade, Trade, QFilterCondition> {}

extension TradeQueryLinks on QueryBuilder<Trade, Trade, QFilterCondition> {}

extension TradeQuerySortBy on QueryBuilder<Trade, Trade, QSortBy> {
  QueryBuilder<Trade, Trade, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByExchangeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByExchangeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFlow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flow', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFlowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flow', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFromAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmount', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFromAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmount', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFromCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFromCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFromNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByFromNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayinAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinAddress', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayinAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinAddress', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayinHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinHash', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayinHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinHash', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayoutAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutAddress', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayoutAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutAddress', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayoutExtraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutExtraId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayoutExtraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutExtraId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayoutHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutHash', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPayoutHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutHash', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByRefundAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundAddress', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByRefundAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundAddress', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByRefundExtraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundExtraId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByRefundExtraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundExtraId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByToAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmount', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByToAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmount', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByToCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByToCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByToNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByToNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByTradeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tradeId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByTradeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tradeId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension TradeQuerySortThenBy on QueryBuilder<Trade, Trade, QSortThenBy> {
  QueryBuilder<Trade, Trade, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByExchangeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByExchangeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeName', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFlow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flow', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFlowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flow', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFromAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmount', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFromAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmount', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFromCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFromCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFromNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByFromNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayinAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinAddress', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayinAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinAddress', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayinHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinHash', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayinHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payinHash', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayoutAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutAddress', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayoutAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutAddress', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayoutExtraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutExtraId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayoutExtraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutExtraId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayoutHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutHash', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPayoutHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutHash', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByRefundAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundAddress', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByRefundAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundAddress', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByRefundExtraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundExtraId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByRefundExtraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refundExtraId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByToAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmount', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByToAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmount', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByToCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByToCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByToNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByToNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByTradeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tradeId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByTradeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tradeId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension TradeQueryWhereDistinct on QueryBuilder<Trade, Trade, QDistinct> {
  QueryBuilder<Trade, Trade, QDistinct> distinctByCreatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByExchangeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByFlow(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'flow', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByFromAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromAmount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByFromCurrency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromCurrency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByFromNetwork(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromNetwork', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPayinAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payinAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPayinHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payinHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPayoutAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payoutAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPayoutExtraId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payoutExtraId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPayoutHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payoutHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByRefundAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refundAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByRefundExtraId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refundExtraId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByToAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toAmount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByToCurrency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toCurrency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByToNetwork(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toNetwork', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByTradeId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tradeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByUpdatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }
}

extension TradeQueryProperty on QueryBuilder<Trade, Trade, QQueryProperty> {
  QueryBuilder<Trade, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> exchangeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeName');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> flowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flow');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> fromAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromAmount');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> fromCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromCurrency');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> fromNetworkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromNetwork');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> payinAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payinAddress');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> payinHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payinHash');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> payoutAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payoutAddress');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> payoutExtraIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payoutExtraId');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> payoutHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payoutHash');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> refundAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refundAddress');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> refundExtraIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refundExtraId');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> toAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toAmount');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> toCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toCurrency');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> toNetworkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toNetwork');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> tradeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tradeId');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
