// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Surah {

 int get nomor; String get nama; String get namaLatin; int get jumlahAyat; TempatTurun get tempatTurun; String get arti; String get deskripsi; Map<String, String> get audioFull;
/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahCopyWith<Surah> get copyWith => _$SurahCopyWithImpl<Surah>(this as Surah, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Surah;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Surah&&(identical(other.nomor, _this.nomor) || other.nomor == _this.nomor)&&(identical(other.nama, _this.nama) || other.nama == _this.nama)&&(identical(other.namaLatin, _this.namaLatin) || other.namaLatin == _this.namaLatin)&&(identical(other.jumlahAyat, _this.jumlahAyat) || other.jumlahAyat == _this.jumlahAyat)&&(identical(other.tempatTurun, _this.tempatTurun) || other.tempatTurun == _this.tempatTurun)&&(identical(other.arti, _this.arti) || other.arti == _this.arti)&&(identical(other.deskripsi, _this.deskripsi) || other.deskripsi == _this.deskripsi)&&const DeepCollectionEquality().equals(other.audioFull, _this.audioFull));
}


@override
int get hashCode {
  final _this = this as Surah;
  return Object.hash(runtimeType,_this.nomor,_this.nama,_this.namaLatin,_this.jumlahAyat,_this.tempatTurun,_this.arti,_this.deskripsi,const DeepCollectionEquality().hash(_this.audioFull));
}

@override
String toString() {
  final _this = this as Surah;
  return 'Surah(nomor: ${_this.nomor}, nama: ${_this.nama}, namaLatin: ${_this.namaLatin}, jumlahAyat: ${_this.jumlahAyat}, tempatTurun: ${_this.tempatTurun}, arti: ${_this.arti}, deskripsi: ${_this.deskripsi}, audioFull: ${_this.audioFull})';
}


}

/// @nodoc
abstract mixin class $SurahCopyWith<$Res>  {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) _then) = _$SurahCopyWithImpl;
@useResult
$Res call({
 int nomor, String nama, String namaLatin, int jumlahAyat, TempatTurun tempatTurun, String arti, String deskripsi, Map<String, String> audioFull
});




}
/// @nodoc
class _$SurahCopyWithImpl<$Res>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._self, this._then);

  final Surah _self;
  final $Res Function(Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nomor = null,Object? nama = null,Object? namaLatin = null,Object? jumlahAyat = null,Object? tempatTurun = null,Object? arti = null,Object? deskripsi = null,Object? audioFull = null,}) {
  return _then(Surah(
nomor: null == nomor ? _self.nomor : nomor // ignore: cast_nullable_to_non_nullable
as int,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,namaLatin: null == namaLatin ? _self.namaLatin : namaLatin // ignore: cast_nullable_to_non_nullable
as String,jumlahAyat: null == jumlahAyat ? _self.jumlahAyat : jumlahAyat // ignore: cast_nullable_to_non_nullable
as int,tempatTurun: null == tempatTurun ? _self.tempatTurun : tempatTurun // ignore: cast_nullable_to_non_nullable
as TempatTurun,arti: null == arti ? _self.arti : arti // ignore: cast_nullable_to_non_nullable
as String,deskripsi: null == deskripsi ? _self.deskripsi : deskripsi // ignore: cast_nullable_to_non_nullable
as String,audioFull: null == audioFull ? _self.audioFull : audioFull // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Surah].
extension SurahPatterns on Surah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Surah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Surah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Surah value)  $default,){
final _that = this;
switch (_that) {
case _Surah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Surah value)?  $default,){
final _that = this;
switch (_that) {
case _Surah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int nomor,  String nama,  String namaLatin,  int jumlahAyat,  TempatTurun tempatTurun,  String arti,  String deskripsi,  Map<String, String> audioFull)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Surah() when $default != null:
return $default(_that.nomor,_that.nama,_that.namaLatin,_that.jumlahAyat,_that.tempatTurun,_that.arti,_that.deskripsi,_that.audioFull);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int nomor,  String nama,  String namaLatin,  int jumlahAyat,  TempatTurun tempatTurun,  String arti,  String deskripsi,  Map<String, String> audioFull)  $default,) {final _that = this;
switch (_that) {
case _Surah():
return $default(_that.nomor,_that.nama,_that.namaLatin,_that.jumlahAyat,_that.tempatTurun,_that.arti,_that.deskripsi,_that.audioFull);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int nomor,  String nama,  String namaLatin,  int jumlahAyat,  TempatTurun tempatTurun,  String arti,  String deskripsi,  Map<String, String> audioFull)?  $default,) {final _that = this;
switch (_that) {
case _Surah() when $default != null:
return $default(_that.nomor,_that.nama,_that.namaLatin,_that.jumlahAyat,_that.tempatTurun,_that.arti,_that.deskripsi,_that.audioFull);case _:
  return null;

}
}

}

/// @nodoc


class _Surah implements Surah {
  const _Surah({required this.nomor, required this.nama, required this.namaLatin, required this.jumlahAyat, required this.tempatTurun, required this.arti, required this.deskripsi, required  Map<String, String> audioFull}): _audioFull = audioFull;
  

@override final  int nomor;
@override final  String nama;
@override final  String namaLatin;
@override final  int jumlahAyat;
@override final  TempatTurun tempatTurun;
@override final  String arti;
@override final  String deskripsi;
 final  Map<String, String> _audioFull;
@override Map<String, String> get audioFull {
  if (_audioFull is EqualUnmodifiableMapView) return _audioFull;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_audioFull);
}


/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahCopyWith<_Surah> get copyWith => __$SurahCopyWithImpl<_Surah>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Surah&&(identical(other.nomor, nomor) || other.nomor == nomor)&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.namaLatin, namaLatin) || other.namaLatin == namaLatin)&&(identical(other.jumlahAyat, jumlahAyat) || other.jumlahAyat == jumlahAyat)&&(identical(other.tempatTurun, tempatTurun) || other.tempatTurun == tempatTurun)&&(identical(other.arti, arti) || other.arti == arti)&&(identical(other.deskripsi, deskripsi) || other.deskripsi == deskripsi)&&const DeepCollectionEquality().equals(other.audioFull, _audioFull));
}


@override
int get hashCode {
    return Object.hash(runtimeType,nomor,nama,namaLatin,jumlahAyat,tempatTurun,arti,deskripsi,const DeepCollectionEquality().hash(_audioFull));
}

@override
String toString() {
    return 'Surah(nomor: $nomor, nama: $nama, namaLatin: $namaLatin, jumlahAyat: $jumlahAyat, tempatTurun: $tempatTurun, arti: $arti, deskripsi: $deskripsi, audioFull: $audioFull)';
}


}

/// @nodoc
abstract mixin class _$SurahCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$SurahCopyWith(_Surah value, $Res Function(_Surah) _then) = __$SurahCopyWithImpl;
@override @useResult
$Res call({
 int nomor, String nama, String namaLatin, int jumlahAyat, TempatTurun tempatTurun, String arti, String deskripsi, Map<String, String> audioFull
});




}
/// @nodoc
class __$SurahCopyWithImpl<$Res>
    implements _$SurahCopyWith<$Res> {
  __$SurahCopyWithImpl(this._self, this._then);

  final _Surah _self;
  final $Res Function(_Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nomor = null,Object? nama = null,Object? namaLatin = null,Object? jumlahAyat = null,Object? tempatTurun = null,Object? arti = null,Object? deskripsi = null,Object? audioFull = null,}) {
  return _then(_Surah(
nomor: null == nomor ? _self.nomor : nomor // ignore: cast_nullable_to_non_nullable
as int,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,namaLatin: null == namaLatin ? _self.namaLatin : namaLatin // ignore: cast_nullable_to_non_nullable
as String,jumlahAyat: null == jumlahAyat ? _self.jumlahAyat : jumlahAyat // ignore: cast_nullable_to_non_nullable
as int,tempatTurun: null == tempatTurun ? _self.tempatTurun : tempatTurun // ignore: cast_nullable_to_non_nullable
as TempatTurun,arti: null == arti ? _self.arti : arti // ignore: cast_nullable_to_non_nullable
as String,deskripsi: null == deskripsi ? _self.deskripsi : deskripsi // ignore: cast_nullable_to_non_nullable
as String,audioFull: null == audioFull ? _self._audioFull : audioFull // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
