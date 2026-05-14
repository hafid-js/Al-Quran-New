// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookmarkModelCollection on Isar {
  IsarCollection<BookmarkModel> get bookmarkModels => this.collection();
}

const BookmarkModelSchema = CollectionSchema(
  name: r'BookmarkModel',
  id: -2869850630043177974,
  properties: {
    r'ayatNumber': PropertySchema(
      id: 0,
      name: r'ayatNumber',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'surahName': PropertySchema(
      id: 2,
      name: r'surahName',
      type: IsarType.string,
    ),
    r'surahNumber': PropertySchema(
      id: 3,
      name: r'surahNumber',
      type: IsarType.long,
    )
  },
  estimateSize: _bookmarkModelEstimateSize,
  serialize: _bookmarkModelSerialize,
  deserialize: _bookmarkModelDeserialize,
  deserializeProp: _bookmarkModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bookmarkModelGetId,
  getLinks: _bookmarkModelGetLinks,
  attach: _bookmarkModelAttach,
  version: '3.1.0+1',
);

int _bookmarkModelEstimateSize(
  BookmarkModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.surahName.length * 3;
  return bytesCount;
}

void _bookmarkModelSerialize(
  BookmarkModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ayatNumber);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.surahName);
  writer.writeLong(offsets[3], object.surahNumber);
}

BookmarkModel _bookmarkModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookmarkModel();
  object.ayatNumber = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.surahName = reader.readString(offsets[2]);
  object.surahNumber = reader.readLong(offsets[3]);
  return object;
}

P _bookmarkModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookmarkModelGetId(BookmarkModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookmarkModelGetLinks(BookmarkModel object) {
  return [];
}

void _bookmarkModelAttach(
    IsarCollection<dynamic> col, Id id, BookmarkModel object) {
  object.id = id;
}

extension BookmarkModelQueryWhereSort
    on QueryBuilder<BookmarkModel, BookmarkModel, QWhere> {
  QueryBuilder<BookmarkModel, BookmarkModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookmarkModelQueryWhere
    on QueryBuilder<BookmarkModel, BookmarkModel, QWhereClause> {
  QueryBuilder<BookmarkModel, BookmarkModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterWhereClause> idBetween(
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

extension BookmarkModelQueryFilter
    on QueryBuilder<BookmarkModel, BookmarkModel, QFilterCondition> {
  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      ayatNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayatNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      ayatNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ayatNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      ayatNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ayatNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      ayatNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ayatNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'surahName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'surahName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahName',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'surahName',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterFilterCondition>
      surahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookmarkModelQueryObject
    on QueryBuilder<BookmarkModel, BookmarkModel, QFilterCondition> {}

extension BookmarkModelQueryLinks
    on QueryBuilder<BookmarkModel, BookmarkModel, QFilterCondition> {}

extension BookmarkModelQuerySortBy
    on QueryBuilder<BookmarkModel, BookmarkModel, QSortBy> {
  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> sortByAyatNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayatNumber', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      sortByAyatNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayatNumber', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> sortBySurahName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      sortBySurahNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> sortBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      sortBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }
}

extension BookmarkModelQuerySortThenBy
    on QueryBuilder<BookmarkModel, BookmarkModel, QSortThenBy> {
  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> thenByAyatNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayatNumber', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      thenByAyatNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayatNumber', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> thenBySurahName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      thenBySurahNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahName', Sort.desc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy> thenBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QAfterSortBy>
      thenBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }
}

extension BookmarkModelQueryWhereDistinct
    on QueryBuilder<BookmarkModel, BookmarkModel, QDistinct> {
  QueryBuilder<BookmarkModel, BookmarkModel, QDistinct> distinctByAyatNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayatNumber');
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QDistinct> distinctBySurahName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkModel, BookmarkModel, QDistinct>
      distinctBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNumber');
    });
  }
}

extension BookmarkModelQueryProperty
    on QueryBuilder<BookmarkModel, BookmarkModel, QQueryProperty> {
  QueryBuilder<BookmarkModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookmarkModel, int, QQueryOperations> ayatNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayatNumber');
    });
  }

  QueryBuilder<BookmarkModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<BookmarkModel, String, QQueryOperations> surahNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahName');
    });
  }

  QueryBuilder<BookmarkModel, int, QQueryOperations> surahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNumber');
    });
  }
}
