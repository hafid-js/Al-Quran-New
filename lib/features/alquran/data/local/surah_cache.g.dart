// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_cache.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSurahCacheCollection on Isar {
  IsarCollection<SurahCache> get surahCaches => this.collection();
}

const SurahCacheSchema = CollectionSchema(
  name: r'SurahCache',
  id: -5379433120879131482,
  properties: {
    r'arti': PropertySchema(
      id: 0,
      name: r'arti',
      type: IsarType.string,
    ),
    r'audioUrl': PropertySchema(
      id: 1,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'deskripsi': PropertySchema(
      id: 2,
      name: r'deskripsi',
      type: IsarType.string,
    ),
    r'jumlahAyat': PropertySchema(
      id: 3,
      name: r'jumlahAyat',
      type: IsarType.long,
    ),
    r'nama': PropertySchema(
      id: 4,
      name: r'nama',
      type: IsarType.string,
    ),
    r'namaLatin': PropertySchema(
      id: 5,
      name: r'namaLatin',
      type: IsarType.string,
    ),
    r'nomor': PropertySchema(
      id: 6,
      name: r'nomor',
      type: IsarType.long,
    ),
    r'tempatTurun': PropertySchema(
      id: 7,
      name: r'tempatTurun',
      type: IsarType.string,
    )
  },
  estimateSize: _surahCacheEstimateSize,
  serialize: _surahCacheSerialize,
  deserialize: _surahCacheDeserialize,
  deserializeProp: _surahCacheDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'ayat': LinkSchema(
      id: -5983659467070947319,
      name: r'ayat',
      target: r'AyatCache',
      single: false,
      linkName: r'surah',
    )
  },
  embeddedSchemas: {},
  getId: _surahCacheGetId,
  getLinks: _surahCacheGetLinks,
  attach: _surahCacheAttach,
  version: '3.1.0+1',
);

int _surahCacheEstimateSize(
  SurahCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.arti.length * 3;
  bytesCount += 3 + object.audioUrl.length * 3;
  bytesCount += 3 + object.deskripsi.length * 3;
  bytesCount += 3 + object.nama.length * 3;
  bytesCount += 3 + object.namaLatin.length * 3;
  bytesCount += 3 + object.tempatTurun.length * 3;
  return bytesCount;
}

void _surahCacheSerialize(
  SurahCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.arti);
  writer.writeString(offsets[1], object.audioUrl);
  writer.writeString(offsets[2], object.deskripsi);
  writer.writeLong(offsets[3], object.jumlahAyat);
  writer.writeString(offsets[4], object.nama);
  writer.writeString(offsets[5], object.namaLatin);
  writer.writeLong(offsets[6], object.nomor);
  writer.writeString(offsets[7], object.tempatTurun);
}

SurahCache _surahCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SurahCache();
  object.arti = reader.readString(offsets[0]);
  object.audioUrl = reader.readString(offsets[1]);
  object.deskripsi = reader.readString(offsets[2]);
  object.id = id;
  object.jumlahAyat = reader.readLong(offsets[3]);
  object.nama = reader.readString(offsets[4]);
  object.namaLatin = reader.readString(offsets[5]);
  object.nomor = reader.readLong(offsets[6]);
  object.tempatTurun = reader.readString(offsets[7]);
  return object;
}

P _surahCacheDeserializeProp<P>(
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
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _surahCacheGetId(SurahCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _surahCacheGetLinks(SurahCache object) {
  return [object.ayat];
}

void _surahCacheAttach(IsarCollection<dynamic> col, Id id, SurahCache object) {
  object.id = id;
  object.ayat.attach(col, col.isar.collection<AyatCache>(), r'ayat', id);
}

extension SurahCacheQueryWhereSort
    on QueryBuilder<SurahCache, SurahCache, QWhere> {
  QueryBuilder<SurahCache, SurahCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SurahCacheQueryWhere
    on QueryBuilder<SurahCache, SurahCache, QWhereClause> {
  QueryBuilder<SurahCache, SurahCache, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SurahCache, SurahCache, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterWhereClause> idBetween(
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

extension SurahCacheQueryFilter
    on QueryBuilder<SurahCache, SurahCache, QFilterCondition> {
  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arti',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arti',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arti',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arti',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'arti',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'arti',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'arti',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'arti',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arti',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> artiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'arti',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> audioUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      audioUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> audioUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> audioUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> audioUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> audioUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> deskripsiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      deskripsiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> deskripsiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> deskripsiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deskripsi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      deskripsiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> deskripsiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> deskripsiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deskripsi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> deskripsiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deskripsi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      deskripsiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deskripsi',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      deskripsiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deskripsi',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> jumlahAyatEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jumlahAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      jumlahAyatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jumlahAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      jumlahAyatLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jumlahAyat',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> jumlahAyatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jumlahAyat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaEqualTo(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaGreaterThan(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLessThan(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaBetween(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaStartsWith(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaEndsWith(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaContains(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaMatches(
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

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nama',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLatinEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namaLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      namaLatinGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'namaLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLatinLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'namaLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLatinBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'namaLatin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      namaLatinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'namaLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLatinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'namaLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLatinContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'namaLatin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> namaLatinMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'namaLatin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      namaLatinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namaLatin',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      namaLatinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'namaLatin',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> nomorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomor',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> nomorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomor',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> nomorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomor',
        value: value,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> nomorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempatTurun',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tempatTurun',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tempatTurun',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tempatTurun',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tempatTurun',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tempatTurun',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tempatTurun',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tempatTurun',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempatTurun',
        value: '',
      ));
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      tempatTurunIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tempatTurun',
        value: '',
      ));
    });
  }
}

extension SurahCacheQueryObject
    on QueryBuilder<SurahCache, SurahCache, QFilterCondition> {}

extension SurahCacheQueryLinks
    on QueryBuilder<SurahCache, SurahCache, QFilterCondition> {
  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> ayat(
      FilterQuery<AyatCache> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ayat');
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> ayatLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayat', length, true, length, true);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> ayatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayat', 0, true, 0, true);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> ayatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayat', 0, false, 999999, true);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      ayatLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayat', 0, true, length, include);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition>
      ayatLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayat', length, include, 999999, true);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterFilterCondition> ayatLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'ayat', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SurahCacheQuerySortBy
    on QueryBuilder<SurahCache, SurahCache, QSortBy> {
  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByArti() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arti', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByArtiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arti', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByDeskripsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deskripsi', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByDeskripsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deskripsi', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByJumlahAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahAyat', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByJumlahAyatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahAyat', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByNama() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByNamaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByNamaLatin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaLatin', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByNamaLatinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaLatin', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByNomor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomor', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByNomorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomor', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByTempatTurun() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempatTurun', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> sortByTempatTurunDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempatTurun', Sort.desc);
    });
  }
}

extension SurahCacheQuerySortThenBy
    on QueryBuilder<SurahCache, SurahCache, QSortThenBy> {
  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByArti() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arti', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByArtiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arti', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByDeskripsi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deskripsi', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByDeskripsiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deskripsi', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByJumlahAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahAyat', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByJumlahAyatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jumlahAyat', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByNama() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByNamaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nama', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByNamaLatin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaLatin', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByNamaLatinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaLatin', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByNomor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomor', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByNomorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomor', Sort.desc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByTempatTurun() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempatTurun', Sort.asc);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QAfterSortBy> thenByTempatTurunDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempatTurun', Sort.desc);
    });
  }
}

extension SurahCacheQueryWhereDistinct
    on QueryBuilder<SurahCache, SurahCache, QDistinct> {
  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByArti(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arti', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByDeskripsi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deskripsi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByJumlahAyat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jumlahAyat');
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByNama(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nama', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByNamaLatin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namaLatin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByNomor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomor');
    });
  }

  QueryBuilder<SurahCache, SurahCache, QDistinct> distinctByTempatTurun(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempatTurun', caseSensitive: caseSensitive);
    });
  }
}

extension SurahCacheQueryProperty
    on QueryBuilder<SurahCache, SurahCache, QQueryProperty> {
  QueryBuilder<SurahCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SurahCache, String, QQueryOperations> artiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arti');
    });
  }

  QueryBuilder<SurahCache, String, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<SurahCache, String, QQueryOperations> deskripsiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deskripsi');
    });
  }

  QueryBuilder<SurahCache, int, QQueryOperations> jumlahAyatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jumlahAyat');
    });
  }

  QueryBuilder<SurahCache, String, QQueryOperations> namaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nama');
    });
  }

  QueryBuilder<SurahCache, String, QQueryOperations> namaLatinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namaLatin');
    });
  }

  QueryBuilder<SurahCache, int, QQueryOperations> nomorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomor');
    });
  }

  QueryBuilder<SurahCache, String, QQueryOperations> tempatTurunProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempatTurun');
    });
  }
}
