// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_create.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceCreateTypeEnum _$financeCreateTypeEnum_income =
    const FinanceCreateTypeEnum._('income');
const FinanceCreateTypeEnum _$financeCreateTypeEnum_expense =
    const FinanceCreateTypeEnum._('expense');

FinanceCreateTypeEnum _$financeCreateTypeEnumValueOf(String name) {
  switch (name) {
    case 'income':
      return _$financeCreateTypeEnum_income;
    case 'expense':
      return _$financeCreateTypeEnum_expense;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceCreateTypeEnum> _$financeCreateTypeEnumValues =
    BuiltSet<FinanceCreateTypeEnum>(const <FinanceCreateTypeEnum>[
  _$financeCreateTypeEnum_income,
  _$financeCreateTypeEnum_expense,
]);

Serializer<FinanceCreateTypeEnum> _$financeCreateTypeEnumSerializer =
    _$FinanceCreateTypeEnumSerializer();

class _$FinanceCreateTypeEnumSerializer
    implements PrimitiveSerializer<FinanceCreateTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'income': 'income',
    'expense': 'expense',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'income': 'income',
    'expense': 'expense',
  };

  @override
  final Iterable<Type> types = const <Type>[FinanceCreateTypeEnum];
  @override
  final String wireName = 'FinanceCreateTypeEnum';

  @override
  Object serialize(Serializers serializers, FinanceCreateTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinanceCreateTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinanceCreateTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinanceCreate extends FinanceCreate {
  @override
  final FinanceCreateTypeEnum type;
  @override
  final num amount;
  @override
  final String? description;
  @override
  final Date date;

  factory _$FinanceCreate([void Function(FinanceCreateBuilder)? updates]) =>
      (FinanceCreateBuilder()..update(updates))._build();

  _$FinanceCreate._(
      {required this.type,
      required this.amount,
      this.description,
      required this.date})
      : super._();
  @override
  FinanceCreate rebuild(void Function(FinanceCreateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceCreateBuilder toBuilder() => FinanceCreateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceCreate &&
        type == other.type &&
        amount == other.amount &&
        description == other.description &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceCreate')
          ..add('type', type)
          ..add('amount', amount)
          ..add('description', description)
          ..add('date', date))
        .toString();
  }
}

class FinanceCreateBuilder
    implements Builder<FinanceCreate, FinanceCreateBuilder> {
  _$FinanceCreate? _$v;

  FinanceCreateTypeEnum? _type;
  FinanceCreateTypeEnum? get type => _$this._type;
  set type(FinanceCreateTypeEnum? type) => _$this._type = type;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  FinanceCreateBuilder() {
    FinanceCreate._defaults(this);
  }

  FinanceCreateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _amount = $v.amount;
      _description = $v.description;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceCreate other) {
    _$v = other as _$FinanceCreate;
  }

  @override
  void update(void Function(FinanceCreateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceCreate build() => _build();

  _$FinanceCreate _build() {
    final _$result = _$v ??
        _$FinanceCreate._(
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'FinanceCreate', 'type'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'FinanceCreate', 'amount'),
          description: description,
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'FinanceCreate', 'date'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
