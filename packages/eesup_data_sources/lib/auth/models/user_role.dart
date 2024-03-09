// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  Ubuntunist,
  EESUpreneur,
  EESUpromoter,
  Corporate,
  EESUpliftCorporate,
  Admin,
  Driver,
  Spaza;

  @override
  String toString() {
    switch (this) {
      case UserRole.Ubuntunist:
        return 'Ubuntunist';
      case UserRole.EESUpreneur:
        return 'EESUpreneur';
      case UserRole.EESUpromoter:
        return 'EESUpromoter';
      case UserRole.Corporate:
        return 'Corporate';
      case UserRole.EESUpliftCorporate:
        return 'EESUplift-Corporate';
      case UserRole.Admin:
        return 'Admin';
      case UserRole.Driver:
        return 'Driver';
      case UserRole.Spaza:
        return 'Spaza';
      default:
        throw Exception('Unknown role: $this');
    }
  }

  factory UserRole.fromStr(String role) {
    switch (role) {
      case 'Ubuntunist':
        return UserRole.Ubuntunist;
      case 'EESUpreneur':
        return UserRole.EESUpreneur;
      case 'EESUpromoter':
        return UserRole.EESUpromoter;
      case 'Corporate':
        return UserRole.Corporate;
      case 'EESUplift-Corporate':
        return UserRole.EESUpliftCorporate;
      case 'Admin':
        return UserRole.Admin;
      case 'Driver':
        return UserRole.Driver;
      case 'Spaza':
        return UserRole.Spaza;
      default:
        throw Exception('Unknown role: $role');
    }
  }
}


class UserRoleConverter implements JsonConverter<UserRole, String> {
  const UserRoleConverter();

  @override
  UserRole fromJson(String json) => UserRole.fromStr(json);

  @override
  String toJson(UserRole object) => object.toString();
}