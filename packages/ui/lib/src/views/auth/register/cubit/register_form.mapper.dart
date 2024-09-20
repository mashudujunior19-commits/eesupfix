// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'register_form.dart';

class RegisterFormMapper extends ClassMapperBase<RegisterForm> {
  RegisterFormMapper._();

  static RegisterFormMapper? _instance;
  static RegisterFormMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterFormMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterForm';

  static String? _$firstName(RegisterForm v) => v.firstName;
  static const Field<RegisterForm, String> _f$firstName =
      Field('firstName', _$firstName, opt: true);
  static String? _$lastName(RegisterForm v) => v.lastName;
  static const Field<RegisterForm, String> _f$lastName =
      Field('lastName', _$lastName, opt: true);
  static String? _$idNumber(RegisterForm v) => v.idNumber;
  static const Field<RegisterForm, String> _f$idNumber =
      Field('idNumber', _$idNumber, opt: true);
  static DateTime? _$dob(RegisterForm v) => v.dob;
  static const Field<RegisterForm, DateTime> _f$dob =
      Field('dob', _$dob, opt: true);
  static String? _$corpName(RegisterForm v) => v.corpName;
  static const Field<RegisterForm, String> _f$corpName =
      Field('corpName', _$corpName, opt: true);
  static String? _$corpReg(RegisterForm v) => v.corpReg;
  static const Field<RegisterForm, String> _f$corpReg =
      Field('corpReg', _$corpReg, opt: true);
  static String? _$npcCorpReg(RegisterForm v) => v.npcCorpReg;
  static const Field<RegisterForm, String> _f$npcCorpReg =
      Field('npcCorpReg', _$npcCorpReg, opt: true);
  static String? _$email(RegisterForm v) => v.email;
  static const Field<RegisterForm, String> _f$email =
      Field('email', _$email, opt: true);
  static String? _$phone(RegisterForm v) => v.phone;
  static const Field<RegisterForm, String> _f$phone =
      Field('phone', _$phone, opt: true);
  static int? _$referralCode(RegisterForm v) => v.referralCode;
  static const Field<RegisterForm, int> _f$referralCode =
      Field('referralCode', _$referralCode, opt: true);
  static String? _$password(RegisterForm v) => v.password;
  static const Field<RegisterForm, String> _f$password =
      Field('password', _$password, opt: true);
  static String? _$retypedPassword(RegisterForm v) => v.retypedPassword;
  static const Field<RegisterForm, String> _f$retypedPassword =
      Field('retypedPassword', _$retypedPassword, opt: true);
  static String? _$errorMessage(RegisterForm v) => v.errorMessage;
  static const Field<RegisterForm, String> _f$errorMessage =
      Field('errorMessage', _$errorMessage, opt: true);
  static bool _$isRSACitizen(RegisterForm v) => v.isRSACitizen;
  static const Field<RegisterForm, bool> _f$isRSACitizen =
      Field('isRSACitizen', _$isRSACitizen);
  static bool _$isPasswordValid(RegisterForm v) => v.isPasswordValid;
  static const Field<RegisterForm, bool> _f$isPasswordValid =
      Field('isPasswordValid', _$isPasswordValid);
  static bool _$isLoading(RegisterForm v) => v.isLoading;
  static const Field<RegisterForm, bool> _f$isLoading =
      Field('isLoading', _$isLoading);
  static RegisterStatus _$status(RegisterForm v) => v.status;
  static const Field<RegisterForm, RegisterStatus> _f$status =
      Field('status', _$status);
  static bool _$agreedToTcsAndCs(RegisterForm v) => v.agreedToTcsAndCs;
  static const Field<RegisterForm, bool> _f$agreedToTcsAndCs =
      Field('agreedToTcsAndCs', _$agreedToTcsAndCs);
  static bool _$isCorp(RegisterForm v) => v.isCorp;
  static const Field<RegisterForm, bool> _f$isCorp = Field('isCorp', _$isCorp);

  @override
  final MappableFields<RegisterForm> fields = const {
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #idNumber: _f$idNumber,
    #dob: _f$dob,
    #corpName: _f$corpName,
    #corpReg: _f$corpReg,
    #npcCorpReg: _f$npcCorpReg,
    #email: _f$email,
    #phone: _f$phone,
    #referralCode: _f$referralCode,
    #password: _f$password,
    #retypedPassword: _f$retypedPassword,
    #errorMessage: _f$errorMessage,
    #isRSACitizen: _f$isRSACitizen,
    #isPasswordValid: _f$isPasswordValid,
    #isLoading: _f$isLoading,
    #status: _f$status,
    #agreedToTcsAndCs: _f$agreedToTcsAndCs,
    #isCorp: _f$isCorp,
  };

  static RegisterForm _instantiate(DecodingData data) {
    return RegisterForm(
        firstName: data.dec(_f$firstName),
        lastName: data.dec(_f$lastName),
        idNumber: data.dec(_f$idNumber),
        dob: data.dec(_f$dob),
        corpName: data.dec(_f$corpName),
        corpReg: data.dec(_f$corpReg),
        npcCorpReg: data.dec(_f$npcCorpReg),
        email: data.dec(_f$email),
        phone: data.dec(_f$phone),
        referralCode: data.dec(_f$referralCode),
        password: data.dec(_f$password),
        retypedPassword: data.dec(_f$retypedPassword),
        errorMessage: data.dec(_f$errorMessage),
        isRSACitizen: data.dec(_f$isRSACitizen),
        isPasswordValid: data.dec(_f$isPasswordValid),
        isLoading: data.dec(_f$isLoading),
        status: data.dec(_f$status),
        agreedToTcsAndCs: data.dec(_f$agreedToTcsAndCs),
        isCorp: data.dec(_f$isCorp));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin RegisterFormMappable {
  RegisterFormCopyWith<RegisterForm, RegisterForm, RegisterForm> get copyWith =>
      _RegisterFormCopyWithImpl(this as RegisterForm, $identity, $identity);
  @override
  bool operator ==(Object other) {
    return RegisterFormMapper.ensureInitialized()
        .equalsValue(this as RegisterForm, other);
  }

  @override
  int get hashCode {
    return RegisterFormMapper.ensureInitialized()
        .hashValue(this as RegisterForm);
  }
}

extension RegisterFormValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterForm, $Out> {
  RegisterFormCopyWith<$R, RegisterForm, $Out> get $asRegisterForm =>
      $base.as((v, t, t2) => _RegisterFormCopyWithImpl(v, t, t2));
}

abstract class RegisterFormCopyWith<$R, $In extends RegisterForm, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? firstName,
      String? lastName,
      String? idNumber,
      DateTime? dob,
      String? corpName,
      String? corpReg,
      String? npcCorpReg,
      String? email,
      String? phone,
      int? referralCode,
      String? password,
      String? retypedPassword,
      String? errorMessage,
      bool? isRSACitizen,
      bool? isPasswordValid,
      bool? isLoading,
      RegisterStatus? status,
      bool? agreedToTcsAndCs,
      bool? isCorp});
  RegisterFormCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RegisterFormCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterForm, $Out>
    implements RegisterFormCopyWith<$R, RegisterForm, $Out> {
  _RegisterFormCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterForm> $mapper =
      RegisterFormMapper.ensureInitialized();
  @override
  $R call(
          {Object? firstName = $none,
          Object? lastName = $none,
          Object? idNumber = $none,
          Object? dob = $none,
          Object? corpName = $none,
          Object? corpReg = $none,
          Object? npcCorpReg = $none,
          Object? email = $none,
          Object? phone = $none,
          Object? referralCode = $none,
          Object? password = $none,
          Object? retypedPassword = $none,
          Object? errorMessage = $none,
          bool? isRSACitizen,
          bool? isPasswordValid,
          bool? isLoading,
          RegisterStatus? status,
          bool? agreedToTcsAndCs,
          bool? isCorp}) =>
      $apply(FieldCopyWithData({
        if (firstName != $none) #firstName: firstName,
        if (lastName != $none) #lastName: lastName,
        if (idNumber != $none) #idNumber: idNumber,
        if (dob != $none) #dob: dob,
        if (corpName != $none) #corpName: corpName,
        if (corpReg != $none) #corpReg: corpReg,
        if (npcCorpReg != $none) #npcCorpReg: npcCorpReg,
        if (email != $none) #email: email,
        if (phone != $none) #phone: phone,
        if (referralCode != $none) #referralCode: referralCode,
        if (password != $none) #password: password,
        if (retypedPassword != $none) #retypedPassword: retypedPassword,
        if (errorMessage != $none) #errorMessage: errorMessage,
        if (isRSACitizen != null) #isRSACitizen: isRSACitizen,
        if (isPasswordValid != null) #isPasswordValid: isPasswordValid,
        if (isLoading != null) #isLoading: isLoading,
        if (status != null) #status: status,
        if (agreedToTcsAndCs != null) #agreedToTcsAndCs: agreedToTcsAndCs,
        if (isCorp != null) #isCorp: isCorp
      }));
  @override
  RegisterForm $make(CopyWithData data) => RegisterForm(
      firstName: data.get(#firstName, or: $value.firstName),
      lastName: data.get(#lastName, or: $value.lastName),
      idNumber: data.get(#idNumber, or: $value.idNumber),
      dob: data.get(#dob, or: $value.dob),
      corpName: data.get(#corpName, or: $value.corpName),
      corpReg: data.get(#corpReg, or: $value.corpReg),
      npcCorpReg: data.get(#npcCorpReg, or: $value.npcCorpReg),
      email: data.get(#email, or: $value.email),
      phone: data.get(#phone, or: $value.phone),
      referralCode: data.get(#referralCode, or: $value.referralCode),
      password: data.get(#password, or: $value.password),
      retypedPassword: data.get(#retypedPassword, or: $value.retypedPassword),
      errorMessage: data.get(#errorMessage, or: $value.errorMessage),
      isRSACitizen: data.get(#isRSACitizen, or: $value.isRSACitizen),
      isPasswordValid: data.get(#isPasswordValid, or: $value.isPasswordValid),
      isLoading: data.get(#isLoading, or: $value.isLoading),
      status: data.get(#status, or: $value.status),
      agreedToTcsAndCs:
          data.get(#agreedToTcsAndCs, or: $value.agreedToTcsAndCs),
      isCorp: data.get(#isCorp, or: $value.isCorp));

  @override
  RegisterFormCopyWith<$R2, RegisterForm, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegisterFormCopyWithImpl($value, $cast, t);
}
