// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'masjid_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MasjidState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MasjidState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MasjidState()';
}


}

/// @nodoc
class $MasjidStateCopyWith<$Res>  {
$MasjidStateCopyWith(MasjidState _, $Res Function(MasjidState) __);
}


/// Adds pattern-matching-related methods to [MasjidState].
extension MasjidStatePatterns on MasjidState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MasjidInitial value)?  initial,TResult Function( MasjidLoading value)?  loading,TResult Function( MasjidLoaded value)?  loaded,TResult Function( MasjidError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MasjidInitial() when initial != null:
return initial(_that);case MasjidLoading() when loading != null:
return loading(_that);case MasjidLoaded() when loaded != null:
return loaded(_that);case MasjidError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MasjidInitial value)  initial,required TResult Function( MasjidLoading value)  loading,required TResult Function( MasjidLoaded value)  loaded,required TResult Function( MasjidError value)  error,}){
final _that = this;
switch (_that) {
case MasjidInitial():
return initial(_that);case MasjidLoading():
return loading(_that);case MasjidLoaded():
return loaded(_that);case MasjidError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MasjidInitial value)?  initial,TResult? Function( MasjidLoading value)?  loading,TResult? Function( MasjidLoaded value)?  loaded,TResult? Function( MasjidError value)?  error,}){
final _that = this;
switch (_that) {
case MasjidInitial() when initial != null:
return initial(_that);case MasjidLoading() when loading != null:
return loading(_that);case MasjidLoaded() when loaded != null:
return loaded(_that);case MasjidError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Masjid> masjids,  Position userPosition)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MasjidInitial() when initial != null:
return initial();case MasjidLoading() when loading != null:
return loading();case MasjidLoaded() when loaded != null:
return loaded(_that.masjids,_that.userPosition);case MasjidError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Masjid> masjids,  Position userPosition)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MasjidInitial():
return initial();case MasjidLoading():
return loading();case MasjidLoaded():
return loaded(_that.masjids,_that.userPosition);case MasjidError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Masjid> masjids,  Position userPosition)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MasjidInitial() when initial != null:
return initial();case MasjidLoading() when loading != null:
return loading();case MasjidLoaded() when loaded != null:
return loaded(_that.masjids,_that.userPosition);case MasjidError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MasjidInitial implements MasjidState {
  const MasjidInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MasjidInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MasjidState.initial()';
}


}




/// @nodoc


class MasjidLoading implements MasjidState {
  const MasjidLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MasjidLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MasjidState.loading()';
}


}




/// @nodoc


class MasjidLoaded implements MasjidState {
  const MasjidLoaded({required  List<Masjid> masjids, required this.userPosition}): _masjids = masjids;
  

 final  List<Masjid> _masjids;
 List<Masjid> get masjids {
  if (_masjids is EqualUnmodifiableListView) return _masjids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_masjids);
}

 final  Position userPosition;

/// Create a copy of MasjidState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasjidLoadedCopyWith<MasjidLoaded> get copyWith => _$MasjidLoadedCopyWithImpl<MasjidLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MasjidLoaded&&const DeepCollectionEquality().equals(other.masjids, _masjids)&&(identical(other.userPosition, userPosition) || other.userPosition == userPosition));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_masjids),userPosition);
}

@override
String toString() {
    return 'MasjidState.loaded(masjids: $masjids, userPosition: $userPosition)';
}


}

/// @nodoc
abstract mixin class $MasjidLoadedCopyWith<$Res> implements $MasjidStateCopyWith<$Res> {
  factory $MasjidLoadedCopyWith(MasjidLoaded value, $Res Function(MasjidLoaded) _then) = _$MasjidLoadedCopyWithImpl;
@useResult
$Res call({
 List<Masjid> masjids, Position userPosition
});




}
/// @nodoc
class _$MasjidLoadedCopyWithImpl<$Res>
    implements $MasjidLoadedCopyWith<$Res> {
  _$MasjidLoadedCopyWithImpl(this._self, this._then);

  final MasjidLoaded _self;
  final $Res Function(MasjidLoaded) _then;

/// Create a copy of MasjidState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? masjids = null,Object? userPosition = null,}) {
  return _then(MasjidLoaded(
masjids: null == masjids ? _self._masjids : masjids // ignore: cast_nullable_to_non_nullable
as List<Masjid>,userPosition: null == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as Position,
  ));
}


}

/// @nodoc


class MasjidError implements MasjidState {
  const MasjidError({required this.message});
  

 final  String message;

/// Create a copy of MasjidState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasjidErrorCopyWith<MasjidError> get copyWith => _$MasjidErrorCopyWithImpl<MasjidError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MasjidError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'MasjidState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MasjidErrorCopyWith<$Res> implements $MasjidStateCopyWith<$Res> {
  factory $MasjidErrorCopyWith(MasjidError value, $Res Function(MasjidError) _then) = _$MasjidErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MasjidErrorCopyWithImpl<$Res>
    implements $MasjidErrorCopyWith<$Res> {
  _$MasjidErrorCopyWithImpl(this._self, this._then);

  final MasjidError _self;
  final $Res Function(MasjidError) _then;

/// Create a copy of MasjidState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MasjidError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
