//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checkout_result.g.dart';

/// CheckoutResult
///
/// Properties:
/// * [orderId] 
/// * [message] 
@BuiltValue()
abstract class CheckoutResult implements Built<CheckoutResult, CheckoutResultBuilder> {
  @BuiltValueField(wireName: r'orderId')
  num? get orderId;

  @BuiltValueField(wireName: r'message')
  String? get message;

  CheckoutResult._();

  factory CheckoutResult([void updates(CheckoutResultBuilder b)]) = _$CheckoutResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckoutResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckoutResult> get serializer => _$CheckoutResultSerializer();
}

class _$CheckoutResultSerializer implements PrimitiveSerializer<CheckoutResult> {
  @override
  final Iterable<Type> types = const [CheckoutResult, _$CheckoutResult];

  @override
  final String wireName = r'CheckoutResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckoutResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.orderId != null) {
      yield r'orderId';
      yield serializers.serialize(
        object.orderId,
        specifiedType: const FullType(num),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckoutResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CheckoutResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.orderId = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckoutResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckoutResultBuilder();
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

