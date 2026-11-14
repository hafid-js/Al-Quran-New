// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_surah_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailSurahState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailSurahState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DetailSurahState()';
}


}

/// @nodoc
class $DetailSurahStateCopyWith<$Res>  {
$DetailSurahStateCopyWith(DetailSurahState _, $Res Function(DetailSurahState) __);
}


/// Adds pattern-matching-related methods to [DetailSurahState].
extension DetailSurahStatePatterns on DetailSurahState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DetailSurahInitial value)?  initial,TResult Function( DetailSurahLoading value)?  loading,TResult Function( DetailSurahLoaded value)?  loaded,TResult Function( DetailSurahFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DetailSurahInitial() when initial != null:
return initial(_that);case DetailSurahLoading() when loading != null:
return loading(_that);case DetailSurahLoaded() when loaded != null:
return loaded(_that);case DetailSurahFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DetailSurahInitial value)  initial,required TResult Function( DetailSurahLoading value)  loading,required TResult Function( DetailSurahLoaded value)  loaded,required TResult Function( DetailSurahFailure value)  failure,}){
final _that = this;
switch (_that) {
case DetailSurahInitial():
return initial(_that);case DetailSurahLoading():
return loading(_that);case DetailSurahLoaded():
return loaded(_that);case DetailSurahFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DetailSurahInitial value)?  initial,TResult? Function( DetailSurahLoading value)?  loading,TResult? Function( DetailSurahLoaded value)?  loaded,TResult? Function( DetailSurahFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DetailSurahInitial() when initial != null:
return initial(_that);case DetailSurahLoading() when loading != null:
return loading(_that);case DetailSurahLoaded() when loaded != null:
return loaded(_that);case DetailSurahFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SurahDetail detail)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DetailSurahInitial() when initial != null:
return initial();case DetailSurahLoading() when loading != null:
return loading();case DetailSurahLoaded() when loaded != null:
return loaded(_that.detail);case DetailSurahFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SurahDetail detail)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case DetailSurahInitial():
return initial();case DetailSurahLoading():
return loading();case DetailSurahLoaded():
return loaded(_that.detail);case DetailSurahFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SurahDetail detail)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case DetailSurahInitial() when initial != null:
return initial();case DetailSurahLoading() when loading != null:
return loading();case DetailSurahLoaded() when loaded != null:
return loaded(_that.detail);case DetailSurahFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DetailSurahInitial implements DetailSurahState {
  const DetailSurahInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailSurahInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DetailSurahState.initial()';
}


}




/// @nodoc


class DetailSurahLoading implements DetailSurahState {
  const DetailSurahLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailSurahLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DetailSurahState.loading()';
}


}




/// @nodoc


class DetailSurahLoaded implements DetailSurahState {
  const DetailSurahLoaded({required this.detail});
  

 final  SurahDetail detail;

/// Create a copy of DetailSurahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailSurahLoadedCopyWith<DetailSurahLoaded> get copyWith => _$DetailSurahLoadedCopyWithImpl<DetailSurahLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailSurahLoaded&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode {
    return Object.hash(runtimeType,detail);
}

@override
String toString() {
    return 'DetailSurahState.loaded(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $DetailSurahLoadedCopyWith<$Res> implements $DetailSurahStateCopyWith<$Res> {
  factory $DetailSurahLoadedCopyWith(DetailSurahLoaded value, $Res Function(DetailSurahLoaded) _then) = _$DetailSurahLoadedCopyWithImpl;
@useResult
$Res call({
 SurahDetail detail
});


$SurahDetailCopyWith<$Res> get detail;

}
/// @nodoc
class _$DetailSurahLoadedCopyWithImpl<$Res>
    implements $DetailSurahLoadedCopyWith<$Res> {
  _$DetailSurahLoadedCopyWithImpl(this._self, this._then);

  final DetailSurahLoaded _self;
  final $Res Function(DetailSurahLoaded) _then;

/// Create a copy of DetailSurahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = null,}) {
  return _then(DetailSurahLoaded(
detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as SurahDetail,
  ));
}

/// Create a copy of DetailSurahState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahDetailCopyWith<$Res> get detail {
  
  return $SurahDetailCopyWith<$Res>(_self.detail, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}

/// @nodoc


class DetailSurahFailure implements DetailSurahState {
  const DetailSurahFailure({required this.message});
  

 final  String message;

/// Create a copy of DetailSurahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailSurahFailureCopyWith<DetailSurahFailure> get copyWith => _$DetailSurahFailureCopyWithImpl<DetailSurahFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailSurahFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'DetailSurahState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $DetailSurahFailureCopyWith<$Res> implements $DetailSurahStateCopyWith<$Res> {
  factory $DetailSurahFailureCopyWith(DetailSurahFailure value, $Res Function(DetailSurahFailure) _then) = _$DetailSurahFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DetailSurahFailureCopyWithImpl<$Res>
    implements $DetailSurahFailureCopyWith<$Res> {
  _$DetailSurahFailureCopyWithImpl(this._self, this._then);

  final DetailSurahFailure _self;
  final $Res Function(DetailSurahFailure) _then;

/// Create a copy of DetailSurahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DetailSurahFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
