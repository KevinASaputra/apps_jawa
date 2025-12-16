//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_create.g.dart';

/// FinanceCreate
///
/// Properties:
/// * [type] 
/// * [amount] 
/// * [description] 
/// * [date] 
@BuiltValue()
abstract class FinanceCreate implements Built<FinanceCreate, FinanceCreateBuilder> {
  @BuiltValueField(wireName: r'type')
  FinanceCreateTypeEnum get type;
  // enum typeEnum {  income,  expense,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'date')
  Date get date;

  FinanceCreate._();

  factory FinanceCreate([void updates(FinanceCreateBuilder b)]) = _$FinanceCreate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceCreateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceCreate> get serializer => _$FinanceCreateSerializer();
}

class _$FinanceCreateSerializer implements PrimitiveSerializer<FinanceCreate> {
  @override
  final Iterable<Type> types = const [FinanceCreate, _$FinanceCreate];

  @override
  final String wireName = r'FinanceCreate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceCreate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(FinanceCreateTypeEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceCreate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceCreateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceCreateTypeEnum),
          ) as FinanceCreateTypeEnum;
          result.type = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceCreate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceCreateBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class FinanceCreateTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'income')
  static const FinanceCreateTypeEnum income = _$financeCreateTypeEnum_income;
  @BuiltValueEnumConst(wireName: r'expense')
  static const FinanceCreateTypeEnum expense = _$financeCreateTypeEnum_expense;

  static Serializer<FinanceCreateTypeEnum> get serializer => _$financeCreateTypeEnumSerializer;

  const FinanceCreateTypeEnum._(String name): super(name);

  static BuiltSet<FinanceCreateTypeEnum> get values => _$financeCreateTypeEnumValues;
  static FinanceCreateTypeEnum valueOf(String name) => _$financeCreateTypeEnumValueOf(name);
}

