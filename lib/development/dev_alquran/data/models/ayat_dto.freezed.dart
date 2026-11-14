// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ayat_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AyatDto {

 int get nomorAyat; String get teksArab; String get teksLatin; String get teksIndonesia; Map<String, String> get audio;
/// Create a copy of AyatDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyatDtoCopyWith<AyatDto> get copyWith => _$AyatDtoCopyWithImpl<AyatDto>(this as AyatDto, _$identity);

  /// Serializes this AyatDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AyatDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AyatDto&&(identical(other.nomorAyat, _this.nomorAyat) || other.nomorAyat == _this.nomorAyat)&&(identical(other.teksArab, _this.teksArab) || other.teksArab == _this.teksArab)&&(identical(other.teksLatin, _this.teksLatin) || other.teksLatin == _this.teksLatin)&&(identical(other.teksIndonesia, _this.teksIndonesia) || other.teksIndonesia == _this.teksIndonesia)&&const DeepCollectionEquality().equals(other.audio, _this.audio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AyatDto;
  return Object.hash(runtimeType,_this.nomorAyat,_this.teksArab,_this.teksLatin,_this.teksIndonesia,const DeepCollectionEquality().hash(_this.audio));
}

@override
String toString() {
  final _this = this as AyatDto;
  return 'AyatDto(nomorAyat: ${_this.nomorAyat}, teksArab: ${_this.teksArab}, teksLatin: ${_this.teksLatin}, teksIndonesia: ${_this.teksIndonesia}, audio: ${_this.audio})';
}


}

/// @nodoc
abstract mixin class $AyatDtoCopyWith<$Res>  {
  factory $AyatDtoCopyWith(AyatDto value, $Res Function(AyatDto) _then) = _$AyatDtoCopyWithImpl;
@useResult
$Res call({
 int nomorAyat, String teksArab, String teksLatin, String teksIndonesia, Map<String, String> audio
});




}
/// @nodoc
class _$AyatDtoCopyWithImpl<$Res>
    implements $AyatDtoCopyWith<$Res> {
  _$AyatDtoCopyWithImpl(this._self, this._then);

  final AyatDto _self;
  final $Res Function(AyatDto) _then;

/// Create a copy of AyatDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nomorAyat = null,Object? teksArab = null,Object? teksLatin = null,Object? teksIndonesia = null,Object? audio = null,}) {
  return _then(AyatDto(
nomorAyat: null == nomorAyat ? _self.nomorAyat : nomorAyat // ignore: cast_nullable_to_non_nullable
as int,teksArab: null == teksArab ? _self.teksArab : teksArab // ignore: cast_nullable_to_non_nullable
as String,teksLatin: null == teksLatin ? _self.teksLatin : teksLatin // ignore: cast_nullable_to_non_nullable
as String,teksIndonesia: null == teksIndonesia ? _self.teksIndonesia : teksIndonesia // ignore: cast_nullable_to_non_nullable
as String,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AyatDto].
extension AyatDtoPatterns on AyatDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AyatDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AyatDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AyatDto value)  $default,){
final _that = this;
switch (_that) {
case _AyatDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AyatDto value)?  $default,){
final _that = this;
switch (_that) {
case _AyatDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int nomorAyat,  String teksArab,  String teksLatin,  String teksIndonesia,  Map<String, String> audio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AyatDto() when $default != null:
return $default(_that.nomorAyat,_that.teksArab,_that.teksLatin,_that.teksIndonesia,_that.audio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int nomorAyat,  String teksArab,  String teksLatin,  String teksIndonesia,  Map<String, String> audio)  $default,) {final _that = this;
switch (_that) {
case _AyatDto():
return $default(_that.nomorAyat,_that.teksArab,_that.teksLatin,_that.teksIndonesia,_that.audio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int nomorAyat,  String teksArab,  String teksLatin,  String teksIndonesia,  Map<String, String> audio)?  $default,) {final _that = this;
switch (_that) {
case _AyatDto() when $default != null:
return $default(_that.nomorAyat,_that.teksArab,_that.teksLatin,_that.teksIndonesia,_that.audio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AyatDto implements AyatDto {
  const _AyatDto({this.nomorAyat = 0, this.teksArab = '', this.teksLatin = '', this.teksIndonesia = '',  Map<String, String> audio = const <String, String>{}}): _audio = audio;
  factory _AyatDto.fromJson(Map<String, dynamic> json) => _$AyatDtoFromJson(json);

@override@JsonKey() final  int nomorAyat;
@override@JsonKey() final  String teksArab;
@override@JsonKey() final  String teksLatin;
@override@JsonKey() final  String teksIndonesia;
 final  Map<String, String> _audio;
@override@JsonKey() Map<String, String> get audio {
  if (_audio is EqualUnmodifiableMapView) return _audio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_audio);
}


/// Create a copy of AyatDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyatDtoCopyWith<_AyatDto> get copyWith => __$AyatDtoCopyWithImpl<_AyatDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AyatDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AyatDto&&(identical(other.nomorAyat, nomorAyat) || other.nomorAyat == nomorAyat)&&(identical(other.teksArab, teksArab) || other.teksArab == teksArab)&&(identical(other.teksLatin, teksLatin) || other.teksLatin == teksLatin)&&(identical(other.teksIndonesia, teksIndonesia) || other.teksIndonesia == teksIndonesia)&&const DeepCollectionEquality().equals(other.audio, _audio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nomorAyat,teksArab,teksLatin,teksIndonesia,const DeepCollectionEquality().hash(_audio));
}

@override
String toString() {
    return 'AyatDto(nomorAyat: $nomorAyat, teksArab: $teksArab, teksLatin: $teksLatin, teksIndonesia: $teksIndonesia, audio: $audio)';
}


}

/// @nodoc
abstract mixin class _$AyatDtoCopyWith<$Res> implements $AyatDtoCopyWith<$Res> {
  factory _$AyatDtoCopyWith(_AyatDto value, $Res Function(_AyatDto) _then) = __$AyatDtoCopyWithImpl;
@override @useResult
$Res call({
 int nomorAyat, String teksArab, String teksLatin, String teksIndonesia, Map<String, String> audio
});




}
/// @nodoc
class __$AyatDtoCopyWithImpl<$Res>
    implements _$AyatDtoCopyWith<$Res> {
  __$AyatDtoCopyWithImpl(this._self, this._then);

  final _AyatDto _self;
  final $Res Function(_AyatDto) _then;

/// Create a copy of AyatDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nomorAyat = null,Object? teksArab = null,Object? teksLatin = null,Object? teksIndonesia = null,Object? audio = null,}) {
  return _then(_AyatDto(
nomorAyat: null == nomorAyat ? _self.nomorAyat : nomorAyat // ignore: cast_nullable_to_non_nullable
as int,teksArab: null == teksArab ? _self.teksArab : teksArab // ignore: cast_nullable_to_non_nullable
as String,teksLatin: null == teksLatin ? _self.teksLatin : teksLatin // ignore: cast_nullable_to_non_nullable
as String,teksIndonesia: null == teksIndonesia ? _self.teksIndonesia : teksIndonesia // ignore: cast_nullable_to_non_nullable
as String,audio: null == audio ? _self._audio : audio // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
