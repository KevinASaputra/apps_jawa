// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RoleUpdateRoleEnum _$roleUpdateRoleEnum_buyer =
    const RoleUpdateRoleEnum._('buyer');
const RoleUpdateRoleEnum _$roleUpdateRoleEnum_seller =
    const RoleUpdateRoleEnum._('seller');

RoleUpdateRoleEnum _$roleUpdateRoleEnumValueOf(String name) {
  switch (name) {
    case 'buyer':
      return _$roleUpdateRoleEnum_buyer;
    case 'seller':
      return _$roleUpdateRoleEnum_seller;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<RoleUpdateRoleEnum> _$roleUpdateRoleEnumValues =
    BuiltSet<RoleUpdateRoleEnum>(const <RoleUpdateRoleEnum>[
  _$roleUpdateRoleEnum_buyer,
  _$roleUpdateRoleEnum_seller,
]);

Serializer<RoleUpdateRoleEnum> _$roleUpdateRoleEnumSerializer =
    _$RoleUpdateRoleEnumSerializer();

class _$RoleUpdateRoleEnumSerializer
    implements PrimitiveSerializer<RoleUpdateRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'buyer': 'Buyer',
    'seller': 'Seller',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Buyer': 'buyer',
    'Seller': 'seller',
  };

  @override
  final Iterable<Type> types = const <Type>[RoleUpdateRoleEnum];
  @override
  final String wireName = 'RoleUpdateRoleEnum';

  @override
  Object serialize(Serializers serializers, RoleUpdateRoleEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RoleUpdateRoleEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RoleUpdateRoleEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RoleUpdate extends RoleUpdate {
  @override
  final RoleUpdateRoleEnum role;

  factory _$RoleUpdate([void Function(RoleUpdateBuilder)? updates]) =>
      (RoleUpdateBuilder()..update(updates))._build();

  _$RoleUpdate._({required this.role}) : super._();
  @override
  RoleUpdate rebuild(void Function(RoleUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleUpdateBuilder toBuilder() => RoleUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleUpdate && role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleUpdate')..add('role', role))
        .toString();
  }
}

class RoleUpdateBuilder implements Builder<RoleUpdate, RoleUpdateBuilder> {
  _$RoleUpdate? _$v;

  RoleUpdateRoleEnum? _role;
  RoleUpdateRoleEnum? get role => _$this._role;
  set role(RoleUpdateRoleEnum? role) => _$this._role = role;

  RoleUpdateBuilder() {
    RoleUpdate._defaults(this);
  }

  RoleUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleUpdate other) {
    _$v = other as _$RoleUpdate;
  }

  @override
  void update(void Function(RoleUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleUpdate build() => _build();

  _$RoleUpdate _build() {
    final _$result = _$v ??
        _$RoleUpdate._(
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'RoleUpdate', 'role'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
