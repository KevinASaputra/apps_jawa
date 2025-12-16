// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_create.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductCreate extends ProductCreate {
  @override
  final String name;
  @override
  final String? description;
  @override
  final num price;
  @override
  final num? stock;

  factory _$ProductCreate([void Function(ProductCreateBuilder)? updates]) =>
      (ProductCreateBuilder()..update(updates))._build();

  _$ProductCreate._(
      {required this.name, this.description, required this.price, this.stock})
      : super._();
  @override
  ProductCreate rebuild(void Function(ProductCreateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductCreateBuilder toBuilder() => ProductCreateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductCreate &&
        name == other.name &&
        description == other.description &&
        price == other.price &&
        stock == other.stock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, stock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductCreate')
          ..add('name', name)
          ..add('description', description)
          ..add('price', price)
          ..add('stock', stock))
        .toString();
  }
}

class ProductCreateBuilder
    implements Builder<ProductCreate, ProductCreateBuilder> {
  _$ProductCreate? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  num? _stock;
  num? get stock => _$this._stock;
  set stock(num? stock) => _$this._stock = stock;

  ProductCreateBuilder() {
    ProductCreate._defaults(this);
  }

  ProductCreateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _price = $v.price;
      _stock = $v.stock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductCreate other) {
    _$v = other as _$ProductCreate;
  }

  @override
  void update(void Function(ProductCreateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductCreate build() => _build();

  _$ProductCreate _build() {
    final _$result = _$v ??
        _$ProductCreate._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'ProductCreate', 'name'),
          description: description,
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'ProductCreate', 'price'),
          stock: stock,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
