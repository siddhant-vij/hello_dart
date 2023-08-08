// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hello_null_collections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      emails:
          (json['emails'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'emails': instance.emails,
    };

Widget _$WidgetFromJson(Map<String, dynamic> json) => Widget(
      (json['width'] as num).toDouble(),
      (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$WidgetToJson(Widget instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
