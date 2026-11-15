// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doa_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoaState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoaState()';
}


}

/// @nodoc
class $DoaStateCopyWith<$Res>  {
$DoaStateCopyWith(DoaState _, $Res Function(DoaState) __);
}


/// Adds pattern-matching-related methods to [DoaState].
extension DoaStatePatterns on DoaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DoaInitial value)?  initial,TResult Function( DoaLoading value)?  loading,TResult Function( DoaRefreshing value)?  refreshing,TResult Function( DoaLoaded value)?  loaded,TResult Function( DoaFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DoaInitial() when initial != null:
return initial(_that);case DoaLoading() when loading != null:
return loading(_that);case DoaRefreshing() when refreshing != null:
return refreshing(_that);case DoaLoaded() when loaded != null:
return loaded(_that);case DoaFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DoaInitial value)  initial,required TResult Function( DoaLoading value)  loading,required TResult Function( DoaRefreshing value)  refreshing,required TResult Function( DoaLoaded value)  loaded,required TResult Function( DoaFailure value)  failure,}){
final _that = this;
switch (_that) {
case DoaInitial():
return initial(_that);case DoaLoading():
return loading(_that);case DoaRefreshing():
return refreshing(_that);case DoaLoaded():
return loaded(_that);case DoaFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DoaInitial value)?  initial,TResult? Function( DoaLoading value)?  loading,TResult? Function( DoaRefreshing value)?  refreshing,TResult? Function( DoaLoaded value)?  loaded,TResult? Function( DoaFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DoaInitial() when initial != null:
return initial(_that);case DoaLoading() when loading != null:
return loading(_that);case DoaRefreshing() when refreshing != null:
return refreshing(_that);case DoaLoaded() when loaded != null:
return loaded(_that);case DoaFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Doa> doas)?  refreshing,TResult Function( List<Doa> doas)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DoaInitial() when initial != null:
return initial();case DoaLoading() when loading != null:
return loading();case DoaRefreshing() when refreshing != null:
return refreshing(_that.doas);case DoaLoaded() when loaded != null:
return loaded(_that.doas);case DoaFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Doa> doas)  refreshing,required TResult Function( List<Doa> doas)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case DoaInitial():
return initial();case DoaLoading():
return loading();case DoaRefreshing():
return refreshing(_that.doas);case DoaLoaded():
return loaded(_that.doas);case DoaFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Doa> doas)?  refreshing,TResult? Function( List<Doa> doas)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case DoaInitial() when initial != null:
return initial();case DoaLoading() when loading != null:
return loading();case DoaRefreshing() when refreshing != null:
return refreshing(_that.doas);case DoaLoaded() when loaded != null:
return loaded(_that.doas);case DoaFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DoaInitial implements DoaState {
  const DoaInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoaState.initial()';
}


}




/// @nodoc


class DoaLoading implements DoaState {
  const DoaLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoaState.loading()';
}


}




/// @nodoc


class DoaRefreshing implements DoaState {
  const DoaRefreshing({required  List<Doa> doas}): _doas = doas;
  

 final  List<Doa> _doas;
 List<Doa> get doas {
  if (_doas is EqualUnmodifiableListView) return _doas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doas);
}


/// Create a copy of DoaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoaRefreshingCopyWith<DoaRefreshing> get copyWith => _$DoaRefreshingCopyWithImpl<DoaRefreshing>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaRefreshing&&const DeepCollectionEquality().equals(other.doas, _doas));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_doas));
}

@override
String toString() {
    return 'DoaState.refreshing(doas: $doas)';
}


}

/// @nodoc
abstract mixin class $DoaRefreshingCopyWith<$Res> implements $DoaStateCopyWith<$Res> {
  factory $DoaRefreshingCopyWith(DoaRefreshing value, $Res Function(DoaRefreshing) _then) = _$DoaRefreshingCopyWithImpl;
@useResult
$Res call({
 List<Doa> doas
});




}
/// @nodoc
class _$DoaRefreshingCopyWithImpl<$Res>
    implements $DoaRefreshingCopyWith<$Res> {
  _$DoaRefreshingCopyWithImpl(this._self, this._then);

  final DoaRefreshing _self;
  final $Res Function(DoaRefreshing) _then;

/// Create a copy of DoaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doas = null,}) {
  return _then(DoaRefreshing(
doas: null == doas ? _self._doas : doas // ignore: cast_nullable_to_non_nullable
as List<Doa>,
  ));
}


}

/// @nodoc


class DoaLoaded implements DoaState {
  const DoaLoaded({required  List<Doa> doas}): _doas = doas;
  

 final  List<Doa> _doas;
 List<Doa> get doas {
  if (_doas is EqualUnmodifiableListView) return _doas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doas);
}


/// Create a copy of DoaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoaLoadedCopyWith<DoaLoaded> get copyWith => _$DoaLoadedCopyWithImpl<DoaLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaLoaded&&const DeepCollectionEquality().equals(other.doas, _doas));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_doas));
}

@override
String toString() {
    return 'DoaState.loaded(doas: $doas)';
}


}

/// @nodoc
abstract mixin class $DoaLoadedCopyWith<$Res> implements $DoaStateCopyWith<$Res> {
  factory $DoaLoadedCopyWith(DoaLoaded value, $Res Function(DoaLoaded) _then) = _$DoaLoadedCopyWithImpl;
@useResult
$Res call({
 List<Doa> doas
});




}
/// @nodoc
class _$DoaLoadedCopyWithImpl<$Res>
    implements $DoaLoadedCopyWith<$Res> {
  _$DoaLoadedCopyWithImpl(this._self, this._then);

  final DoaLoaded _self;
  final $Res Function(DoaLoaded) _then;

/// Create a copy of DoaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doas = null,}) {
  return _then(DoaLoaded(
doas: null == doas ? _self._doas : doas // ignore: cast_nullable_to_non_nullable
as List<Doa>,
  ));
}


}

/// @nodoc


class DoaFailure implements DoaState {
  const DoaFailure({required this.message});
  

 final  String message;

/// Create a copy of DoaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoaFailureCopyWith<DoaFailure> get copyWith => _$DoaFailureCopyWithImpl<DoaFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'DoaState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $DoaFailureCopyWith<$Res> implements $DoaStateCopyWith<$Res> {
  factory $DoaFailureCopyWith(DoaFailure value, $Res Function(DoaFailure) _then) = _$DoaFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DoaFailureCopyWithImpl<$Res>
    implements $DoaFailureCopyWith<$Res> {
  _$DoaFailureCopyWithImpl(this._self, this._then);

  final DoaFailure _self;
  final $Res Function(DoaFailure) _then;

/// Create a copy of DoaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DoaFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
