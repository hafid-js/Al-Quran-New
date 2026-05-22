// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayat_cache.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAyatCacheCollection on Isar {
  IsarCollection<AyatCache> get ayatCaches => this.collection();
}

const AyatCacheSchema = CollectionSchema(
  name: r'AyatCache',
  id: 1244885588646274443,
  properties: {
    r'audioJson': PropertySchema(
      id: 0,
      name: r'audioJson',
      type: IsarType.string,
    ),
    r'nomorAyat': PropertySchema(
      id: 1,
      name: r'nomorAyat',
      type: IsarType.long,
    ),
    r'teksArab': PropertySchema(
      id: 2,
      name: r'teksArab',
      type: IsarType.string,
    ),
    r'teksIndonesia': PropertySchema(
      id: 3,
      name: r'teksIndonesia',
      type: IsarType.string,
    ),
    r'teksLatin': PropertySchema(
      id: 4,
      name: r'teksLatin',
      type: IsarType.string,
    )
  },
  estimateSize: _ayatCacheEstimateSize,
  serialize: _ayatCacheSerialize,
  deserialize: _ayatCacheDeserialize,
  deserializeProp: _ayatCacheDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'surah': LinkSchema(
      id: -59969923668585353,
      name: r'surah',
      target: r'SurahCache',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _ayatCacheGetId,
  getLinks: _ayatCacheGetLinks,
  attach: _ayatCacheAttach,
  version: '3.1.0+1',
);

int _ayatCacheEstimateSize(
  AyatCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.audioJson.length * 3;
  bytesCount += 3 + object.teksArab.length * 3;
  bytesCount += 3 + object.teksIndonesia.length * 3;
  bytesCount += 3 + object.teksLatin.length * 3;
  return bytesCount;
}

void _ayatCacheSerialize(
  AyatCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioJson);
  writer.writeLong(offsets[1], object.nomorAyat);
  writer.writeString(offsets[2], object.teksArab);
  writer.writeString(offsets[3], object.teksIndonesia);
  writer.writeString(offsets[4], object.teksLatin);
}

AyatCache _ayatCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AyatCache();
  object.audioJson = reader.readString(offsets[0]);
  object.id = id;
  object.nomorAyat = reader.readLong(offsets[1]);
  object.teksArab = reader.readString(offsets[2]);
  object.teksIndonesia = reader.readString(offsets[3]);
  object.teksLatin = reader.readString(offsets[4]);
  return object;
}

P _ayatCacheDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ayatCacheGetId(AyatCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ayatCacheGetLinks(AyatCache object) {
  return [object.surah];
}

void _ayatCacheAttach(IsarCollection<dynamic> col, Id id, AyatCache object) {
  object.id = id;
  object.surah.attach(col, col.isar.collection<SurahCache>(), r'surah', id);
}

extension AyatCacheQueryWhereSort
    on QueryBuilder<AyatCache, AyatCache, QWhere> {
  QueryBuilder<AyatCache, AyatCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AyatCacheQueryWhere
    on QueryBuilder<AyatCache, AyatCache, QWhereClause> {
  QueryBuilder<AyatCache, AyatCache, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<AyatCache, AyatCache, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterWhereClause> idBetween(
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

extension AyatCacheQueryFilter
    on QueryBuilder<AyatCache, AyatCache, QFilterCondition> {
  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      audioJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> audioJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      audioJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> nomorAyatEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomorAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      nomorAyatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomorAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> nomorAyatLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomorAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> nomorAyatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomorAyat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teksArab',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teksArab',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teksArab',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teksArab',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teksArab',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teksArab',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teksArab',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teksArab',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksArabIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teksArab',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksArabIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teksArab',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teksIndonesia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teksIndonesia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teksIndonesia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teksIndonesia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teksIndonesia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teksIndonesia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teksIndonesia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teksIndonesia',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teksIndonesia',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksIndonesiaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teksIndonesia',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teksLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksLatinGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teksLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teksLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teksLatin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teksLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teksLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teksLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teksLatin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> teksLatinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teksLatin',
        value: '',
      ));
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition>
      teksLatinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teksLatin',
        value: '',
      ));
    });
  }
}

extension AyatCacheQueryObject
    on QueryBuilder<AyatCache, AyatCache, QFilterCondition> {}

extension AyatCacheQueryLinks
    on QueryBuilder<AyatCache, AyatCache, QFilterCondition> {
  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> surah(
      FilterQuery<SurahCache> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'surah');
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterFilterCondition> surahIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'surah', 0, true, 0, true);
    });
  }
}

extension AyatCacheQuerySortBy on QueryBuilder<AyatCache, AyatCache, QSortBy> {
  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByAudioJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioJson', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByAudioJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioJson', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByNomorAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByNomorAyatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByTeksArab() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksArab', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByTeksArabDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksArab', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByTeksIndonesia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksIndonesia', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByTeksIndonesiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksIndonesia', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByTeksLatin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksLatin', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> sortByTeksLatinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksLatin', Sort.desc);
    });
  }
}

extension AyatCacheQuerySortThenBy
    on QueryBuilder<AyatCache, AyatCache, QSortThenBy> {
  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByAudioJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioJson', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByAudioJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioJson', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByNomorAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByNomorAyatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByTeksArab() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksArab', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByTeksArabDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksArab', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByTeksIndonesia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksIndonesia', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByTeksIndonesiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksIndonesia', Sort.desc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByTeksLatin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksLatin', Sort.asc);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QAfterSortBy> thenByTeksLatinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teksLatin', Sort.desc);
    });
  }
}

extension AyatCacheQueryWhereDistinct
    on QueryBuilder<AyatCache, AyatCache, QDistinct> {
  QueryBuilder<AyatCache, AyatCache, QDistinct> distinctByAudioJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QDistinct> distinctByNomorAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomorAyat');
    });
  }

  QueryBuilder<AyatCache, AyatCache, QDistinct> distinctByTeksArab(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teksArab', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QDistinct> distinctByTeksIndonesia(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teksIndonesia',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AyatCache, AyatCache, QDistinct> distinctByTeksLatin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teksLatin', caseSensitive: caseSensitive);
    });
  }
}

extension AyatCacheQueryProperty
    on QueryBuilder<AyatCache, AyatCache, QQueryProperty> {
  QueryBuilder<AyatCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AyatCache, String, QQueryOperations> audioJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioJson');
    });
  }

  QueryBuilder<AyatCache, int, QQueryOperations> nomorAyatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomorAyat');
    });
  }

  QueryBuilder<AyatCache, String, QQueryOperations> teksArabProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teksArab');
    });
  }

  QueryBuilder<AyatCache, String, QQueryOperations> teksIndonesiaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teksIndonesia');
    });
  }

  QueryBuilder<AyatCache, String, QQueryOperations> teksLatinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teksLatin');
    });
  }
}
