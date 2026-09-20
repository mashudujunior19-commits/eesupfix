// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'organisation_form.dart';

class OrganisationFormMapper extends ClassMapperBase<OrganisationForm> {
  OrganisationFormMapper._();

  static OrganisationFormMapper? _instance;
  static OrganisationFormMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OrganisationFormMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OrganisationForm';

  static OrganisationType? _$orgType(OrganisationForm v) => v.orgType;
  static const Field<OrganisationForm, OrganisationType> _f$orgType = Field(
    'orgType',
    _$orgType,
    opt: true,
  );
  static OrganisationRegistrationStatus? _$registrationStatus(
    OrganisationForm v,
  ) => v.registrationStatus;
  static const Field<OrganisationForm, OrganisationRegistrationStatus>
  _f$registrationStatus = Field(
    'registrationStatus',
    _$registrationStatus,
    opt: true,
  );
  static String? _$name(OrganisationForm v) => v.name;
  static const Field<OrganisationForm, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$surname(OrganisationForm v) => v.surname;
  static const Field<OrganisationForm, String> _f$surname = Field(
    'surname',
    _$surname,
    opt: true,
  );
  static int? _$addressId(OrganisationForm v) => v.addressId;
  static const Field<OrganisationForm, int> _f$addressId = Field(
    'addressId',
    _$addressId,
    opt: true,
  );
  static Address? _$address(OrganisationForm v) => v.address;
  static const Field<OrganisationForm, Address> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static String? _$contactPerson1(OrganisationForm v) => v.contactPerson1;
  static const Field<OrganisationForm, String> _f$contactPerson1 = Field(
    'contactPerson1',
    _$contactPerson1,
    opt: true,
  );
  static String? _$contactPerson2(OrganisationForm v) => v.contactPerson2;
  static const Field<OrganisationForm, String> _f$contactPerson2 = Field(
    'contactPerson2',
    _$contactPerson2,
    opt: true,
  );
  static String? _$contactPerson3(OrganisationForm v) => v.contactPerson3;
  static const Field<OrganisationForm, String> _f$contactPerson3 = Field(
    'contactPerson3',
    _$contactPerson3,
    opt: true,
  );
  static OrganisationContactMethod? _$contactMethod(OrganisationForm v) =>
      v.contactMethod;
  static const Field<OrganisationForm, OrganisationContactMethod>
  _f$contactMethod = Field('contactMethod', _$contactMethod, opt: true);
  static String? _$contactValue(OrganisationForm v) => v.contactValue;
  static const Field<OrganisationForm, String> _f$contactValue = Field(
    'contactValue',
    _$contactValue,
    opt: true,
  );
  static String? _$companyRegistrationNumber(OrganisationForm v) =>
      v.companyRegistrationNumber;
  static const Field<OrganisationForm, String> _f$companyRegistrationNumber =
      Field(
        'companyRegistrationNumber',
        _$companyRegistrationNumber,
        opt: true,
      );
  static String? _$vatNumber(OrganisationForm v) => v.vatNumber;
  static const Field<OrganisationForm, String> _f$vatNumber = Field(
    'vatNumber',
    _$vatNumber,
    opt: true,
  );
  static String? _$industryType(OrganisationForm v) => v.industryType;
  static const Field<OrganisationForm, String> _f$industryType = Field(
    'industryType',
    _$industryType,
    opt: true,
  );
  static String? _$pboNumber(OrganisationForm v) => v.pboNumber;
  static const Field<OrganisationForm, String> _f$pboNumber = Field(
    'pboNumber',
    _$pboNumber,
    opt: true,
  );
  static String? _$socialDevelopmentNumber(OrganisationForm v) =>
      v.socialDevelopmentNumber;
  static const Field<OrganisationForm, String> _f$socialDevelopmentNumber =
      Field('socialDevelopmentNumber', _$socialDevelopmentNumber, opt: true);
  static String? _$errorMessage(OrganisationForm v) => v.errorMessage;
  static const Field<OrganisationForm, String> _f$errorMessage = Field(
    'errorMessage',
    _$errorMessage,
    opt: true,
  );
  static bool _$isLoading(OrganisationForm v) => v.isLoading;
  static const Field<OrganisationForm, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
  );
  static OrganisationSubmitStatus _$status(OrganisationForm v) => v.status;
  static const Field<OrganisationForm, OrganisationSubmitStatus> _f$status =
      Field('status', _$status);

  @override
  final MappableFields<OrganisationForm> fields = const {
    #orgType: _f$orgType,
    #registrationStatus: _f$registrationStatus,
    #name: _f$name,
    #surname: _f$surname,
    #addressId: _f$addressId,
    #address: _f$address,
    #contactPerson1: _f$contactPerson1,
    #contactPerson2: _f$contactPerson2,
    #contactPerson3: _f$contactPerson3,
    #contactMethod: _f$contactMethod,
    #contactValue: _f$contactValue,
    #companyRegistrationNumber: _f$companyRegistrationNumber,
    #vatNumber: _f$vatNumber,
    #industryType: _f$industryType,
    #pboNumber: _f$pboNumber,
    #socialDevelopmentNumber: _f$socialDevelopmentNumber,
    #errorMessage: _f$errorMessage,
    #isLoading: _f$isLoading,
    #status: _f$status,
  };

  static OrganisationForm _instantiate(DecodingData data) {
    return OrganisationForm(
      orgType: data.dec(_f$orgType),
      registrationStatus: data.dec(_f$registrationStatus),
      name: data.dec(_f$name),
      surname: data.dec(_f$surname),
      addressId: data.dec(_f$addressId),
      address: data.dec(_f$address),
      contactPerson1: data.dec(_f$contactPerson1),
      contactPerson2: data.dec(_f$contactPerson2),
      contactPerson3: data.dec(_f$contactPerson3),
      contactMethod: data.dec(_f$contactMethod),
      contactValue: data.dec(_f$contactValue),
      companyRegistrationNumber: data.dec(_f$companyRegistrationNumber),
      vatNumber: data.dec(_f$vatNumber),
      industryType: data.dec(_f$industryType),
      pboNumber: data.dec(_f$pboNumber),
      socialDevelopmentNumber: data.dec(_f$socialDevelopmentNumber),
      errorMessage: data.dec(_f$errorMessage),
      isLoading: data.dec(_f$isLoading),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin OrganisationFormMappable {
  OrganisationFormCopyWith<OrganisationForm, OrganisationForm, OrganisationForm>
  get copyWith =>
      _OrganisationFormCopyWithImpl<OrganisationForm, OrganisationForm>(
        this as OrganisationForm,
        $identity,
        $identity,
      );
  @override
  bool operator ==(Object other) {
    return OrganisationFormMapper.ensureInitialized().equalsValue(
      this as OrganisationForm,
      other,
    );
  }

  @override
  int get hashCode {
    return OrganisationFormMapper.ensureInitialized().hashValue(
      this as OrganisationForm,
    );
  }
}

extension OrganisationFormValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OrganisationForm, $Out> {
  OrganisationFormCopyWith<$R, OrganisationForm, $Out>
  get $asOrganisationForm =>
      $base.as((v, t, t2) => _OrganisationFormCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OrganisationFormCopyWith<$R, $In extends OrganisationForm, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    OrganisationType? orgType,
    OrganisationRegistrationStatus? registrationStatus,
    String? name,
    String? surname,
    int? addressId,
    Address? address,
    String? contactPerson1,
    String? contactPerson2,
    String? contactPerson3,
    OrganisationContactMethod? contactMethod,
    String? contactValue,
    String? companyRegistrationNumber,
    String? vatNumber,
    String? industryType,
    String? pboNumber,
    String? socialDevelopmentNumber,
    String? errorMessage,
    bool? isLoading,
    OrganisationSubmitStatus? status,
  });
  OrganisationFormCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OrganisationFormCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OrganisationForm, $Out>
    implements OrganisationFormCopyWith<$R, OrganisationForm, $Out> {
  _OrganisationFormCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OrganisationForm> $mapper =
      OrganisationFormMapper.ensureInitialized();
  @override
  $R call({
    Object? orgType = $none,
    Object? registrationStatus = $none,
    Object? name = $none,
    Object? surname = $none,
    Object? addressId = $none,
    Object? address = $none,
    Object? contactPerson1 = $none,
    Object? contactPerson2 = $none,
    Object? contactPerson3 = $none,
    Object? contactMethod = $none,
    Object? contactValue = $none,
    Object? companyRegistrationNumber = $none,
    Object? vatNumber = $none,
    Object? industryType = $none,
    Object? pboNumber = $none,
    Object? socialDevelopmentNumber = $none,
    Object? errorMessage = $none,
    bool? isLoading,
    OrganisationSubmitStatus? status,
  }) => $apply(
    FieldCopyWithData({
      if (orgType != $none) #orgType: orgType,
      if (registrationStatus != $none) #registrationStatus: registrationStatus,
      if (name != $none) #name: name,
      if (surname != $none) #surname: surname,
      if (addressId != $none) #addressId: addressId,
      if (address != $none) #address: address,
      if (contactPerson1 != $none) #contactPerson1: contactPerson1,
      if (contactPerson2 != $none) #contactPerson2: contactPerson2,
      if (contactPerson3 != $none) #contactPerson3: contactPerson3,
      if (contactMethod != $none) #contactMethod: contactMethod,
      if (contactValue != $none) #contactValue: contactValue,
      if (companyRegistrationNumber != $none)
        #companyRegistrationNumber: companyRegistrationNumber,
      if (vatNumber != $none) #vatNumber: vatNumber,
      if (industryType != $none) #industryType: industryType,
      if (pboNumber != $none) #pboNumber: pboNumber,
      if (socialDevelopmentNumber != $none)
        #socialDevelopmentNumber: socialDevelopmentNumber,
      if (errorMessage != $none) #errorMessage: errorMessage,
      if (isLoading != null) #isLoading: isLoading,
      if (status != null) #status: status,
    }),
  );
  @override
  OrganisationForm $make(CopyWithData data) => OrganisationForm(
    orgType: data.get(#orgType, or: $value.orgType),
    registrationStatus: data.get(
      #registrationStatus,
      or: $value.registrationStatus,
    ),
    name: data.get(#name, or: $value.name),
    surname: data.get(#surname, or: $value.surname),
    addressId: data.get(#addressId, or: $value.addressId),
    address: data.get(#address, or: $value.address),
    contactPerson1: data.get(#contactPerson1, or: $value.contactPerson1),
    contactPerson2: data.get(#contactPerson2, or: $value.contactPerson2),
    contactPerson3: data.get(#contactPerson3, or: $value.contactPerson3),
    contactMethod: data.get(#contactMethod, or: $value.contactMethod),
    contactValue: data.get(#contactValue, or: $value.contactValue),
    companyRegistrationNumber: data.get(
      #companyRegistrationNumber,
      or: $value.companyRegistrationNumber,
    ),
    vatNumber: data.get(#vatNumber, or: $value.vatNumber),
    industryType: data.get(#industryType, or: $value.industryType),
    pboNumber: data.get(#pboNumber, or: $value.pboNumber),
    socialDevelopmentNumber: data.get(
      #socialDevelopmentNumber,
      or: $value.socialDevelopmentNumber,
    ),
    errorMessage: data.get(#errorMessage, or: $value.errorMessage),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    status: data.get(#status, or: $value.status),
  );

  @override
  OrganisationFormCopyWith<$R2, OrganisationForm, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OrganisationFormCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

