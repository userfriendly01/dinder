// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      isLoggedIn: json['isLoggedIn'] as bool,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'displayName': instance.displayName,
      'email': instance.email,
    };
