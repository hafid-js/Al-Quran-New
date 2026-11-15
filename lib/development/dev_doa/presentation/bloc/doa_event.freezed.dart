// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doa_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoaEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DoaEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoaEvent()';
}


}

/// @nodoc
class $DoaEventCopyWith<$Res>  {
$DoaEventCopyWith(DoaEvent _, $Res Function(DoaEvent) __);
}


/// Adds pattern-matching-related methods to [DoaEvent].
extension DoaEventPatterns on DoaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchDoaList value)?  fetch,TResult Function( RefreshDoaList value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchDoaList() when fetch != null:
return fetch(_that);case RefreshDoaList() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchDoaList value)  fetch,required TResult Function( RefreshDoaList value)  refresh,}){
final _that = this;
switch (_that) {
case FetchDoaList():
return fetch(_that);case RefreshDoaList():
return refresh(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchDoaList value)?  fetch,TResult? Function( RefreshDoaList value)?  refresh,}){
final _that = this;
switch (_that) {
case FetchDoaList() when fetch != null:
return fetch(_that);case RefreshDoaList() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetch,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchDoaList() when fetch != null:
return fetch();case RefreshDoaList() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetch,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case FetchDoaList():
return fetch();case RefreshDoaList():
return refresh();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetch,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case FetchDoaList() when fetch != null:
return fetch();case RefreshDoaList() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class FetchDoaList implements DoaEvent {
  const FetchDoaList();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchDoaList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoaEvent.fetch()';
}


}




/// @nodoc


class RefreshDoaList implements DoaEvent {
  const RefreshDoaList();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshDoaList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DoaEvent.refresh()';
}


}




// dart format on
