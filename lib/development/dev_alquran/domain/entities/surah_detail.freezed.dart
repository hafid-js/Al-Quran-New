// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahDetail {

 Surah get surah; List<Ayat> get ayat;
/// Create a copy of SurahDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahDetailCopyWith<SurahDetail> get copyWith => _$SurahDetailCopyWithImpl<SurahDetail>(this as SurahDetail, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SurahDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahDetail&&(identical(other.surah, _this.surah) || other.surah == _this.surah)&&const DeepCollectionEquality().equals(other.ayat, _this.ayat));
}


@override
int get hashCode {
  final _this = this as SurahDetail;
  return Object.hash(runtimeType,_this.surah,const DeepCollectionEquality().hash(_this.ayat));
}

@override
String toString() {
  final _this = this as SurahDetail;
  return 'SurahDetail(surah: ${_this.surah}, ayat: ${_this.ayat})';
}


}

/// @nodoc
abstract mixin class $SurahDetailCopyWith<$Res>  {
  factory $SurahDetailCopyWith(SurahDetail value, $Res Function(SurahDetail) _then) = _$SurahDetailCopyWithImpl;
@useResult
$Res call({
 Surah surah, List<Ayat> ayat
});


$SurahCopyWith<$Res> get surah;

}
/// @nodoc
class _$SurahDetailCopyWithImpl<$Res>
    implements $SurahDetailCopyWith<$Res> {
  _$SurahDetailCopyWithImpl(this._self, this._then);

  final SurahDetail _self;
  final $Res Function(SurahDetail) _then;

/// Create a copy of SurahDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surah = null,Object? ayat = null,}) {
  return _then(SurahDetail(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,ayat: null == ayat ? _self.ayat : ayat // ignore: cast_nullable_to_non_nullable
as List<Ayat>,
  ));
}
/// Create a copy of SurahDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}


/// Adds pattern-matching-related methods to [SurahDetail].
extension SurahDetailPatterns on SurahDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahDetail value)  $default,){
final _that = this;
switch (_that) {
case _SurahDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SurahDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Surah surah,  List<Ayat> ayat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahDetail() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Surah surah,  List<Ayat> ayat)  $default,) {final _that = this;
switch (_that) {
case _SurahDetail():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Surah surah,  List<Ayat> ayat)?  $default,) {final _that = this;
switch (_that) {
case _SurahDetail() when $default != null:
return $default(_that.surah,_that.ayat);case _:
  return null;

}
}

}

/// @nodoc


class _SurahDetail implements SurahDetail {
  const _SurahDetail({required this.surah,  List<Ayat> ayat = const <Ayat>[]}): _ayat = ayat;
  

@override final  Surah surah;
 final  List<Ayat> _ayat;
@override@JsonKey() List<Ayat> get ayat {
  if (_ayat is EqualUnmodifiableListView) return _ayat;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ayat);
}


/// Create a copy of SurahDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahDetailCopyWith<_SurahDetail> get copyWith => __$SurahDetailCopyWithImpl<_SurahDetail>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahDetail&&(identical(other.surah, surah) || other.surah == surah)&&const DeepCollectionEquality().equals(other.ayat, _ayat));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surah,const DeepCollectionEquality().hash(_ayat));
}

@override
String toString() {
    return 'SurahDetail(surah: $surah, ayat: $ayat)';
}


}

/// @nodoc
abstract mixin class _$SurahDetailCopyWith<$Res> implements $SurahDetailCopyWith<$Res> {
  factory _$SurahDetailCopyWith(_SurahDetail value, $Res Function(_SurahDetail) _then) = __$SurahDetailCopyWithImpl;
@override @useResult
$Res call({
 Surah surah, List<Ayat> ayat
});


@override $SurahCopyWith<$Res> get surah;

}
/// @nodoc
class __$SurahDetailCopyWithImpl<$Res>
    implements _$SurahDetailCopyWith<$Res> {
  __$SurahDetailCopyWithImpl(this._self, this._then);

  final _SurahDetail _self;
  final $Res Function(_SurahDetail) _then;

/// Create a copy of SurahDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? ayat = null,}) {
  return _then(_SurahDetail(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,ayat: null == ayat ? _self._ayat : ayat // ignore: cast_nullable_to_non_nullable
as List<Ayat>,
  ));
}

/// Create a copy of SurahDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}

// dart format on
