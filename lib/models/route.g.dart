// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRouteCollection on Isar {
  IsarCollection<Route> get routes => this.collection();
}

const RouteSchema = CollectionSchema(
  name: r'Route',
  id: 2886924706719904506,
  properties: {
    r'isFavorite': PropertySchema(
      id: 0,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'routeColorHexCode': PropertySchema(
      id: 1,
      name: r'routeColorHexCode',
      type: IsarType.string,
    ),
    r'routeDesignator': PropertySchema(
      id: 2,
      name: r'routeDesignator',
      type: IsarType.string,
    ),
    r'routeName': PropertySchema(
      id: 3,
      name: r'routeName',
      type: IsarType.string,
    )
  },
  estimateSize: _routeEstimateSize,
  serialize: _routeSerialize,
  deserialize: _routeDeserialize,
  deserializeProp: _routeDeserializeProp,
  idName: r'routeNumber',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _routeGetId,
  getLinks: _routeGetLinks,
  attach: _routeAttach,
  version: '3.1.0+1',
);

int _routeEstimateSize(
  Route object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.routeColorHexCode.length * 3;
  bytesCount += 3 + object.routeDesignator.length * 3;
  bytesCount += 3 + object.routeName.length * 3;
  return bytesCount;
}

void _routeSerialize(
  Route object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isFavorite);
  writer.writeString(offsets[1], object.routeColorHexCode);
  writer.writeString(offsets[2], object.routeDesignator);
  writer.writeString(offsets[3], object.routeName);
}

Route _routeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Route(
    id,
    reader.readString(offsets[3]),
    reader.readString(offsets[1]),
    reader.readString(offsets[2]),
  );
  object.isFavorite = reader.readBool(offsets[0]);
  return object;
}

P _routeDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _routeGetId(Route object) {
  return object.routeNumber;
}

List<IsarLinkBase<dynamic>> _routeGetLinks(Route object) {
  return [];
}

void _routeAttach(IsarCollection<dynamic> col, Id id, Route object) {}

extension RouteQueryWhereSort on QueryBuilder<Route, Route, QWhere> {
  QueryBuilder<Route, Route, QAfterWhere> anyRouteNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RouteQueryWhere on QueryBuilder<Route, Route, QWhereClause> {
  QueryBuilder<Route, Route, QAfterWhereClause> routeNumberEqualTo(
      Id routeNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: routeNumber,
        upper: routeNumber,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterWhereClause> routeNumberNotEqualTo(
      Id routeNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: routeNumber, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: routeNumber, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: routeNumber, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: routeNumber, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Route, Route, QAfterWhereClause> routeNumberGreaterThan(
      Id routeNumber,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: routeNumber, includeLower: include),
      );
    });
  }

  QueryBuilder<Route, Route, QAfterWhereClause> routeNumberLessThan(
      Id routeNumber,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: routeNumber, includeUpper: include),
      );
    });
  }

  QueryBuilder<Route, Route, QAfterWhereClause> routeNumberBetween(
    Id lowerRouteNumber,
    Id upperRouteNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerRouteNumber,
        includeLower: includeLower,
        upper: upperRouteNumber,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RouteQueryFilter on QueryBuilder<Route, Route, QFilterCondition> {
  QueryBuilder<Route, Route, QAfterFilterCondition> isFavoriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeColorHexCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition>
      routeColorHexCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeColorHexCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeColorHexCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeColorHexCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routeColorHexCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routeColorHexCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routeColorHexCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routeColorHexCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeColorHexCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeColorHexCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition>
      routeColorHexCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routeColorHexCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeDesignator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeDesignator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeDesignator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeDesignator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routeDesignator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routeDesignator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routeDesignator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routeDesignator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeDesignatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeDesignator',
        value: '',
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition>
      routeDesignatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routeDesignator',
        value: '',
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNumberEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNumberGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNumberLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Route, Route, QAfterFilterCondition> routeNumberBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RouteQueryObject on QueryBuilder<Route, Route, QFilterCondition> {}

extension RouteQueryLinks on QueryBuilder<Route, Route, QFilterCondition> {}

extension RouteQuerySortBy on QueryBuilder<Route, Route, QSortBy> {
  QueryBuilder<Route, Route, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByRouteColorHexCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeColorHexCode', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByRouteColorHexCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeColorHexCode', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByRouteDesignator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeDesignator', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByRouteDesignatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeDesignator', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByRouteName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeName', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> sortByRouteNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeName', Sort.desc);
    });
  }
}

extension RouteQuerySortThenBy on QueryBuilder<Route, Route, QSortThenBy> {
  QueryBuilder<Route, Route, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteColorHexCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeColorHexCode', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteColorHexCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeColorHexCode', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteDesignator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeDesignator', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteDesignatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeDesignator', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeName', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeName', Sort.desc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNumber', Sort.asc);
    });
  }

  QueryBuilder<Route, Route, QAfterSortBy> thenByRouteNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNumber', Sort.desc);
    });
  }
}

extension RouteQueryWhereDistinct on QueryBuilder<Route, Route, QDistinct> {
  QueryBuilder<Route, Route, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<Route, Route, QDistinct> distinctByRouteColorHexCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeColorHexCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Route, Route, QDistinct> distinctByRouteDesignator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeDesignator',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Route, Route, QDistinct> distinctByRouteName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeName', caseSensitive: caseSensitive);
    });
  }
}

extension RouteQueryProperty on QueryBuilder<Route, Route, QQueryProperty> {
  QueryBuilder<Route, int, QQueryOperations> routeNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeNumber');
    });
  }

  QueryBuilder<Route, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<Route, String, QQueryOperations> routeColorHexCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeColorHexCode');
    });
  }

  QueryBuilder<Route, String, QQueryOperations> routeDesignatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeDesignator');
    });
  }

  QueryBuilder<Route, String, QQueryOperations> routeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeName');
    });
  }
}
