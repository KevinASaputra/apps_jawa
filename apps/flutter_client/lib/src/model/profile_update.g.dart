// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfileUpdate extends ProfileUpdate {
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final Date? birthDate;

  factory _$ProfileUpdate([void Function(ProfileUpdateBuilder)? updates]) =>
      (ProfileUpdateBuilder()..update(updates))._build();

  _$ProfileUpdate._({this.address, this.phone, this.birthDate}) : super._();
  @override
  ProfileUpdate rebuild(void Function(ProfileUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileUpdateBuilder toBuilder() => ProfileUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileUpdate &&
        address == other.address &&
        phone == other.phone &&
        birthDate == other.birthDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, birthDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileUpdate')
          ..add('address', address)
          ..add('phone', phone)
          ..add('birthDate', birthDate))
        .toString();
  }
}

class ProfileUpdateBuilder
    implements Builder<ProfileUpdate, ProfileUpdateBuilder> {
  _$ProfileUpdate? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  Date? _birthDate;
  Date? get birthDate => _$this._birthDate;
  set birthDate(Date? birthDate) => _$this._birthDate = birthDate;

  ProfileUpdateBuilder() {
    ProfileUpdate._defaults(this);
  }

  ProfileUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _phone = $v.phone;
      _birthDate = $v.birthDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileUpdate other) {
    _$v = other as _$ProfileUpdate;
  }

  @override
  void update(void Function(ProfileUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileUpdate build() => _build();

  _$ProfileUpdate _build() {
    final _$result = _$v ??
        _$ProfileUpdate._(
          address: address,
          phone: phone,
          birthDate: birthDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
