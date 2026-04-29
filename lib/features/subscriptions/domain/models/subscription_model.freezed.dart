// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionModel {

 String get id; String get userId; String get name; double get amount; SubscriptionFrequency get frequency; DateTime get startDate; DateTime get nextPayment; PaymentMode get paymentMode; bool get isActive; String? get categoryId; DateTime? get cancelledAt; DateTime? get createdAt;
/// Create a copy of SubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionModelCopyWith<SubscriptionModel> get copyWith => _$SubscriptionModelCopyWithImpl<SubscriptionModel>(this as SubscriptionModel, _$identity);

  /// Serializes this SubscriptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.nextPayment, nextPayment) || other.nextPayment == nextPayment)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,amount,frequency,startDate,nextPayment,paymentMode,isActive,categoryId,cancelledAt,createdAt);

@override
String toString() {
  return 'SubscriptionModel(id: $id, userId: $userId, name: $name, amount: $amount, frequency: $frequency, startDate: $startDate, nextPayment: $nextPayment, paymentMode: $paymentMode, isActive: $isActive, categoryId: $categoryId, cancelledAt: $cancelledAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SubscriptionModelCopyWith<$Res>  {
  factory $SubscriptionModelCopyWith(SubscriptionModel value, $Res Function(SubscriptionModel) _then) = _$SubscriptionModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, double amount, SubscriptionFrequency frequency, DateTime startDate, DateTime nextPayment, PaymentMode paymentMode, bool isActive, String? categoryId, DateTime? cancelledAt, DateTime? createdAt
});




}
/// @nodoc
class _$SubscriptionModelCopyWithImpl<$Res>
    implements $SubscriptionModelCopyWith<$Res> {
  _$SubscriptionModelCopyWithImpl(this._self, this._then);

  final SubscriptionModel _self;
  final $Res Function(SubscriptionModel) _then;

/// Create a copy of SubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? amount = null,Object? frequency = null,Object? startDate = null,Object? nextPayment = null,Object? paymentMode = null,Object? isActive = null,Object? categoryId = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as SubscriptionFrequency,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,nextPayment: null == nextPayment ? _self.nextPayment : nextPayment // ignore: cast_nullable_to_non_nullable
as DateTime,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as PaymentMode,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionModel].
extension SubscriptionModelPatterns on SubscriptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionModel value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  double amount,  SubscriptionFrequency frequency,  DateTime startDate,  DateTime nextPayment,  PaymentMode paymentMode,  bool isActive,  String? categoryId,  DateTime? cancelledAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.amount,_that.frequency,_that.startDate,_that.nextPayment,_that.paymentMode,_that.isActive,_that.categoryId,_that.cancelledAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  double amount,  SubscriptionFrequency frequency,  DateTime startDate,  DateTime nextPayment,  PaymentMode paymentMode,  bool isActive,  String? categoryId,  DateTime? cancelledAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionModel():
return $default(_that.id,_that.userId,_that.name,_that.amount,_that.frequency,_that.startDate,_that.nextPayment,_that.paymentMode,_that.isActive,_that.categoryId,_that.cancelledAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  double amount,  SubscriptionFrequency frequency,  DateTime startDate,  DateTime nextPayment,  PaymentMode paymentMode,  bool isActive,  String? categoryId,  DateTime? cancelledAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.amount,_that.frequency,_that.startDate,_that.nextPayment,_that.paymentMode,_that.isActive,_that.categoryId,_that.cancelledAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionModel extends SubscriptionModel {
  const _SubscriptionModel({required this.id, required this.userId, required this.name, required this.amount, required this.frequency, required this.startDate, required this.nextPayment, required this.paymentMode, this.isActive = true, this.categoryId, this.cancelledAt, this.createdAt}): super._();
  factory _SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  double amount;
@override final  SubscriptionFrequency frequency;
@override final  DateTime startDate;
@override final  DateTime nextPayment;
@override final  PaymentMode paymentMode;
@override@JsonKey() final  bool isActive;
@override final  String? categoryId;
@override final  DateTime? cancelledAt;
@override final  DateTime? createdAt;

/// Create a copy of SubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionModelCopyWith<_SubscriptionModel> get copyWith => __$SubscriptionModelCopyWithImpl<_SubscriptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.nextPayment, nextPayment) || other.nextPayment == nextPayment)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,amount,frequency,startDate,nextPayment,paymentMode,isActive,categoryId,cancelledAt,createdAt);

@override
String toString() {
  return 'SubscriptionModel(id: $id, userId: $userId, name: $name, amount: $amount, frequency: $frequency, startDate: $startDate, nextPayment: $nextPayment, paymentMode: $paymentMode, isActive: $isActive, categoryId: $categoryId, cancelledAt: $cancelledAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionModelCopyWith<$Res> implements $SubscriptionModelCopyWith<$Res> {
  factory _$SubscriptionModelCopyWith(_SubscriptionModel value, $Res Function(_SubscriptionModel) _then) = __$SubscriptionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, double amount, SubscriptionFrequency frequency, DateTime startDate, DateTime nextPayment, PaymentMode paymentMode, bool isActive, String? categoryId, DateTime? cancelledAt, DateTime? createdAt
});




}
/// @nodoc
class __$SubscriptionModelCopyWithImpl<$Res>
    implements _$SubscriptionModelCopyWith<$Res> {
  __$SubscriptionModelCopyWithImpl(this._self, this._then);

  final _SubscriptionModel _self;
  final $Res Function(_SubscriptionModel) _then;

/// Create a copy of SubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? amount = null,Object? frequency = null,Object? startDate = null,Object? nextPayment = null,Object? paymentMode = null,Object? isActive = null,Object? categoryId = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,}) {
  return _then(_SubscriptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as SubscriptionFrequency,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,nextPayment: null == nextPayment ? _self.nextPayment : nextPayment // ignore: cast_nullable_to_non_nullable
as DateTime,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as PaymentMode,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
