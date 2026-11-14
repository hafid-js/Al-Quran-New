// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahDetailDto {

 SurahDto get surah; List<AyatDto> get ayat;
/// Create a copy of SurahDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahDetailDtoCopyWith<SurahDetailDto> get copyWith => _$SurahDetailDtoCopyWithImpl<SurahDetailDto>(this as SurahDetailDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SurahDetailDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahDetailDto&&(identical(other.surah, _this.surah) || other.surah == _this.surah)&&const DeepCollectionEquality().equals(other.ayat, _this.ayat));
}


@override
int get hashCode {
  final _this = this as SurahDetailDto;
  return Object.hash(runtimeType,_this.surah,const DeepCollectionEquality().hash(_this.ayat));
}

@override
String toString() {
  final _this = this as SurahDetailDto;
  return 'SurahDetailDto(surah: ${_this.surah}, ayat: ${_this.ayat})';
}


}

/// @nodoc
abstract mixin class $SurahDetailDtoCopyWith<$Res>  {
  factory $SurahDetailDtoCopyWith(SurahDetailDto value, $Res Function(SurahDetailDto) _then) = _$SurahDetailDtoCopyWithImpl;
@useResult
$Res call({
 SurahDto surah, List<AyatDto> ayat
});


$SurahDtoCopyWith<$Res> get surah;

}
/// @nodoc
class _$SurahDetailDtoCopyWithImpl<$Res>
    implements $SurahDetailDtoCopyWith<$Res> {
  _$SurahDetailDtoCopyWithImpl(this._self, this._then);

  final SurahDetailDto _self;
  final $Res Function(SurahDetailDto) _then;

/// Create a copy of SurahDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surah = null,Object? ayat = null,}) {
  return _then(SurahDetailDto(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as SurahDto,ayat: null == ayat ? _self.ayat : ayat // ignore: cast_nullable_to_non_nullable
as List<AyatDto>,
  ));
}
/// Create a copy of SurahDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahDtoCopyWith<$Res> get surah {
  
  return $SurahDtoCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}


/// Adds pattern-matching-related methods to [SurahDetailDto].
extension SurahDetailDtoPatterns on SurahDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _SurahDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _SurahDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SurahDto surah,  List<AyatDto> ayat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahDetailDto() when $default != null:
return $default(_that.surah,_that.ayat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SurahDto surah,  List<AyatDto> ayat)  $default,) {final _that = this;
switch (_that) {
case _SurahDetailDto():
return $default(_that.surah,_that.ayat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SurahDto surah,  List<AyatDto> ayat)?  $default,) {final _that = this;
switch (_that) {
case _SurahDetailDto() when $default != null:
return $default(_that.surah,_that.ayat);case _:
  return null;

}
}

}

/// @nodoc


class _SurahDetailDto implements SurahDetailDto {
  const _SurahDetailDto({required this.surah,  List<AyatDto> ayat = const <AyatDto>[]}): _ayat = ayat;
  

@override final  SurahDto surah;
 final  List<AyatDto> _ayat;
@override@JsonKey() List<AyatDto> get ayat {
  if (_ayat is EqualUnmodifiableListView) return _ayat;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ayat);
}


/// Create a copy of SurahDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahDetailDtoCopyWith<_SurahDetailDto> get copyWith => __$SurahDetailDtoCopyWithImpl<_SurahDetailDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahDetailDto&&(identical(other.surah, surah) || other.surah == surah)&&const DeepCollectionEquality().equals(other.ayat, _ayat));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surah,const DeepCollectionEquality().hash(_ayat));
}

@override
String toString() {
    return 'SurahDetailDto(surah: $surah, ayat: $ayat)';
}


}

/// @nodoc
abstract mixin class _$SurahDetailDtoCopyWith<$Res> implements $SurahDetailDtoCopyWith<$Res> {
  factory _$SurahDetailDtoCopyWith(_SurahDetailDto value, $Res Function(_SurahDetailDto) _then) = __$SurahDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 SurahDto surah, List<AyatDto> ayat
});


@override $SurahDtoCopyWith<$Res> get surah;

}
/// @nodoc
class __$SurahDetailDtoCopyWithImpl<$Res>
    implements _$SurahDetailDtoCopyWith<$Res> {
  __$SurahDetailDtoCopyWithImpl(this._self, this._then);

  final _SurahDetailDto _self;
  final $Res Function(_SurahDetailDto) _then;

/// Create a copy of SurahDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? ayat = null,}) {
  return _then(_SurahDetailDto(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as SurahDto,ayat: null == ayat ? _self._ayat : ayat // ignore: cast_nullable_to_non_nullable
as List<AyatDto>,
  ));
}

/// Create a copy of SurahDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahDtoCopyWith<$Res> get surah {
  
  return $SurahDtoCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}

// dart format on
