import 'package:eesup_dart_frog/core/env/env.dart';
import 'package:eesup_dart_frog/core/env/env_dev.dart';
import 'package:eesup_dart_frog/core/env/env_type.dart';


class EnvService {
  const EnvService(this.ty);

  final EnvType ty;

  String get supabaseUrl {
    switch (ty) {
      case EnvType.development:
        return EnvDev.supabaseUrl;
      case EnvType.production:
        return Env.supabaseUrl;
    }
  }

  String get supabaseServiceKey {
    switch (ty) {
      case EnvType.development:
        return EnvDev.supabaseServiceKey;
      case EnvType.production:
        return Env.supabaseServiceKey;
    }
  }

  String get oneSignalAppId {
    switch (ty) {
      case EnvType.development:
        return EnvDev.oneSignalAppId;
      case EnvType.production:
        return Env.oneSignalAppId;
    }
  }

  String get oneSignalApiKey {
    switch (ty) {
      case EnvType.development:
        return EnvDev.oneSignalApiKey;
      case EnvType.production:
        return Env.oneSignalApiKey;
    }
  }

  String get ozowSiteCode {
    switch (ty) {
      case EnvType.development:
        return EnvDev.ozowSiteCode;
      case EnvType.production:
        return Env.ozowSiteCode;
    }
  }

  String get ozowApiKey {
    switch (ty) {
      case EnvType.development:
        return EnvDev.ozowApiKey;
      case EnvType.production:
        return Env.ozowApiKey;
    }
  }

  String get ozowApiPrivateKey {
    switch (ty) {
      case EnvType.development:
        return EnvDev.ozowApiPrivateKey;
      case EnvType.production:
        return Env.ozowApiPrivateKey;
    }
  }
}
