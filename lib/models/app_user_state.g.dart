// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String?,
      isLoggedIn: json['isLoggedIn'] as bool?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      dismissed:
          (json['dismissed'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'isLoggedIn': instance.isLoggedIn,
      'displayName': instance.displayName,
      'email': instance.email,
      'friends': instance.friends,
      'dismissed': instance.dismissed,
    };
