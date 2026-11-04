// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'masjid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Masjid {

 String get id; String get name; String get address; double get latitude; double get longitude; double? get rating;
/// Create a copy of Masjid
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasjidCopyWith<Masjid> get copyWith => _$MasjidCopyWithImpl<Masjid>(this as Masjid, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Masjid;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Masjid&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.rating, _this.rating) || other.rating == _this.rating));
}


@override
int get hashCode {
  final _this = this as Masjid;
  return Object.hash(runtimeType,_this.id,_this.name,_this.address,_this.latitude,_this.longitude,_this.rating);
}

@override
String toString() {
  final _this = this as Masjid;
  return 'Masjid(id: ${_this.id}, name: ${_this.name}, address: ${_this.address}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, rating: ${_this.rating})';
}


}

/// @nodoc
abstract mixin class $MasjidCopyWith<$Res>  {
  factory $MasjidCopyWith(Masjid value, $Res Function(Masjid) _then) = _$MasjidCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double latitude, double longitude, double? rating
});




}
/// @nodoc
class _$MasjidCopyWithImpl<$Res>
    implements $MasjidCopyWith<$Res> {
  _$MasjidCopyWithImpl(this._self, this._then);

  final Masjid _self;
  final $Res Function(Masjid) _then;

/// Create a copy of Masjid
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? rating = freezed,}) {
  return _then(Masjid(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Masjid].
extension MasjidPatterns on Masjid {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Masjid value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Masjid() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Masjid value)  $default,){
final _that = this;
switch (_that) {
case _Masjid():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Masjid value)?  $default,){
final _that = this;
switch (_that) {
case _Masjid() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double latitude,  double longitude,  double? rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Masjid() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.latitude,_that.longitude,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double latitude,  double longitude,  double? rating)  $default,) {final _that = this;
switch (_that) {
case _Masjid():
return $default(_that.id,_that.name,_that.address,_that.latitude,_that.longitude,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double latitude,  double longitude,  double? rating)?  $default,) {final _that = this;
switch (_that) {
case _Masjid() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.latitude,_that.longitude,_that.rating);case _:
  return null;

}
}

}

/// @nodoc


class _Masjid implements Masjid {
  const _Masjid({required this.id, required this.name, required this.address, required this.latitude, required this.longitude, this.rating});
  

@override final  String id;
@override final  String name;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
@override final  double? rating;

/// Create a copy of Masjid
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MasjidCopyWith<_Masjid> get copyWith => __$MasjidCopyWithImpl<_Masjid>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Masjid&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,address,latitude,longitude,rating);
}

@override
String toString() {
    return 'Masjid(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$MasjidCopyWith<$Res> implements $MasjidCopyWith<$Res> {
  factory _$MasjidCopyWith(_Masjid value, $Res Function(_Masjid) _then) = __$MasjidCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double latitude, double longitude, double? rating
});




}
/// @nodoc
class __$MasjidCopyWithImpl<$Res>
    implements _$MasjidCopyWith<$Res> {
  __$MasjidCopyWithImpl(this._self, this._then);

  final _Masjid _self;
  final $Res Function(_Masjid) _then;

/// Create a copy of Masjid
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? rating = freezed,}) {
  return _then(_Masjid(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
