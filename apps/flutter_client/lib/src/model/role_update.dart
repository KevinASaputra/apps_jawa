//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_update.g.dart';

/// RoleUpdate
///
/// Properties:
/// * [role] 
@BuiltValue()
abstract class RoleUpdate implements Built<RoleUpdate, RoleUpdateBuilder> {
  @BuiltValueField(wireName: r'role')
  RoleUpdateRoleEnum get role;
  // enum roleEnum {  Buyer,  Seller,  };

  RoleUpdate._();

  factory RoleUpdate([void updates(RoleUpdateBuilder b)]) = _$RoleUpdate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleUpdateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleUpdate> get serializer => _$RoleUpdateSerializer();
}

class _$RoleUpdateSerializer implements PrimitiveSerializer<RoleUpdate> {
  @override
  final Iterable<Type> types = const [RoleUpdate, _$RoleUpdate];

  @override
  final String wireName = r'RoleUpdate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(RoleUpdateRoleEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleUpdateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RoleUpdateRoleEnum),
          ) as RoleUpdateRoleEnum;
          result.role = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleUpdate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleUpdateBuilder();
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

class RoleUpdateRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Buyer')
  static const RoleUpdateRoleEnum buyer = _$roleUpdateRoleEnum_buyer;
  @BuiltValueEnumConst(wireName: r'Seller')
  static const RoleUpdateRoleEnum seller = _$roleUpdateRoleEnum_seller;

  static Serializer<RoleUpdateRoleEnum> get serializer => _$roleUpdateRoleEnumSerializer;

  const RoleUpdateRoleEnum._(String name): super(name);

  static BuiltSet<RoleUpdateRoleEnum> get values => _$roleUpdateRoleEnumValues;
  static RoleUpdateRoleEnum valueOf(String name) => _$roleUpdateRoleEnumValueOf(name);
}

