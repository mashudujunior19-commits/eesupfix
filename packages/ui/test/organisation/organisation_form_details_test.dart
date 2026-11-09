import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/picked_document.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';

OrganisationForm _form(OrganisationKind kind, RegistrationStatus status) =>
    OrganisationForm.initial()
        .copyWith(orgKind: kind, registrationStatus: status);

void main() {
  group('registered business', () {
    final base =
        _form(OrganisationKind.business, RegistrationStatus.registered);

    test('needs the CIPC number, then the tax number', () {
      expect(base.missingTypedDetail, 'Please enter the CIPC registration number.');
      final withCipc = base.updateDetails(registrationNumber: '2019/1/07');
      expect(withCipc.missingTypedDetail, 'Please enter the tax number.');
      final complete = withCipc.updateDetails(taxNumber: '9000');
      expect(complete.missingTypedDetail, isNull);
    });

    test('the CIPC document is mandatory', () {
      expect(base.requiredDocumentTypes, contains(DocumentType.cipcDocument));
    });

    test('the registration details are saved on the submission', () {
      final s = base
          .updateDetails(
            organisationName: 'Acme',
            industryType: 'Retail',
            registrationNumber: ' 2019/1/07 ',
            taxNumber: '9000',
          )
          .toSubmission();
      expect(s.registrationNumber, '2019/1/07');
      expect(s.taxNumber, '9000');
      expect(s.toJson()['registration_number'], '2019/1/07');
    });
  });

  group('registered NPO', () {
    final base = _form(OrganisationKind.publicBenefit, RegistrationStatus.registered);

    test('the NPO number is mandatory', () {
      expect(base.missingTypedDetail, 'Please enter the NPO registration number.');
      expect(base.updateDetails(socialDevelopmentNumber: '123-456 NPO').missingTypedDetail,
          isNull);
    });

    test('documents are mandatory without opting into KasiLift', () {
      expect(base.isKasilift, isFalse);
      expect(base.requiredDocumentTypes, isNotEmpty);
      expect(base.hasAllRequiredDocuments, isFalse);
    });
  });

  test('an unregistered business is asked for no registration numbers', () {
    final f = _form(OrganisationKind.business, RegistrationStatus.unregistered);
    expect(f.missingTypedDetail, isNull);
    expect(f.requiredDocumentTypes, isEmpty);
  });
}
