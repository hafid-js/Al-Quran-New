// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_surah_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailSurahEvent {

 int get nomor;
/// Create a copy of DetailSurahEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailSurahEventCopyWith<DetailSurahEvent> get copyWith => _$DetailSurahEventCopyWithImpl<DetailSurahEvent>(this as DetailSurahEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DetailSurahEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailSurahEvent&&(identical(other.nomor, _this.nomor) || other.nomor == _this.nomor));
}


@override
int get hashCode {
  final _this = this as DetailSurahEvent;
  return Object.hash(runtimeType,_this.nomor);
}

@override
String toString() {
  final _this = this as DetailSurahEvent;
  return 'DetailSurahEvent(nomor: ${_this.nomor})';
}


}

/// @nodoc
abstract mixin class $DetailSurahEventCopyWith<$Res>  {
  factory $DetailSurahEventCopyWith(DetailSurahEvent value, $Res Function(DetailSurahEvent) _then) = _$DetailSurahEventCopyWithImpl;
@useResult
$Res call({
 int nomor
});




}
/// @nodoc
class _$DetailSurahEventCopyWithImpl<$Res>
    implements $DetailSurahEventCopyWith<$Res> {
  _$DetailSurahEventCopyWithImpl(this._self, this._then);

  final DetailSurahEvent _self;
  final $Res Function(DetailSurahEvent) _then;

/// Create a copy of DetailSurahEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nomor = null,}) {
  return _then(DetailSurahEvent.fetch(
nomor: null == nomor ? _self.nomor : nomor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DetailSurahEvent].
extension DetailSurahEventPatterns on DetailSurahEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchDetailSurah value)?  fetch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchDetailSurah() when fetch != null:
return fetch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchDetailSurah value)  fetch,}){
final _that = this;
switch (_that) {
case FetchDetailSurah():
return fetch(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchDetailSurah value)?  fetch,}){
final _that = this;
switch (_that) {
case FetchDetailSurah() when fetch != null:
return fetch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int nomor)?  fetch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchDetailSurah() when fetch != null:
return fetch(_that.nomor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int nomor)  fetch,}) {final _that = this;
switch (_that) {
case FetchDetailSurah():
return fetch(_that.nomor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int nomor)?  fetch,}) {final _that = this;
switch (_that) {
case FetchDetailSurah() when fetch != null:
return fetch(_that.nomor);case _:
  return null;

}
}

}

/// @nodoc


class FetchDetailSurah implements DetailSurahEvent {
  const FetchDetailSurah({required this.nomor});
  

@override final  int nomor;

/// Create a copy of DetailSurahEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchDetailSurahCopyWith<FetchDetailSurah> get copyWith => _$FetchDetailSurahCopyWithImpl<FetchDetailSurah>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchDetailSurah&&(identical(other.nomor, nomor) || other.nomor == nomor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,nomor);
}

@override
String toString() {
    return 'DetailSurahEvent.fetch(nomor: $nomor)';
}


}

/// @nodoc
abstract mixin class $FetchDetailSurahCopyWith<$Res> implements $DetailSurahEventCopyWith<$Res> {
  factory $FetchDetailSurahCopyWith(FetchDetailSurah value, $Res Function(FetchDetailSurah) _then) = _$FetchDetailSurahCopyWithImpl;
@override @useResult
$Res call({
 int nomor
});




}
/// @nodoc
class _$FetchDetailSurahCopyWithImpl<$Res>
    implements $FetchDetailSurahCopyWith<$Res> {
  _$FetchDetailSurahCopyWithImpl(this._self, this._then);

  final FetchDetailSurah _self;
  final $Res Function(FetchDetailSurah) _then;

/// Create a copy of DetailSurahEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nomor = null,}) {
  return _then(FetchDetailSurah(
nomor: null == nomor ? _self.nomor : nomor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
