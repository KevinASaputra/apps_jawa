//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'family_member_create.g.dart';

/// FamilyMemberCreate
///
/// Properties:
/// * [name] 
/// * [relation] 
/// * [birthDate] 
@BuiltValue()
abstract class FamilyMemberCreate implements Built<FamilyMemberCreate, FamilyMemberCreateBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'relation')
  String get relation;

  @BuiltValueField(wireName: r'birth_date')
  Date? get birthDate;

  FamilyMemberCreate._();

  factory FamilyMemberCreate([void updates(FamilyMemberCreateBuilder b)]) = _$FamilyMemberCreate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FamilyMemberCreateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FamilyMemberCreate> get serializer => _$FamilyMemberCreateSerializer();
}

class _$FamilyMemberCreateSerializer implements PrimitiveSerializer<FamilyMemberCreate> {
  @override
  final Iterable<Type> types = const [FamilyMemberCreate, _$FamilyMemberCreate];

  @override
  final String wireName = r'FamilyMemberCreate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FamilyMemberCreate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'relation';
    yield serializers.serialize(
      object.relation,
      specifiedType: const FullType(String),
    );
    if (object.birthDate != null) {
      yield r'birth_date';
      yield serializers.serialize(
        object.birthDate,
        specifiedType: const FullType(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FamilyMemberCreate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FamilyMemberCreateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'relation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.relation = valueDes;
          break;
        case r'birth_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.birthDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FamilyMemberCreate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FamilyMemberCreateBuilder();
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

