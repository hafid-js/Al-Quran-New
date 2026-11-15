// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doa_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoaDto {

 int get id; String get grup; String get nama; String get ar; String get tr; String get idn; String get tentang; List<String> get tag;
/// Create a copy of DoaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoaDtoCopyWith<DoaDto> get copyWith => _$DoaDtoCopyWithImpl<DoaDto>(this as DoaDto, _$identity);

  /// Serializes this DoaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DoaDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.grup, _this.grup) || other.grup == _this.grup)&&(identical(other.nama, _this.nama) || other.nama == _this.nama)&&(identical(other.ar, _this.ar) || other.ar == _this.ar)&&(identical(other.tr, _this.tr) || other.tr == _this.tr)&&(identical(other.idn, _this.idn) || other.idn == _this.idn)&&(identical(other.tentang, _this.tentang) || other.tentang == _this.tentang)&&const DeepCollectionEquality().equals(other.tag, _this.tag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DoaDto;
  return Object.hash(runtimeType,_this.id,_this.grup,_this.nama,_this.ar,_this.tr,_this.idn,_this.tentang,const DeepCollectionEquality().hash(_this.tag));
}

@override
String toString() {
  final _this = this as DoaDto;
  return 'DoaDto(id: ${_this.id}, grup: ${_this.grup}, nama: ${_this.nama}, ar: ${_this.ar}, tr: ${_this.tr}, idn: ${_this.idn}, tentang: ${_this.tentang}, tag: ${_this.tag})';
}


}

/// @nodoc
abstract mixin class $DoaDtoCopyWith<$Res>  {
  factory $DoaDtoCopyWith(DoaDto value, $Res Function(DoaDto) _then) = _$DoaDtoCopyWithImpl;
@useResult
$Res call({
 int id, String grup, String nama, String ar, String tr, String idn, String tentang, List<String> tag
});




}
/// @nodoc
class _$DoaDtoCopyWithImpl<$Res>
    implements $DoaDtoCopyWith<$Res> {
  _$DoaDtoCopyWithImpl(this._self, this._then);

  final DoaDto _self;
  final $Res Function(DoaDto) _then;

/// Create a copy of DoaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? grup = null,Object? nama = null,Object? ar = null,Object? tr = null,Object? idn = null,Object? tentang = null,Object? tag = null,}) {
  return _then(DoaDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,grup: null == grup ? _self.grup : grup // ignore: cast_nullable_to_non_nullable
as String,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,ar: null == ar ? _self.ar : ar // ignore: cast_nullable_to_non_nullable
as String,tr: null == tr ? _self.tr : tr // ignore: cast_nullable_to_non_nullable
as String,idn: null == idn ? _self.idn : idn // ignore: cast_nullable_to_non_nullable
as String,tentang: null == tentang ? _self.tentang : tentang // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DoaDto].
extension DoaDtoPatterns on DoaDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoaDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoaDto value)  $default,){
final _that = this;
switch (_that) {
case _DoaDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoaDto value)?  $default,){
final _that = this;
switch (_that) {
case _DoaDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String grup,  String nama,  String ar,  String tr,  String idn,  String tentang,  List<String> tag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoaDto() when $default != null:
return $default(_that.id,_that.grup,_that.nama,_that.ar,_that.tr,_that.idn,_that.tentang,_that.tag);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String grup,  String nama,  String ar,  String tr,  String idn,  String tentang,  List<String> tag)  $default,) {final _that = this;
switch (_that) {
case _DoaDto():
return $default(_that.id,_that.grup,_that.nama,_that.ar,_that.tr,_that.idn,_that.tentang,_that.tag);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String grup,  String nama,  String ar,  String tr,  String idn,  String tentang,  List<String> tag)?  $default,) {final _that = this;
switch (_that) {
case _DoaDto() when $default != null:
return $default(_that.id,_that.grup,_that.nama,_that.ar,_that.tr,_that.idn,_that.tentang,_that.tag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoaDto implements DoaDto {
  const _DoaDto({this.id = 0, this.grup = '', this.nama = '', this.ar = '', this.tr = '', this.idn = '', this.tentang = '',  List<String> tag = const []}): _tag = tag;
  factory _DoaDto.fromJson(Map<String, dynamic> json) => _$DoaDtoFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String grup;
@override@JsonKey() final  String nama;
@override@JsonKey() final  String ar;
@override@JsonKey() final  String tr;
@override@JsonKey() final  String idn;
@override@JsonKey() final  String tentang;
 final  List<String> _tag;
@override@JsonKey() List<String> get tag {
  if (_tag is EqualUnmodifiableListView) return _tag;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tag);
}


/// Create a copy of DoaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoaDtoCopyWith<_DoaDto> get copyWith => __$DoaDtoCopyWithImpl<_DoaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoaDto&&(identical(other.id, id) || other.id == id)&&(identical(other.grup, grup) || other.grup == grup)&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.ar, ar) || other.ar == ar)&&(identical(other.tr, tr) || other.tr == tr)&&(identical(other.idn, idn) || other.idn == idn)&&(identical(other.tentang, tentang) || other.tentang == tentang)&&const DeepCollectionEquality().equals(other.tag, _tag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,grup,nama,ar,tr,idn,tentang,const DeepCollectionEquality().hash(_tag));
}

@override
String toString() {
    return 'DoaDto(id: $id, grup: $grup, nama: $nama, ar: $ar, tr: $tr, idn: $idn, tentang: $tentang, tag: $tag)';
}


}

/// @nodoc
abstract mixin class _$DoaDtoCopyWith<$Res> implements $DoaDtoCopyWith<$Res> {
  factory _$DoaDtoCopyWith(_DoaDto value, $Res Function(_DoaDto) _then) = __$DoaDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String grup, String nama, String ar, String tr, String idn, String tentang, List<String> tag
});




}
/// @nodoc
class __$DoaDtoCopyWithImpl<$Res>
    implements _$DoaDtoCopyWith<$Res> {
  __$DoaDtoCopyWithImpl(this._self, this._then);

  final _DoaDto _self;
  final $Res Function(_DoaDto) _then;

/// Create a copy of DoaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? grup = null,Object? nama = null,Object? ar = null,Object? tr = null,Object? idn = null,Object? tentang = null,Object? tag = null,}) {
  return _then(_DoaDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,grup: null == grup ? _self.grup : grup // ignore: cast_nullable_to_non_nullable
as String,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,ar: null == ar ? _self.ar : ar // ignore: cast_nullable_to_non_nullable
as String,tr: null == tr ? _self.tr : tr // ignore: cast_nullable_to_non_nullable
as String,idn: null == idn ? _self.idn : idn // ignore: cast_nullable_to_non_nullable
as String,tentang: null == tentang ? _self.tentang : tentang // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self._tag : tag // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
