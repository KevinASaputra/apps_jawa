//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/activity_create.dart';
import 'package:openapi/src/model/cart_add.dart';
import 'package:openapi/src/model/family_member_create.dart';
import 'package:openapi/src/model/finance_create.dart';
import 'package:openapi/src/model/login_request.dart';
import 'package:openapi/src/model/product_create.dart';
import 'package:openapi/src/model/profile_update.dart';
import 'package:openapi/src/model/register_request.dart';
import 'package:openapi/src/model/role_update.dart';

part 'serializers.g.dart';

@SerializersFor([
  ActivityCreate,
  CartAdd,
  FamilyMemberCreate,
  FinanceCreate,
  LoginRequest,
  ProductCreate,
  ProfileUpdate,
  RegisterRequest,
  RoleUpdate,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
