// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir_cache.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTafsirCacheCollection on Isar {
  IsarCollection<TafsirCache> get tafsirCaches => this.collection();
}

const TafsirCacheSchema = CollectionSchema(
  name: r'TafsirCache',
  id: 2798187596839603682,
  properties: {
    r'nomorAyat': PropertySchema(
      id: 0,
      name: r'nomorAyat',
      type: IsarType.long,
    ),
    r'nomorSurah': PropertySchema(
      id: 1,
      name: r'nomorSurah',
      type: IsarType.long,
    ),
    r'tafsir': PropertySchema(
      id: 2,
      name: r'tafsir',
      type: IsarType.string,
    )
  },
  estimateSize: _tafsirCacheEstimateSize,
  serialize: _tafsirCacheSerialize,
  deserialize: _tafsirCacheDeserialize,
  deserializeProp: _tafsirCacheDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tafsirCacheGetId,
  getLinks: _tafsirCacheGetLinks,
  attach: _tafsirCacheAttach,
  version: '3.1.0+1',
);

int _tafsirCacheEstimateSize(
  TafsirCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.tafsir.length * 3;
  return bytesCount;
}

void _tafsirCacheSerialize(
  TafsirCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.nomorAyat);
  writer.writeLong(offsets[1], object.nomorSurah);
  writer.writeString(offsets[2], object.tafsir);
}

TafsirCache _tafsirCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TafsirCache();
  object.id = id;
  object.nomorAyat = reader.readLong(offsets[0]);
  object.nomorSurah = reader.readLong(offsets[1]);
  object.tafsir = reader.readString(offsets[2]);
  return object;
}

P _tafsirCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tafsirCacheGetId(TafsirCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tafsirCacheGetLinks(TafsirCache object) {
  return [];
}

void _tafsirCacheAttach(
    IsarCollection<dynamic> col, Id id, TafsirCache object) {
  object.id = id;
}

extension TafsirCacheQueryWhereSort
    on QueryBuilder<TafsirCache, TafsirCache, QWhere> {
  QueryBuilder<TafsirCache, TafsirCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TafsirCacheQueryWhere
    on QueryBuilder<TafsirCache, TafsirCache, QWhereClause> {
  QueryBuilder<TafsirCache, TafsirCache, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterWhereClause> idBetween(
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

extension TafsirCacheQueryFilter
    on QueryBuilder<TafsirCache, TafsirCache, QFilterCondition> {
  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorAyatEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomorAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorAyatLessThan(
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorAyatBetween(
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

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorSurahEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomorSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorSurahGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomorSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorSurahLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomorSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      nomorSurahBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomorSurah',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> tafsirEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tafsir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      tafsirGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tafsir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> tafsirLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tafsir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> tafsirBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tafsir',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      tafsirStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tafsir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> tafsirEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tafsir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> tafsirContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tafsir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition> tafsirMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tafsir',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      tafsirIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tafsir',
        value: '',
      ));
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterFilterCondition>
      tafsirIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tafsir',
        value: '',
      ));
    });
  }
}

extension TafsirCacheQueryObject
    on QueryBuilder<TafsirCache, TafsirCache, QFilterCondition> {}

extension TafsirCacheQueryLinks
    on QueryBuilder<TafsirCache, TafsirCache, QFilterCondition> {}

extension TafsirCacheQuerySortBy
    on QueryBuilder<TafsirCache, TafsirCache, QSortBy> {
  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> sortByNomorAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> sortByNomorAyatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.desc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> sortByNomorSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorSurah', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> sortByNomorSurahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorSurah', Sort.desc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> sortByTafsir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tafsir', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> sortByTafsirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tafsir', Sort.desc);
    });
  }
}

extension TafsirCacheQuerySortThenBy
    on QueryBuilder<TafsirCache, TafsirCache, QSortThenBy> {
  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByNomorAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByNomorAyatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorAyat', Sort.desc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByNomorSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorSurah', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByNomorSurahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorSurah', Sort.desc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByTafsir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tafsir', Sort.asc);
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QAfterSortBy> thenByTafsirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tafsir', Sort.desc);
    });
  }
}

extension TafsirCacheQueryWhereDistinct
    on QueryBuilder<TafsirCache, TafsirCache, QDistinct> {
  QueryBuilder<TafsirCache, TafsirCache, QDistinct> distinctByNomorAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomorAyat');
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QDistinct> distinctByNomorSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomorSurah');
    });
  }

  QueryBuilder<TafsirCache, TafsirCache, QDistinct> distinctByTafsir(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tafsir', caseSensitive: caseSensitive);
    });
  }
}

extension TafsirCacheQueryProperty
    on QueryBuilder<TafsirCache, TafsirCache, QQueryProperty> {
  QueryBuilder<TafsirCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TafsirCache, int, QQueryOperations> nomorAyatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomorAyat');
    });
  }

  QueryBuilder<TafsirCache, int, QQueryOperations> nomorSurahProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomorSurah');
    });
  }

  QueryBuilder<TafsirCache, String, QQueryOperations> tafsirProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tafsir');
    });
  }
}
