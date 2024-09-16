// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardarian_transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGuardarianTransactionCollection on Isar {
  IsarCollection<GuardarianTransaction> get guardarianTransactions =>
      this.collection();
}

const GuardarianTransactionSchema = CollectionSchema(
  name: r'GuardarianTransaction',
  id: 283028054751354796,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'createdAtTimestamp': PropertySchema(
      id: 2,
      name: r'createdAtTimestamp',
      type: IsarType.long,
    ),
    r'customerPayoutAddressChangeable': PropertySchema(
      id: 3,
      name: r'customerPayoutAddressChangeable',
      type: IsarType.bool,
    ),
    r'depositPaymentCategoryString': PropertySchema(
      id: 4,
      name: r'depositPaymentCategoryString',
      type: IsarType.string,
    ),
    r'depositType': PropertySchema(
      id: 5,
      name: r'depositType',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 6,
      name: r'email',
      type: IsarType.string,
    ),
    r'estimateBreakdownConvertedAmount': PropertySchema(
      id: 7,
      name: r'estimateBreakdownConvertedAmount',
      type: IsarType.object,
      target: r'ConvertedAmountEmbedded',
    ),
    r'estimateBreakdownEstimatedExchangeRateString': PropertySchema(
      id: 8,
      name: r'estimateBreakdownEstimatedExchangeRateString',
      type: IsarType.string,
    ),
    r'estimateBreakdownFromAmountString': PropertySchema(
      id: 9,
      name: r'estimateBreakdownFromAmountString',
      type: IsarType.string,
    ),
    r'estimateBreakdownNetworkFee': PropertySchema(
      id: 10,
      name: r'estimateBreakdownNetworkFee',
      type: IsarType.object,
      target: r'NetworkFeeEmbedded',
    ),
    r'estimateBreakdownPartnerFee': PropertySchema(
      id: 11,
      name: r'estimateBreakdownPartnerFee',
      type: IsarType.object,
      target: r'PartnerFeeEmbedded',
    ),
    r'estimateBreakdownServiceFees': PropertySchema(
      id: 12,
      name: r'estimateBreakdownServiceFees',
      type: IsarType.objectList,
      target: r'ServiceFeeEmbedded',
    ),
    r'estimateBreakdownToAmountString': PropertySchema(
      id: 13,
      name: r'estimateBreakdownToAmountString',
      type: IsarType.string,
    ),
    r'expectedFromAmountString': PropertySchema(
      id: 14,
      name: r'expectedFromAmountString',
      type: IsarType.string,
    ),
    r'expectedToAmountString': PropertySchema(
      id: 15,
      name: r'expectedToAmountString',
      type: IsarType.string,
    ),
    r'externalPartnerLinkId': PropertySchema(
      id: 16,
      name: r'externalPartnerLinkId',
      type: IsarType.string,
    ),
    r'extraId': PropertySchema(
      id: 17,
      name: r'extraId',
      type: IsarType.string,
    ),
    r'fromAmountInEurString': PropertySchema(
      id: 18,
      name: r'fromAmountInEurString',
      type: IsarType.string,
    ),
    r'fromAmountString': PropertySchema(
      id: 19,
      name: r'fromAmountString',
      type: IsarType.string,
    ),
    r'fromCurrency': PropertySchema(
      id: 20,
      name: r'fromCurrency',
      type: IsarType.string,
    ),
    r'fromCurrencyWithNetwork': PropertySchema(
      id: 21,
      name: r'fromCurrencyWithNetwork',
      type: IsarType.string,
    ),
    r'fromNetwork': PropertySchema(
      id: 22,
      name: r'fromNetwork',
      type: IsarType.string,
    ),
    r'initialExpectedFromAmountString': PropertySchema(
      id: 23,
      name: r'initialExpectedFromAmountString',
      type: IsarType.string,
    ),
    r'initialFromCurrency': PropertySchema(
      id: 24,
      name: r'initialFromCurrency',
      type: IsarType.string,
    ),
    r'location': PropertySchema(
      id: 25,
      name: r'location',
      type: IsarType.string,
    ),
    r'outputHash': PropertySchema(
      id: 26,
      name: r'outputHash',
      type: IsarType.string,
    ),
    r'partnerId': PropertySchema(
      id: 27,
      name: r'partnerId',
      type: IsarType.string,
    ),
    r'payoutPaymentCategoryString': PropertySchema(
      id: 28,
      name: r'payoutPaymentCategoryString',
      type: IsarType.string,
    ),
    r'payoutType': PropertySchema(
      id: 29,
      name: r'payoutType',
      type: IsarType.string,
    ),
    r'preauthToken': PropertySchema(
      id: 30,
      name: r'preauthToken',
      type: IsarType.string,
    ),
    r'redirectUrl': PropertySchema(
      id: 31,
      name: r'redirectUrl',
      type: IsarType.string,
    ),
    r'skipChoosePaymentCategory': PropertySchema(
      id: 32,
      name: r'skipChoosePaymentCategory',
      type: IsarType.bool,
    ),
    r'skipChoosePayoutAddress': PropertySchema(
      id: 33,
      name: r'skipChoosePayoutAddress',
      type: IsarType.bool,
    ),
    r'statusDetails': PropertySchema(
      id: 34,
      name: r'statusDetails',
      type: IsarType.string,
    ),
    r'statusString': PropertySchema(
      id: 35,
      name: r'statusString',
      type: IsarType.string,
    ),
    r'toAmountString': PropertySchema(
      id: 36,
      name: r'toAmountString',
      type: IsarType.string,
    ),
    r'toCurrency': PropertySchema(
      id: 37,
      name: r'toCurrency',
      type: IsarType.string,
    ),
    r'toCurrencyWithNetwork': PropertySchema(
      id: 38,
      name: r'toCurrencyWithNetwork',
      type: IsarType.string,
    ),
    r'toNetwork': PropertySchema(
      id: 39,
      name: r'toNetwork',
      type: IsarType.string,
    ),
    r'transactionId': PropertySchema(
      id: 40,
      name: r'transactionId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 41,
      name: r'updatedAt',
      type: IsarType.string,
    )
  },
  estimateSize: _guardarianTransactionEstimateSize,
  serialize: _guardarianTransactionSerialize,
  deserialize: _guardarianTransactionDeserialize,
  deserializeProp: _guardarianTransactionDeserializeProp,
  idName: r'id',
  indexes: {
    r'transactionId': IndexSchema(
      id: 8561542235958051982,
      name: r'transactionId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'transactionId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'ServiceFeeEmbedded': ServiceFeeEmbeddedSchema,
    r'ConvertedAmountEmbedded': ConvertedAmountEmbeddedSchema,
    r'NetworkFeeEmbedded': NetworkFeeEmbeddedSchema,
    r'PartnerFeeEmbedded': PartnerFeeEmbeddedSchema
  },
  getId: _guardarianTransactionGetId,
  getLinks: _guardarianTransactionGetLinks,
  attach: _guardarianTransactionAttach,
  version: '3.1.8',
);

int _guardarianTransactionEstimateSize(
  GuardarianTransaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.createdAt.length * 3;
  bytesCount += 3 + object.depositPaymentCategoryString.length * 3;
  bytesCount += 3 + object.depositType.length * 3;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 +
      ConvertedAmountEmbeddedSchema.estimateSize(
          object.estimateBreakdownConvertedAmount,
          allOffsets[ConvertedAmountEmbedded]!,
          allOffsets);
  bytesCount +=
      3 + object.estimateBreakdownEstimatedExchangeRateString.length * 3;
  bytesCount += 3 + object.estimateBreakdownFromAmountString.length * 3;
  bytesCount += 3 +
      NetworkFeeEmbeddedSchema.estimateSize(object.estimateBreakdownNetworkFee,
          allOffsets[NetworkFeeEmbedded]!, allOffsets);
  bytesCount += 3 +
      PartnerFeeEmbeddedSchema.estimateSize(object.estimateBreakdownPartnerFee,
          allOffsets[PartnerFeeEmbedded]!, allOffsets);
  bytesCount += 3 + object.estimateBreakdownServiceFees.length * 3;
  {
    final offsets = allOffsets[ServiceFeeEmbedded]!;
    for (var i = 0; i < object.estimateBreakdownServiceFees.length; i++) {
      final value = object.estimateBreakdownServiceFees[i];
      bytesCount +=
          ServiceFeeEmbeddedSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.estimateBreakdownToAmountString.length * 3;
  bytesCount += 3 + object.expectedFromAmountString.length * 3;
  bytesCount += 3 + object.expectedToAmountString.length * 3;
  {
    final value = object.externalPartnerLinkId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.extraId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fromAmountInEurString.length * 3;
  bytesCount += 3 + object.fromAmountString.length * 3;
  bytesCount += 3 + object.fromCurrency.length * 3;
  {
    final value = object.fromCurrencyWithNetwork;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fromNetwork;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.initialExpectedFromAmountString.length * 3;
  {
    final value = object.initialFromCurrency;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.location.length * 3;
  {
    final value = object.outputHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.partnerId.length * 3;
  bytesCount += 3 + object.payoutPaymentCategoryString.length * 3;
  bytesCount += 3 + object.payoutType.length * 3;
  {
    final value = object.preauthToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.redirectUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.statusDetails;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.statusString.length * 3;
  bytesCount += 3 + object.toAmountString.length * 3;
  bytesCount += 3 + object.toCurrency.length * 3;
  {
    final value = object.toCurrencyWithNetwork;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.toNetwork;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.transactionId.length * 3;
  bytesCount += 3 + object.updatedAt.length * 3;
  return bytesCount;
}

void _guardarianTransactionSerialize(
  GuardarianTransaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.createdAt);
  writer.writeLong(offsets[2], object.createdAtTimestamp);
  writer.writeBool(offsets[3], object.customerPayoutAddressChangeable);
  writer.writeString(offsets[4], object.depositPaymentCategoryString);
  writer.writeString(offsets[5], object.depositType);
  writer.writeString(offsets[6], object.email);
  writer.writeObject<ConvertedAmountEmbedded>(
    offsets[7],
    allOffsets,
    ConvertedAmountEmbeddedSchema.serialize,
    object.estimateBreakdownConvertedAmount,
  );
  writer.writeString(
      offsets[8], object.estimateBreakdownEstimatedExchangeRateString);
  writer.writeString(offsets[9], object.estimateBreakdownFromAmountString);
  writer.writeObject<NetworkFeeEmbedded>(
    offsets[10],
    allOffsets,
    NetworkFeeEmbeddedSchema.serialize,
    object.estimateBreakdownNetworkFee,
  );
  writer.writeObject<PartnerFeeEmbedded>(
    offsets[11],
    allOffsets,
    PartnerFeeEmbeddedSchema.serialize,
    object.estimateBreakdownPartnerFee,
  );
  writer.writeObjectList<ServiceFeeEmbedded>(
    offsets[12],
    allOffsets,
    ServiceFeeEmbeddedSchema.serialize,
    object.estimateBreakdownServiceFees,
  );
  writer.writeString(offsets[13], object.estimateBreakdownToAmountString);
  writer.writeString(offsets[14], object.expectedFromAmountString);
  writer.writeString(offsets[15], object.expectedToAmountString);
  writer.writeString(offsets[16], object.externalPartnerLinkId);
  writer.writeString(offsets[17], object.extraId);
  writer.writeString(offsets[18], object.fromAmountInEurString);
  writer.writeString(offsets[19], object.fromAmountString);
  writer.writeString(offsets[20], object.fromCurrency);
  writer.writeString(offsets[21], object.fromCurrencyWithNetwork);
  writer.writeString(offsets[22], object.fromNetwork);
  writer.writeString(offsets[23], object.initialExpectedFromAmountString);
  writer.writeString(offsets[24], object.initialFromCurrency);
  writer.writeString(offsets[25], object.location);
  writer.writeString(offsets[26], object.outputHash);
  writer.writeString(offsets[27], object.partnerId);
  writer.writeString(offsets[28], object.payoutPaymentCategoryString);
  writer.writeString(offsets[29], object.payoutType);
  writer.writeString(offsets[30], object.preauthToken);
  writer.writeString(offsets[31], object.redirectUrl);
  writer.writeBool(offsets[32], object.skipChoosePaymentCategory);
  writer.writeBool(offsets[33], object.skipChoosePayoutAddress);
  writer.writeString(offsets[34], object.statusDetails);
  writer.writeString(offsets[35], object.statusString);
  writer.writeString(offsets[36], object.toAmountString);
  writer.writeString(offsets[37], object.toCurrency);
  writer.writeString(offsets[38], object.toCurrencyWithNetwork);
  writer.writeString(offsets[39], object.toNetwork);
  writer.writeString(offsets[40], object.transactionId);
  writer.writeString(offsets[41], object.updatedAt);
}

GuardarianTransaction _guardarianTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GuardarianTransaction(
    address: reader.readStringOrNull(offsets[0]),
    createdAt: reader.readString(offsets[1]),
    customerPayoutAddressChangeable: reader.readBoolOrNull(offsets[3]),
    depositPaymentCategoryString: reader.readString(offsets[4]),
    depositType: reader.readString(offsets[5]),
    email: reader.readStringOrNull(offsets[6]),
    estimateBreakdownConvertedAmount:
        reader.readObjectOrNull<ConvertedAmountEmbedded>(
              offsets[7],
              ConvertedAmountEmbeddedSchema.deserialize,
              allOffsets,
            ) ??
            ConvertedAmountEmbedded(),
    estimateBreakdownEstimatedExchangeRateString: reader.readString(offsets[8]),
    estimateBreakdownFromAmountString: reader.readString(offsets[9]),
    estimateBreakdownNetworkFee: reader.readObjectOrNull<NetworkFeeEmbedded>(
          offsets[10],
          NetworkFeeEmbeddedSchema.deserialize,
          allOffsets,
        ) ??
        NetworkFeeEmbedded(),
    estimateBreakdownPartnerFee: reader.readObjectOrNull<PartnerFeeEmbedded>(
          offsets[11],
          PartnerFeeEmbeddedSchema.deserialize,
          allOffsets,
        ) ??
        PartnerFeeEmbedded(),
    estimateBreakdownServiceFees: reader.readObjectList<ServiceFeeEmbedded>(
          offsets[12],
          ServiceFeeEmbeddedSchema.deserialize,
          allOffsets,
          ServiceFeeEmbedded(),
        ) ??
        [],
    estimateBreakdownToAmountString: reader.readString(offsets[13]),
    expectedFromAmountString: reader.readString(offsets[14]),
    expectedToAmountString: reader.readString(offsets[15]),
    externalPartnerLinkId: reader.readStringOrNull(offsets[16]),
    extraId: reader.readStringOrNull(offsets[17]),
    fromAmountInEurString: reader.readString(offsets[18]),
    fromAmountString: reader.readString(offsets[19]),
    fromCurrency: reader.readString(offsets[20]),
    fromCurrencyWithNetwork: reader.readStringOrNull(offsets[21]),
    fromNetwork: reader.readStringOrNull(offsets[22]),
    initialExpectedFromAmountString: reader.readString(offsets[23]),
    initialFromCurrency: reader.readStringOrNull(offsets[24]),
    location: reader.readString(offsets[25]),
    outputHash: reader.readStringOrNull(offsets[26]),
    partnerId: reader.readString(offsets[27]),
    payoutPaymentCategoryString: reader.readString(offsets[28]),
    payoutType: reader.readString(offsets[29]),
    preauthToken: reader.readStringOrNull(offsets[30]),
    redirectUrl: reader.readStringOrNull(offsets[31]),
    skipChoosePaymentCategory: reader.readBoolOrNull(offsets[32]),
    skipChoosePayoutAddress: reader.readBoolOrNull(offsets[33]),
    statusDetails: reader.readStringOrNull(offsets[34]),
    statusString: reader.readString(offsets[35]),
    toAmountString: reader.readString(offsets[36]),
    toCurrency: reader.readString(offsets[37]),
    toCurrencyWithNetwork: reader.readStringOrNull(offsets[38]),
    toNetwork: reader.readStringOrNull(offsets[39]),
    transactionId: reader.readString(offsets[40]),
    updatedAt: reader.readString(offsets[41]),
  );
  object.id = id;
  return object;
}

P _guardarianTransactionDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readObjectOrNull<ConvertedAmountEmbedded>(
            offset,
            ConvertedAmountEmbeddedSchema.deserialize,
            allOffsets,
          ) ??
          ConvertedAmountEmbedded()) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readObjectOrNull<NetworkFeeEmbedded>(
            offset,
            NetworkFeeEmbeddedSchema.deserialize,
            allOffsets,
          ) ??
          NetworkFeeEmbedded()) as P;
    case 11:
      return (reader.readObjectOrNull<PartnerFeeEmbedded>(
            offset,
            PartnerFeeEmbeddedSchema.deserialize,
            allOffsets,
          ) ??
          PartnerFeeEmbedded()) as P;
    case 12:
      return (reader.readObjectList<ServiceFeeEmbedded>(
            offset,
            ServiceFeeEmbeddedSchema.deserialize,
            allOffsets,
            ServiceFeeEmbedded(),
          ) ??
          []) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readBoolOrNull(offset)) as P;
    case 33:
      return (reader.readBoolOrNull(offset)) as P;
    case 34:
      return (reader.readStringOrNull(offset)) as P;
    case 35:
      return (reader.readString(offset)) as P;
    case 36:
      return (reader.readString(offset)) as P;
    case 37:
      return (reader.readString(offset)) as P;
    case 38:
      return (reader.readStringOrNull(offset)) as P;
    case 39:
      return (reader.readStringOrNull(offset)) as P;
    case 40:
      return (reader.readString(offset)) as P;
    case 41:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _guardarianTransactionGetId(GuardarianTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _guardarianTransactionGetLinks(
    GuardarianTransaction object) {
  return [];
}

void _guardarianTransactionAttach(
    IsarCollection<dynamic> col, Id id, GuardarianTransaction object) {
  object.id = id;
}

extension GuardarianTransactionByIndex
    on IsarCollection<GuardarianTransaction> {
  Future<GuardarianTransaction?> getByTransactionId(String transactionId) {
    return getByIndex(r'transactionId', [transactionId]);
  }

  GuardarianTransaction? getByTransactionIdSync(String transactionId) {
    return getByIndexSync(r'transactionId', [transactionId]);
  }

  Future<bool> deleteByTransactionId(String transactionId) {
    return deleteByIndex(r'transactionId', [transactionId]);
  }

  bool deleteByTransactionIdSync(String transactionId) {
    return deleteByIndexSync(r'transactionId', [transactionId]);
  }

  Future<List<GuardarianTransaction?>> getAllByTransactionId(
      List<String> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'transactionId', values);
  }

  List<GuardarianTransaction?> getAllByTransactionIdSync(
      List<String> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'transactionId', values);
  }

  Future<int> deleteAllByTransactionId(List<String> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'transactionId', values);
  }

  int deleteAllByTransactionIdSync(List<String> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'transactionId', values);
  }

  Future<Id> putByTransactionId(GuardarianTransaction object) {
    return putByIndex(r'transactionId', object);
  }

  Id putByTransactionIdSync(GuardarianTransaction object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'transactionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTransactionId(List<GuardarianTransaction> objects) {
    return putAllByIndex(r'transactionId', objects);
  }

  List<Id> putAllByTransactionIdSync(List<GuardarianTransaction> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'transactionId', objects, saveLinks: saveLinks);
  }
}

extension GuardarianTransactionQueryWhereSort
    on QueryBuilder<GuardarianTransaction, GuardarianTransaction, QWhere> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GuardarianTransactionQueryWhere on QueryBuilder<GuardarianTransaction,
    GuardarianTransaction, QWhereClause> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      transactionIdEqualTo(String transactionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'transactionId',
        value: [transactionId],
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterWhereClause>
      transactionIdNotEqualTo(String transactionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [],
              upper: [transactionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [transactionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [transactionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [],
              upper: [transactionId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension GuardarianTransactionQueryFilter on QueryBuilder<
    GuardarianTransaction, GuardarianTransaction, QFilterCondition> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtEqualTo(
    String value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtGreaterThan(
    String value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtLessThan(
    String value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtBetween(
    String lower,
    String upper, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtStartsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtEndsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      createdAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      createdAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtTimestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtTimestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtTimestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> createdAtTimestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> customerPayoutAddressChangeableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customerPayoutAddressChangeable',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> customerPayoutAddressChangeableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customerPayoutAddressChangeable',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      customerPayoutAddressChangeableEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPayoutAddressChangeable',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depositPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'depositPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'depositPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'depositPaymentCategoryString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'depositPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'depositPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      depositPaymentCategoryStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'depositPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      depositPaymentCategoryStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'depositPaymentCategoryString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depositPaymentCategoryString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositPaymentCategoryStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'depositPaymentCategoryString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depositType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'depositType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'depositType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'depositType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'depositType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'depositType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      depositTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'depositType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      depositTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'depositType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'depositType',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> depositTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'depositType',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownEstimatedExchangeRateStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estimateBreakdownEstimatedExchangeRateString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateBreakdownFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimateBreakdownFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimateBreakdownFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimateBreakdownFromAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estimateBreakdownFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estimateBreakdownFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownFromAmountStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estimateBreakdownFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownFromAmountStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estimateBreakdownFromAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateBreakdownFromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownFromAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estimateBreakdownFromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownServiceFeesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'estimateBreakdownServiceFees',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownServiceFeesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'estimateBreakdownServiceFees',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownServiceFeesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'estimateBreakdownServiceFees',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownServiceFeesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'estimateBreakdownServiceFees',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownServiceFeesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'estimateBreakdownServiceFees',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownServiceFeesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'estimateBreakdownServiceFees',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateBreakdownToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimateBreakdownToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimateBreakdownToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimateBreakdownToAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estimateBreakdownToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estimateBreakdownToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownToAmountStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estimateBreakdownToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownToAmountStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estimateBreakdownToAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimateBreakdownToAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> estimateBreakdownToAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estimateBreakdownToAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedFromAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      expectedFromAmountStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      expectedFromAmountStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expectedFromAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedFromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedFromAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expectedFromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedToAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expectedToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expectedToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      expectedToAmountStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expectedToAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      expectedToAmountStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expectedToAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedToAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> expectedToAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expectedToAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'externalPartnerLinkId',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'externalPartnerLinkId',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'externalPartnerLinkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'externalPartnerLinkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'externalPartnerLinkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'externalPartnerLinkId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'externalPartnerLinkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'externalPartnerLinkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      externalPartnerLinkIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'externalPartnerLinkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      externalPartnerLinkIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'externalPartnerLinkId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'externalPartnerLinkId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> externalPartnerLinkIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'externalPartnerLinkId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'extraId',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'extraId',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extraId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'extraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'extraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      extraIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extraId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      extraIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extraId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extraId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> extraIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extraId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAmountInEurString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromAmountInEurString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromAmountInEurString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromAmountInEurString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromAmountInEurString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromAmountInEurString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromAmountInEurStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromAmountInEurString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromAmountInEurStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromAmountInEurString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAmountInEurString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountInEurStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromAmountInEurString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromAmountStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromAmountStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyEqualTo(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyGreaterThan(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyLessThan(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyBetween(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyStartsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyEndsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromCurrencyWithNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromCurrencyWithNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromCurrencyWithNetwork',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromCurrencyWithNetworkContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromCurrencyWithNetworkMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromCurrencyWithNetwork',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrencyWithNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromCurrencyWithNetworkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromCurrencyWithNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkEqualTo(
    String? value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkGreaterThan(
    String? value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkLessThan(
    String? value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkStartsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkEndsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromNetworkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      fromNetworkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromNetwork',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> fromNetworkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initialExpectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initialExpectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initialExpectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initialExpectedFromAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'initialExpectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'initialExpectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      initialExpectedFromAmountStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'initialExpectedFromAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      initialExpectedFromAmountStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'initialExpectedFromAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initialExpectedFromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialExpectedFromAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'initialExpectedFromAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'initialFromCurrency',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'initialFromCurrency',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initialFromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initialFromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initialFromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initialFromCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'initialFromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'initialFromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      initialFromCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'initialFromCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      initialFromCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'initialFromCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initialFromCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> initialFromCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'initialFromCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'outputHash',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'outputHash',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outputHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outputHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outputHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outputHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'outputHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'outputHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      outputHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'outputHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      outputHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'outputHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outputHash',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> outputHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'outputHash',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'partnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'partnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      partnerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'partnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      partnerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'partnerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> partnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payoutPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payoutPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payoutPaymentCategoryString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payoutPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payoutPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      payoutPaymentCategoryStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payoutPaymentCategoryString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      payoutPaymentCategoryStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payoutPaymentCategoryString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutPaymentCategoryString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutPaymentCategoryStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payoutPaymentCategoryString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payoutType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payoutType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payoutType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payoutType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payoutType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      payoutTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payoutType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      payoutTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payoutType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payoutType',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> payoutTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payoutType',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'preauthToken',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'preauthToken',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preauthToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preauthToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preauthToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preauthToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preauthToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preauthToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      preauthTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preauthToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      preauthTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preauthToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preauthToken',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> preauthTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preauthToken',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'redirectUrl',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'redirectUrl',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'redirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'redirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'redirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'redirectUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'redirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'redirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      redirectUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'redirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      redirectUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'redirectUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'redirectUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> redirectUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'redirectUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> skipChoosePaymentCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'skipChoosePaymentCategory',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> skipChoosePaymentCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'skipChoosePaymentCategory',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> skipChoosePaymentCategoryEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skipChoosePaymentCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> skipChoosePayoutAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'skipChoosePayoutAddress',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> skipChoosePayoutAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'skipChoosePayoutAddress',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> skipChoosePayoutAddressEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skipChoosePayoutAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'statusDetails',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'statusDetails',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusDetails',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statusDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statusDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      statusDetailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      statusDetailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusDetails',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusDetailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statusString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statusString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      statusStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      statusStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> statusStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toAmountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toAmountStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toAmountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toAmountStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toAmountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toAmountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toAmountString',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyEqualTo(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyGreaterThan(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyLessThan(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyBetween(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyStartsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyEndsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toCurrencyWithNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toCurrencyWithNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toCurrencyWithNetwork',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toCurrencyWithNetworkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toCurrencyWithNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toCurrencyWithNetworkMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toCurrencyWithNetwork',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrencyWithNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toCurrencyWithNetworkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toCurrencyWithNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toNetwork',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkEqualTo(
    String? value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkGreaterThan(
    String? value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkLessThan(
    String? value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkStartsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkEndsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toNetworkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toNetwork',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      toNetworkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toNetwork',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> toNetworkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toNetwork',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      transactionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      transactionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transactionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> transactionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transactionId',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtEqualTo(
    String value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtGreaterThan(
    String value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtLessThan(
    String value, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtBetween(
    String lower,
    String upper, {
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtStartsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtEndsWith(
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

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      updatedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      updatedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
      QAfterFilterCondition> updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }
}

extension GuardarianTransactionQueryObject on QueryBuilder<
    GuardarianTransaction, GuardarianTransaction, QFilterCondition> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownConvertedAmount(FilterQuery<ConvertedAmountEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'estimateBreakdownConvertedAmount');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownNetworkFee(FilterQuery<NetworkFeeEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'estimateBreakdownNetworkFee');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownPartnerFee(FilterQuery<PartnerFeeEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'estimateBreakdownPartnerFee');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction,
          QAfterFilterCondition>
      estimateBreakdownServiceFeesElement(FilterQuery<ServiceFeeEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'estimateBreakdownServiceFees');
    });
  }
}

extension GuardarianTransactionQueryLinks on QueryBuilder<GuardarianTransaction,
    GuardarianTransaction, QFilterCondition> {}

extension GuardarianTransactionQuerySortBy
    on QueryBuilder<GuardarianTransaction, GuardarianTransaction, QSortBy> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByCreatedAtTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimestamp', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByCreatedAtTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimestamp', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByCustomerPayoutAddressChangeable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPayoutAddressChangeable', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByCustomerPayoutAddressChangeableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPayoutAddressChangeable', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByDepositPaymentCategoryString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositPaymentCategoryString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByDepositPaymentCategoryStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositPaymentCategoryString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByDepositType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositType', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByDepositTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositType', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEstimateBreakdownEstimatedExchangeRateString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'estimateBreakdownEstimatedExchangeRateString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEstimateBreakdownEstimatedExchangeRateStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'estimateBreakdownEstimatedExchangeRateString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEstimateBreakdownFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownFromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEstimateBreakdownFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownFromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEstimateBreakdownToAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownToAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByEstimateBreakdownToAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownToAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExpectedFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedFromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExpectedFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedFromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExpectedToAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedToAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExpectedToAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedToAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExternalPartnerLinkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalPartnerLinkId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExternalPartnerLinkIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalPartnerLinkId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExtraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extraId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByExtraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extraId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromAmountInEurString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountInEurString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromAmountInEurStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountInEurString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromCurrencyWithNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyWithNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromCurrencyWithNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyWithNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByFromNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByInitialExpectedFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpectedFromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByInitialExpectedFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpectedFromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByInitialFromCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialFromCurrency', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByInitialFromCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialFromCurrency', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByOutputHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outputHash', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByOutputHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outputHash', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPartnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPartnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPayoutPaymentCategoryString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutPaymentCategoryString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPayoutPaymentCategoryStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutPaymentCategoryString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPayoutType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutType', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPayoutTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutType', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPreauthToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preauthToken', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByPreauthTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preauthToken', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByRedirectUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redirectUrl', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByRedirectUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redirectUrl', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortBySkipChoosePaymentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePaymentCategory', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortBySkipChoosePaymentCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePaymentCategory', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortBySkipChoosePayoutAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePayoutAddress', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortBySkipChoosePayoutAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePayoutAddress', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByStatusDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusDetails', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByStatusDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusDetails', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByStatusString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByStatusStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToCurrencyWithNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyWithNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToCurrencyWithNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyWithNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByToNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension GuardarianTransactionQuerySortThenBy
    on QueryBuilder<GuardarianTransaction, GuardarianTransaction, QSortThenBy> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByCreatedAtTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimestamp', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByCreatedAtTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimestamp', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByCustomerPayoutAddressChangeable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPayoutAddressChangeable', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByCustomerPayoutAddressChangeableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPayoutAddressChangeable', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByDepositPaymentCategoryString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositPaymentCategoryString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByDepositPaymentCategoryStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositPaymentCategoryString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByDepositType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositType', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByDepositTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'depositType', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEstimateBreakdownEstimatedExchangeRateString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'estimateBreakdownEstimatedExchangeRateString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEstimateBreakdownEstimatedExchangeRateStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'estimateBreakdownEstimatedExchangeRateString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEstimateBreakdownFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownFromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEstimateBreakdownFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownFromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEstimateBreakdownToAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownToAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByEstimateBreakdownToAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimateBreakdownToAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExpectedFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedFromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExpectedFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedFromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExpectedToAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedToAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExpectedToAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedToAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExternalPartnerLinkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalPartnerLinkId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExternalPartnerLinkIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalPartnerLinkId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExtraId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extraId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByExtraIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extraId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromAmountInEurString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountInEurString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromAmountInEurStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountInEurString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrency', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromCurrencyWithNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyWithNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromCurrencyWithNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyWithNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByFromNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByInitialExpectedFromAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpectedFromAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByInitialExpectedFromAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpectedFromAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByInitialFromCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialFromCurrency', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByInitialFromCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialFromCurrency', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByOutputHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outputHash', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByOutputHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outputHash', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPartnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPartnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPayoutPaymentCategoryString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutPaymentCategoryString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPayoutPaymentCategoryStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutPaymentCategoryString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPayoutType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutType', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPayoutTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payoutType', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPreauthToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preauthToken', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByPreauthTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preauthToken', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByRedirectUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redirectUrl', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByRedirectUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redirectUrl', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenBySkipChoosePaymentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePaymentCategory', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenBySkipChoosePaymentCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePaymentCategory', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenBySkipChoosePayoutAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePayoutAddress', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenBySkipChoosePayoutAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipChoosePayoutAddress', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByStatusDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusDetails', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByStatusDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusDetails', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByStatusString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByStatusStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToAmountString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmountString', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToAmountStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAmountString', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrency', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToCurrencyWithNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyWithNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToCurrencyWithNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyWithNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToNetwork() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByToNetworkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toNetwork', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.desc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension GuardarianTransactionQueryWhereDistinct
    on QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct> {
  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByCreatedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByCreatedAtTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtTimestamp');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByCustomerPayoutAddressChangeable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerPayoutAddressChangeable');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByDepositPaymentCategoryString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'depositPaymentCategoryString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByDepositType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'depositType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByEstimateBreakdownEstimatedExchangeRateString(
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
          r'estimateBreakdownEstimatedExchangeRateString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByEstimateBreakdownFromAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimateBreakdownFromAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByEstimateBreakdownToAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimateBreakdownToAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByExpectedFromAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedFromAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByExpectedToAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedToAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByExternalPartnerLinkId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'externalPartnerLinkId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByExtraId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extraId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByFromAmountInEurString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromAmountInEurString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByFromAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByFromCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromCurrency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByFromCurrencyWithNetwork({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromCurrencyWithNetwork',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByFromNetwork({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromNetwork', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByInitialExpectedFromAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initialExpectedFromAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByInitialFromCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initialFromCurrency',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByOutputHash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outputHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByPartnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByPayoutPaymentCategoryString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payoutPaymentCategoryString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByPayoutType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payoutType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByPreauthToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preauthToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByRedirectUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'redirectUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctBySkipChoosePaymentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skipChoosePaymentCategory');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctBySkipChoosePayoutAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skipChoosePayoutAddress');
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByStatusDetails({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusDetails',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByStatusString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusString', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByToAmountString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toAmountString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByToCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toCurrency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByToCurrencyWithNetwork({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toCurrencyWithNetwork',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByToNetwork({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toNetwork', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByTransactionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GuardarianTransaction, GuardarianTransaction, QDistinct>
      distinctByUpdatedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }
}

extension GuardarianTransactionQueryProperty on QueryBuilder<
    GuardarianTransaction, GuardarianTransaction, QQueryProperty> {
  QueryBuilder<GuardarianTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GuardarianTransaction, int, QQueryOperations>
      createdAtTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtTimestamp');
    });
  }

  QueryBuilder<GuardarianTransaction, bool?, QQueryOperations>
      customerPayoutAddressChangeableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerPayoutAddressChangeable');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      depositPaymentCategoryStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'depositPaymentCategoryString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      depositTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'depositType');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<GuardarianTransaction, ConvertedAmountEmbedded, QQueryOperations>
      estimateBreakdownConvertedAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateBreakdownConvertedAmount');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      estimateBreakdownEstimatedExchangeRateStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query
          .addPropertyName(r'estimateBreakdownEstimatedExchangeRateString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      estimateBreakdownFromAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateBreakdownFromAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, NetworkFeeEmbedded, QQueryOperations>
      estimateBreakdownNetworkFeeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateBreakdownNetworkFee');
    });
  }

  QueryBuilder<GuardarianTransaction, PartnerFeeEmbedded, QQueryOperations>
      estimateBreakdownPartnerFeeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateBreakdownPartnerFee');
    });
  }

  QueryBuilder<GuardarianTransaction, List<ServiceFeeEmbedded>,
      QQueryOperations> estimateBreakdownServiceFeesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateBreakdownServiceFees');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      estimateBreakdownToAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimateBreakdownToAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      expectedFromAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedFromAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      expectedToAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedToAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      externalPartnerLinkIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalPartnerLinkId');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      extraIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extraId');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      fromAmountInEurStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromAmountInEurString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      fromAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      fromCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromCurrency');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      fromCurrencyWithNetworkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromCurrencyWithNetwork');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      fromNetworkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromNetwork');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      initialExpectedFromAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initialExpectedFromAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      initialFromCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initialFromCurrency');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      outputHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outputHash');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      partnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerId');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      payoutPaymentCategoryStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payoutPaymentCategoryString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      payoutTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payoutType');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      preauthTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preauthToken');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      redirectUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'redirectUrl');
    });
  }

  QueryBuilder<GuardarianTransaction, bool?, QQueryOperations>
      skipChoosePaymentCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skipChoosePaymentCategory');
    });
  }

  QueryBuilder<GuardarianTransaction, bool?, QQueryOperations>
      skipChoosePayoutAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skipChoosePayoutAddress');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      statusDetailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusDetails');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      statusStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      toAmountStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toAmountString');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      toCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toCurrency');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      toCurrencyWithNetworkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toCurrencyWithNetwork');
    });
  }

  QueryBuilder<GuardarianTransaction, String?, QQueryOperations>
      toNetworkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toNetwork');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      transactionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionId');
    });
  }

  QueryBuilder<GuardarianTransaction, String, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ServiceFeeEmbeddedSchema = Schema(
  name: r'ServiceFeeEmbedded',
  id: 9032563974593885268,
  properties: {
    r'amountString': PropertySchema(
      id: 0,
      name: r'amountString',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 1,
      name: r'currency',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _serviceFeeEmbeddedEstimateSize,
  serialize: _serviceFeeEmbeddedSerialize,
  deserialize: _serviceFeeEmbeddedDeserialize,
  deserializeProp: _serviceFeeEmbeddedDeserializeProp,
);

int _serviceFeeEmbeddedEstimateSize(
  ServiceFeeEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amountString.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _serviceFeeEmbeddedSerialize(
  ServiceFeeEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amountString);
  writer.writeString(offsets[1], object.currency);
  writer.writeString(offsets[2], object.name);
}

ServiceFeeEmbedded _serviceFeeEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServiceFeeEmbedded();
  object.amountString = reader.readString(offsets[0]);
  object.currency = reader.readString(offsets[1]);
  object.name = reader.readString(offsets[2]);
  return object;
}

P _serviceFeeEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ServiceFeeEmbeddedQueryFilter
    on QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QFilterCondition> {
  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      amountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ServiceFeeEmbeddedQueryObject
    on QueryBuilder<ServiceFeeEmbedded, ServiceFeeEmbedded, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PartnerFeeEmbeddedSchema = Schema(
  name: r'PartnerFeeEmbedded',
  id: -5901056805260293787,
  properties: {
    r'amountString': PropertySchema(
      id: 0,
      name: r'amountString',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 1,
      name: r'currency',
      type: IsarType.string,
    ),
    r'percentage': PropertySchema(
      id: 2,
      name: r'percentage',
      type: IsarType.string,
    )
  },
  estimateSize: _partnerFeeEmbeddedEstimateSize,
  serialize: _partnerFeeEmbeddedSerialize,
  deserialize: _partnerFeeEmbeddedDeserialize,
  deserializeProp: _partnerFeeEmbeddedDeserializeProp,
);

int _partnerFeeEmbeddedEstimateSize(
  PartnerFeeEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amountString.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.percentage.length * 3;
  return bytesCount;
}

void _partnerFeeEmbeddedSerialize(
  PartnerFeeEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amountString);
  writer.writeString(offsets[1], object.currency);
  writer.writeString(offsets[2], object.percentage);
}

PartnerFeeEmbedded _partnerFeeEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PartnerFeeEmbedded();
  object.amountString = reader.readString(offsets[0]);
  object.currency = reader.readString(offsets[1]);
  object.percentage = reader.readString(offsets[2]);
  return object;
}

P _partnerFeeEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PartnerFeeEmbeddedQueryFilter
    on QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QFilterCondition> {
  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      amountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'percentage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: '',
      ));
    });
  }

  QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QAfterFilterCondition>
      percentageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'percentage',
        value: '',
      ));
    });
  }
}

extension PartnerFeeEmbeddedQueryObject
    on QueryBuilder<PartnerFeeEmbedded, PartnerFeeEmbedded, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NetworkFeeEmbeddedSchema = Schema(
  name: r'NetworkFeeEmbedded',
  id: 4955100353530790290,
  properties: {
    r'amountString': PropertySchema(
      id: 0,
      name: r'amountString',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 1,
      name: r'currency',
      type: IsarType.string,
    )
  },
  estimateSize: _networkFeeEmbeddedEstimateSize,
  serialize: _networkFeeEmbeddedSerialize,
  deserialize: _networkFeeEmbeddedDeserialize,
  deserializeProp: _networkFeeEmbeddedDeserializeProp,
);

int _networkFeeEmbeddedEstimateSize(
  NetworkFeeEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amountString.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  return bytesCount;
}

void _networkFeeEmbeddedSerialize(
  NetworkFeeEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amountString);
  writer.writeString(offsets[1], object.currency);
}

NetworkFeeEmbedded _networkFeeEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NetworkFeeEmbedded();
  object.amountString = reader.readString(offsets[0]);
  object.currency = reader.readString(offsets[1]);
  return object;
}

P _networkFeeEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension NetworkFeeEmbeddedQueryFilter
    on QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QFilterCondition> {
  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      amountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }
}

extension NetworkFeeEmbeddedQueryObject
    on QueryBuilder<NetworkFeeEmbedded, NetworkFeeEmbedded, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ConvertedAmountEmbeddedSchema = Schema(
  name: r'ConvertedAmountEmbedded',
  id: 6411782231654733059,
  properties: {
    r'amountString': PropertySchema(
      id: 0,
      name: r'amountString',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 1,
      name: r'currency',
      type: IsarType.string,
    )
  },
  estimateSize: _convertedAmountEmbeddedEstimateSize,
  serialize: _convertedAmountEmbeddedSerialize,
  deserialize: _convertedAmountEmbeddedDeserialize,
  deserializeProp: _convertedAmountEmbeddedDeserializeProp,
);

int _convertedAmountEmbeddedEstimateSize(
  ConvertedAmountEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amountString.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  return bytesCount;
}

void _convertedAmountEmbeddedSerialize(
  ConvertedAmountEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amountString);
  writer.writeString(offsets[1], object.currency);
}

ConvertedAmountEmbedded _convertedAmountEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConvertedAmountEmbedded();
  object.amountString = reader.readString(offsets[0]);
  object.currency = reader.readString(offsets[1]);
  return object;
}

P _convertedAmountEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ConvertedAmountEmbeddedQueryFilter on QueryBuilder<
    ConvertedAmountEmbedded, ConvertedAmountEmbedded, QFilterCondition> {
  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
          QAfterFilterCondition>
      amountStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amountString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
          QAfterFilterCondition>
      amountStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amountString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> amountStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amountString',
        value: '',
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
          QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
          QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<ConvertedAmountEmbedded, ConvertedAmountEmbedded,
      QAfterFilterCondition> currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }
}

extension ConvertedAmountEmbeddedQueryObject on QueryBuilder<
    ConvertedAmountEmbedded, ConvertedAmountEmbedded, QFilterCondition> {}
