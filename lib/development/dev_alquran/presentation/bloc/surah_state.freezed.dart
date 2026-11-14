// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SurahState()';
}


}

/// @nodoc
class $SurahStateCopyWith<$Res>  {
$SurahStateCopyWith(SurahState _, $Res Function(SurahState) __);
}


/// Adds pattern-matching-related methods to [SurahState].
extension SurahStatePatterns on SurahState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SurahInitial value)?  initial,TResult Function( SurahLoading value)?  loading,TResult Function( SurahRefreshing value)?  refreshing,TResult Function( SurahLoaded value)?  loaded,TResult Function( SurahFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SurahInitial() when initial != null:
return initial(_that);case SurahLoading() when loading != null:
return loading(_that);case SurahRefreshing() when refreshing != null:
return refreshing(_that);case SurahLoaded() when loaded != null:
return loaded(_that);case SurahFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SurahInitial value)  initial,required TResult Function( SurahLoading value)  loading,required TResult Function( SurahRefreshing value)  refreshing,required TResult Function( SurahLoaded value)  loaded,required TResult Function( SurahFailure value)  failure,}){
final _that = this;
switch (_that) {
case SurahInitial():
return initial(_that);case SurahLoading():
return loading(_that);case SurahRefreshing():
return refreshing(_that);case SurahLoaded():
return loaded(_that);case SurahFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SurahInitial value)?  initial,TResult? Function( SurahLoading value)?  loading,TResult? Function( SurahRefreshing value)?  refreshing,TResult? Function( SurahLoaded value)?  loaded,TResult? Function( SurahFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SurahInitial() when initial != null:
return initial(_that);case SurahLoading() when loading != null:
return loading(_that);case SurahRefreshing() when refreshing != null:
return refreshing(_that);case SurahLoaded() when loaded != null:
return loaded(_that);case SurahFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Surah> surahs)?  refreshing,TResult Function( List<Surah> surahs)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SurahInitial() when initial != null:
return initial();case SurahLoading() when loading != null:
return loading();case SurahRefreshing() when refreshing != null:
return refreshing(_that.surahs);case SurahLoaded() when loaded != null:
return loaded(_that.surahs);case SurahFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Surah> surahs)  refreshing,required TResult Function( List<Surah> surahs)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case SurahInitial():
return initial();case SurahLoading():
return loading();case SurahRefreshing():
return refreshing(_that.surahs);case SurahLoaded():
return loaded(_that.surahs);case SurahFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Surah> surahs)?  refreshing,TResult? Function( List<Surah> surahs)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case SurahInitial() when initial != null:
return initial();case SurahLoading() when loading != null:
return loading();case SurahRefreshing() when refreshing != null:
return refreshing(_that.surahs);case SurahLoaded() when loaded != null:
return loaded(_that.surahs);case SurahFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SurahInitial implements SurahState {
  const SurahInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SurahState.initial()';
}


}




/// @nodoc


class SurahLoading implements SurahState {
  const SurahLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SurahState.loading()';
}


}




/// @nodoc


class SurahRefreshing implements SurahState {
  const SurahRefreshing({required  List<Surah> surahs}): _surahs = surahs;
  

 final  List<Surah> _surahs;
 List<Surah> get surahs {
  if (_surahs is EqualUnmodifiableListView) return _surahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surahs);
}


/// Create a copy of SurahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahRefreshingCopyWith<SurahRefreshing> get copyWith => _$SurahRefreshingCopyWithImpl<SurahRefreshing>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahRefreshing&&const DeepCollectionEquality().equals(other.surahs, _surahs));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_surahs));
}

@override
String toString() {
    return 'SurahState.refreshing(surahs: $surahs)';
}


}

/// @nodoc
abstract mixin class $SurahRefreshingCopyWith<$Res> implements $SurahStateCopyWith<$Res> {
  factory $SurahRefreshingCopyWith(SurahRefreshing value, $Res Function(SurahRefreshing) _then) = _$SurahRefreshingCopyWithImpl;
@useResult
$Res call({
 List<Surah> surahs
});




}
/// @nodoc
class _$SurahRefreshingCopyWithImpl<$Res>
    implements $SurahRefreshingCopyWith<$Res> {
  _$SurahRefreshingCopyWithImpl(this._self, this._then);

  final SurahRefreshing _self;
  final $Res Function(SurahRefreshing) _then;

/// Create a copy of SurahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surahs = null,}) {
  return _then(SurahRefreshing(
surahs: null == surahs ? _self._surahs : surahs // ignore: cast_nullable_to_non_nullable
as List<Surah>,
  ));
}


}

/// @nodoc


class SurahLoaded implements SurahState {
  const SurahLoaded({required  List<Surah> surahs}): _surahs = surahs;
  

 final  List<Surah> _surahs;
 List<Surah> get surahs {
  if (_surahs is EqualUnmodifiableListView) return _surahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surahs);
}


/// Create a copy of SurahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahLoadedCopyWith<SurahLoaded> get copyWith => _$SurahLoadedCopyWithImpl<SurahLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahLoaded&&const DeepCollectionEquality().equals(other.surahs, _surahs));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_surahs));
}

@override
String toString() {
    return 'SurahState.loaded(surahs: $surahs)';
}


}

/// @nodoc
abstract mixin class $SurahLoadedCopyWith<$Res> implements $SurahStateCopyWith<$Res> {
  factory $SurahLoadedCopyWith(SurahLoaded value, $Res Function(SurahLoaded) _then) = _$SurahLoadedCopyWithImpl;
@useResult
$Res call({
 List<Surah> surahs
});




}
/// @nodoc
class _$SurahLoadedCopyWithImpl<$Res>
    implements $SurahLoadedCopyWith<$Res> {
  _$SurahLoadedCopyWithImpl(this._self, this._then);

  final SurahLoaded _self;
  final $Res Function(SurahLoaded) _then;

/// Create a copy of SurahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surahs = null,}) {
  return _then(SurahLoaded(
surahs: null == surahs ? _self._surahs : surahs // ignore: cast_nullable_to_non_nullable
as List<Surah>,
  ));
}


}

/// @nodoc


class SurahFailure implements SurahState {
  const SurahFailure({required this.message});
  

 final  String message;

/// Create a copy of SurahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahFailureCopyWith<SurahFailure> get copyWith => _$SurahFailureCopyWithImpl<SurahFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'SurahState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SurahFailureCopyWith<$Res> implements $SurahStateCopyWith<$Res> {
  factory $SurahFailureCopyWith(SurahFailure value, $Res Function(SurahFailure) _then) = _$SurahFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SurahFailureCopyWithImpl<$Res>
    implements $SurahFailureCopyWith<$Res> {
  _$SurahFailureCopyWithImpl(this._self, this._then);

  final SurahFailure _self;
  final $Res Function(SurahFailure) _then;

/// Create a copy of SurahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SurahFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
