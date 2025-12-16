// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_create.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FamilyMemberCreate extends FamilyMemberCreate {
  @override
  final String name;
  @override
  final String relation;
  @override
  final Date? birthDate;

  factory _$FamilyMemberCreate(
          [void Function(FamilyMemberCreateBuilder)? updates]) =>
      (FamilyMemberCreateBuilder()..update(updates))._build();

  _$FamilyMemberCreate._(
      {required this.name, required this.relation, this.birthDate})
      : super._();
  @override
  FamilyMemberCreate rebuild(
          void Function(FamilyMemberCreateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FamilyMemberCreateBuilder toBuilder() =>
      FamilyMemberCreateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FamilyMemberCreate &&
        name == other.name &&
        relation == other.relation &&
        birthDate == other.birthDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, relation.hashCode);
    _$hash = $jc(_$hash, birthDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FamilyMemberCreate')
          ..add('name', name)
          ..add('relation', relation)
          ..add('birthDate', birthDate))
        .toString();
  }
}

class FamilyMemberCreateBuilder
    implements Builder<FamilyMemberCreate, FamilyMemberCreateBuilder> {
  _$FamilyMemberCreate? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _relation;
  String? get relation => _$this._relation;
  set relation(String? relation) => _$this._relation = relation;

  Date? _birthDate;
  Date? get birthDate => _$this._birthDate;
  set birthDate(Date? birthDate) => _$this._birthDate = birthDate;

  FamilyMemberCreateBuilder() {
    FamilyMemberCreate._defaults(this);
  }

  FamilyMemberCreateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _relation = $v.relation;
      _birthDate = $v.birthDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FamilyMemberCreate other) {
    _$v = other as _$FamilyMemberCreate;
  }

  @override
  void update(void Function(FamilyMemberCreateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FamilyMemberCreate build() => _build();

  _$FamilyMemberCreate _build() {
    final _$result = _$v ??
        _$FamilyMemberCreate._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'FamilyMemberCreate', 'name'),
          relation: BuiltValueNullFieldError.checkNotNull(
              relation, r'FamilyMemberCreate', 'relation'),
          birthDate: birthDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
