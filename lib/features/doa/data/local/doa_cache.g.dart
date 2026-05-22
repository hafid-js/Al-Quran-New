// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doa_cache.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoaCacheCollection on Isar {
  IsarCollection<DoaCache> get doaCaches => this.collection();
}

const DoaCacheSchema = CollectionSchema(
  name: r'DoaCache',
  id: 9073236057738889174,
  properties: {
    r'ar': PropertySchema(
      id: 0,
      name: r'ar',
      type: IsarType.string,
    ),
    r'doaId': PropertySchema(
      id: 1,
      name: r'doaId',
      type: IsarType.long,
    ),
    r'grup': PropertySchema(
      id: 2,
      name: r'grup',
      type: IsarType.string,
    ),
    r'idn': PropertySchema(
      id: 3,
      name: r'idn',
      type: IsarType.string,
    ),
    r'nama': PropertySchema(
      id: 4,
      name: r'nama',
      type: IsarType.string,
    ),
    r'tagJson': PropertySchema(
      id: 5,
      name: r'tagJson',
      type: IsarType.string,
    ),
    r'tentang': PropertySchema(
      id: 6,
      name: r'tentang',
      type: IsarType.string,
    ),
    r'tr': PropertySchema(
      id: 7,
      name: r'tr',
      type: IsarType.string,
    )
  },
  estimateSize: _doaCacheEstimateSize,
  serialize: _doaCacheSerialize,
  deserialize: _doaCacheDeserialize,
  deserializeProp: _doaCacheDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _doaCacheGetId,
  getLinks: _doaCacheGetLinks,
  attach: _doaCacheAttach,
  version: '3.1.0+1',
);

int _doaCacheEstimateSize(
  DoaCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ar.length * 3;
  bytesCount += 3 + object.grup.length * 3;
  bytesCount += 3 + object.idn.length * 3;
  bytesCount += 3 + object.nama.length * 3;
  bytesCount += 3 + object.tagJson.length * 3;
  bytesCount += 3 + object.tentang.length * 3;
  bytesCount += 3 + object.tr.length * 3;
  return bytesCount;
}

void _doaCacheSerialize(
  DoaCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ar);
  writer.writeLong(offsets[1], object.doaId);
  writer.writeString(offsets[2], object.grup);
  writer.writeString(offsets[3], object.idn);
  writer.writeString(offsets[4], object.nama);
  writer.writeString(offsets[5], object.tagJson);
  writer.writeString(offsets[6], object.tentang);
  writer.writeString(offsets[7], object.tr);
}

DoaCache _doaCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoaCache();
  object.ar = reader.readString(offsets[0]);
  object.doaId = reader.readLong(offsets[1]);
  object.grup = reader.readString(offsets[2]);
  object.id = id;
  object.idn = reader.readString(offsets[3]);
  object.nama = reader.readString(offsets[4]);
  object.tagJson = reader.readString(offsets[5]);
  object.tentang = reader.readString(offsets[6]);
  object.tr = reader.readString(offsets[7]);
  return object;
}

P _doaCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
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
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _doaCacheGetId(DoaCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doaCacheGetLinks(DoaCache object) {
  return [];
}

void _doaCacheAttach(IsarCollection<dynamic> col, Id id, DoaCache object) {
  object.id = id;
}

extension DoaCacheQueryWhereSort on QueryBuilder<DoaCache, DoaCache, QWhere> {
  QueryBuilder<DoaCache, DoaCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DoaCacheQueryWhere on QueryBuilder<DoaCache, DoaCache, QWhereClause> {
  QueryBuilder<DoaCache, DoaCache, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DoaCache, DoaCache, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterWhereClause> idBetween(
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
}

extension DoaCacheQueryFilter
    on QueryBuilder<DoaCache, DoaCache, QFilterCondition> {
  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ar',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> arIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ar',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> doaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> doaIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> doaIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doaId',
        value: value,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> doaIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'grup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'grup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'grup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'grup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grup',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> grupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'grup',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idn',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> idnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idn',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nama',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nama',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nama',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> namaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tagJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tentang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tentang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tentang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tentang',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tentang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tentang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tentang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tentang',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tentang',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> tentangIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tentang',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tr',
        value: '',
      ));
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterFilterCondition> trIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tr',
        value: '',
      ));
    });
  }
}

extension DoaCacheQueryObject
    on QueryBuilder<DoaCache, DoaCache, QFilterCondition> {}

extension DoaCacheQueryLinks
    on QueryBuilder<DoaCache, DoaCache, QFilterCondition> {}

extension DoaCacheQuerySortBy on QueryBuilder<DoaCache, DoaCache, QSortBy> {
  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByAr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ar', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByArDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ar', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByDoaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doaId', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByDoaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doaId', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByGrup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grup', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByGrupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grup', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByIdn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idn', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByIdnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idn', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByNama() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByNamaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByTagJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagJson', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByTagJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagJson', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByTentang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tentang', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByTentangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tentang', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByTr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tr', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> sortByTrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tr', Sort.desc);
    });
  }
}

extension DoaCacheQuerySortThenBy
    on QueryBuilder<DoaCache, DoaCache, QSortThenBy> {
  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByAr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ar', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByArDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ar', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByDoaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doaId', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByDoaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doaId', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByGrup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grup', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByGrupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grup', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByIdn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idn', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByIdnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idn', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByNama() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByNamaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByTagJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagJson', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByTagJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagJson', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByTentang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tentang', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByTentangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tentang', Sort.desc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByTr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tr', Sort.asc);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QAfterSortBy> thenByTrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tr', Sort.desc);
    });
  }
}

extension DoaCacheQueryWhereDistinct
    on QueryBuilder<DoaCache, DoaCache, QDistinct> {
  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByAr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByDoaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doaId');
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByGrup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByIdn(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByNama(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nama', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByTagJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByTentang(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tentang', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoaCache, DoaCache, QDistinct> distinctByTr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tr', caseSensitive: caseSensitive);
    });
  }
}

extension DoaCacheQueryProperty
    on QueryBuilder<DoaCache, DoaCache, QQueryProperty> {
  QueryBuilder<DoaCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> arProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ar');
    });
  }

  QueryBuilder<DoaCache, int, QQueryOperations> doaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doaId');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> grupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grup');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> idnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idn');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> namaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nama');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> tagJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagJson');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> tentangProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tentang');
    });
  }

  QueryBuilder<DoaCache, String, QQueryOperations> trProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tr');
    });
  }
}
