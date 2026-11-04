// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'masjid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MasjidModel {

 String get id; String get name; String get address; double get longitude; double get latitude; double? get rating;
/// Create a copy of MasjidModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasjidModelCopyWith<MasjidModel> get copyWith => _$MasjidModelCopyWithImpl<MasjidModel>(this as MasjidModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MasjidModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MasjidModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.rating, _this.rating) || other.rating == _this.rating));
}


@override
int get hashCode {
  final _this = this as MasjidModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.address,_this.longitude,_this.latitude,_this.rating);
}

@override
String toString() {
  final _this = this as MasjidModel;
  return 'MasjidModel(id: ${_this.id}, name: ${_this.name}, address: ${_this.address}, longitude: ${_this.longitude}, latitude: ${_this.latitude}, rating: ${_this.rating})';
}


}

/// @nodoc
abstract mixin class $MasjidModelCopyWith<$Res>  {
  factory $MasjidModelCopyWith(MasjidModel value, $Res Function(MasjidModel) _then) = _$MasjidModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, double longitude, double latitude, double? rating
});




}
/// @nodoc
class _$MasjidModelCopyWithImpl<$Res>
    implements $MasjidModelCopyWith<$Res> {
  _$MasjidModelCopyWithImpl(this._self, this._then);

  final MasjidModel _self;
  final $Res Function(MasjidModel) _then;

/// Create a copy of MasjidModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? longitude = null,Object? latitude = null,Object? rating = freezed,}) {
  return _then(MasjidModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [MasjidModel].
extension MasjidModelPatterns on MasjidModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MasjidModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MasjidModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MasjidModel value)  $default,){
final _that = this;
switch (_that) {
case _MasjidModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MasjidModel value)?  $default,){
final _that = this;
switch (_that) {
case _MasjidModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double longitude,  double latitude,  double? rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MasjidModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.longitude,_that.latitude,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  double longitude,  double latitude,  double? rating)  $default,) {final _that = this;
switch (_that) {
case _MasjidModel():
return $default(_that.id,_that.name,_that.address,_that.longitude,_that.latitude,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  double longitude,  double latitude,  double? rating)?  $default,) {final _that = this;
switch (_that) {
case _MasjidModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.longitude,_that.latitude,_that.rating);case _:
  return null;

}
}

}

/// @nodoc


class _MasjidModel extends MasjidModel {
  const _MasjidModel({this.id = '', this.name = 'Tanpa nama', this.address = 'Alamat tidak tersedia', this.longitude = 0.0, this.latitude = 0.0, this.rating}): super._();
  

@override@JsonKey() final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String address;
@override@JsonKey() final  double longitude;
@override@JsonKey() final  double latitude;
@override final  double? rating;

/// Create a copy of MasjidModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MasjidModelCopyWith<_MasjidModel> get copyWith => __$MasjidModelCopyWithImpl<_MasjidModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MasjidModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,address,longitude,latitude,rating);
}

@override
String toString() {
    return 'MasjidModel(id: $id, name: $name, address: $address, longitude: $longitude, latitude: $latitude, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$MasjidModelCopyWith<$Res> implements $MasjidModelCopyWith<$Res> {
  factory _$MasjidModelCopyWith(_MasjidModel value, $Res Function(_MasjidModel) _then) = __$MasjidModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, double longitude, double latitude, double? rating
});




}
/// @nodoc
class __$MasjidModelCopyWithImpl<$Res>
    implements _$MasjidModelCopyWith<$Res> {
  __$MasjidModelCopyWithImpl(this._self, this._then);

  final _MasjidModel _self;
  final $Res Function(_MasjidModel) _then;

/// Create a copy of MasjidModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? longitude = null,Object? latitude = null,Object? rating = freezed,}) {
  return _then(_MasjidModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
