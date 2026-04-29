// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebtModel {

 String get id; String get userId; String get name; double get totalAmount; double get pendingAmount; double get monthlyPayment; DateTime get dueDate; DebtStatus get status; String? get note; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtModelCopyWith<DebtModel> get copyWith => _$DebtModelCopyWithImpl<DebtModel>(this as DebtModel, _$identity);

  /// Serializes this DebtModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.monthlyPayment, monthlyPayment) || other.monthlyPayment == monthlyPayment)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,totalAmount,pendingAmount,monthlyPayment,dueDate,status,note,createdAt,updatedAt);

@override
String toString() {
  return 'DebtModel(id: $id, userId: $userId, name: $name, totalAmount: $totalAmount, pendingAmount: $pendingAmount, monthlyPayment: $monthlyPayment, dueDate: $dueDate, status: $status, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DebtModelCopyWith<$Res>  {
  factory $DebtModelCopyWith(DebtModel value, $Res Function(DebtModel) _then) = _$DebtModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, double totalAmount, double pendingAmount, double monthlyPayment, DateTime dueDate, DebtStatus status, String? note, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$DebtModelCopyWithImpl<$Res>
    implements $DebtModelCopyWith<$Res> {
  _$DebtModelCopyWithImpl(this._self, this._then);

  final DebtModel _self;
  final $Res Function(DebtModel) _then;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? totalAmount = null,Object? pendingAmount = null,Object? monthlyPayment = null,Object? dueDate = null,Object? status = null,Object? note = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,pendingAmount: null == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as double,monthlyPayment: null == monthlyPayment ? _self.monthlyPayment : monthlyPayment // ignore: cast_nullable_to_non_nullable
as double,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtModel].
extension DebtModelPatterns on DebtModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtModel value)  $default,){
final _that = this;
switch (_that) {
case _DebtModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtModel value)?  $default,){
final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  double totalAmount,  double pendingAmount,  double monthlyPayment,  DateTime dueDate,  DebtStatus status,  String? note,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.totalAmount,_that.pendingAmount,_that.monthlyPayment,_that.dueDate,_that.status,_that.note,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  double totalAmount,  double pendingAmount,  double monthlyPayment,  DateTime dueDate,  DebtStatus status,  String? note,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DebtModel():
return $default(_that.id,_that.userId,_that.name,_that.totalAmount,_that.pendingAmount,_that.monthlyPayment,_that.dueDate,_that.status,_that.note,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  double totalAmount,  double pendingAmount,  double monthlyPayment,  DateTime dueDate,  DebtStatus status,  String? note,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.totalAmount,_that.pendingAmount,_that.monthlyPayment,_that.dueDate,_that.status,_that.note,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebtModel extends DebtModel {
  const _DebtModel({required this.id, required this.userId, required this.name, required this.totalAmount, required this.pendingAmount, required this.monthlyPayment, required this.dueDate, this.status = DebtStatus.active, this.note, this.createdAt, this.updatedAt}): super._();
  factory _DebtModel.fromJson(Map<String, dynamic> json) => _$DebtModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  double totalAmount;
@override final  double pendingAmount;
@override final  double monthlyPayment;
@override final  DateTime dueDate;
@override@JsonKey() final  DebtStatus status;
@override final  String? note;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtModelCopyWith<_DebtModel> get copyWith => __$DebtModelCopyWithImpl<_DebtModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebtModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.monthlyPayment, monthlyPayment) || other.monthlyPayment == monthlyPayment)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,totalAmount,pendingAmount,monthlyPayment,dueDate,status,note,createdAt,updatedAt);

@override
String toString() {
  return 'DebtModel(id: $id, userId: $userId, name: $name, totalAmount: $totalAmount, pendingAmount: $pendingAmount, monthlyPayment: $monthlyPayment, dueDate: $dueDate, status: $status, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DebtModelCopyWith<$Res> implements $DebtModelCopyWith<$Res> {
  factory _$DebtModelCopyWith(_DebtModel value, $Res Function(_DebtModel) _then) = __$DebtModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, double totalAmount, double pendingAmount, double monthlyPayment, DateTime dueDate, DebtStatus status, String? note, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$DebtModelCopyWithImpl<$Res>
    implements _$DebtModelCopyWith<$Res> {
  __$DebtModelCopyWithImpl(this._self, this._then);

  final _DebtModel _self;
  final $Res Function(_DebtModel) _then;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? totalAmount = null,Object? pendingAmount = null,Object? monthlyPayment = null,Object? dueDate = null,Object? status = null,Object? note = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DebtModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,pendingAmount: null == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as double,monthlyPayment: null == monthlyPayment ? _self.monthlyPayment : monthlyPayment // ignore: cast_nullable_to_non_nullable
as double,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
