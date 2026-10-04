import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';

/// Which legal document [TermsOfServiceScreen] opens on.
enum LegalDocument {
  termsAndConditions(
      'Terms & Conditions', 'assets/legal/terms_and_conditions.pdf'),
  privacyPolicy('Privacy Policy', 'assets/legal/privacy_policy.pdf');

  const LegalDocument(this.title, this.assetPath);
  final String title;
  final String assetPath;
}

/// EESUp's Terms and Conditions and Privacy Policy, bundled with the app as
/// PDFs (app/assets/legal) so they show offline and on every platform.
@RoutePage()
class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({
    super.key,
    this.initialDocument = LegalDocument.termsAndConditions,
  });
  static const route = '/terms-and-conditions';

  final LegalDocument initialDocument;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: LegalDocument.values.length,
      initialIndex: initialDocument.index,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: false,
          title: const Text('Legal'),
          bottom: TabBar(
            labelColor: context.colorScheme.primary,
            indicatorColor: context.colorScheme.primary,
            tabs: [
              for (final doc in LegalDocument.values) Tab(text: doc.title),
            ],
          ),
        ),
        body: TabBarView(
          // Swiping would fight the PDF viewer's own horizontal scrolling.
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final doc in LegalDocument.values)
              SfPdfViewer.asset(
                doc.assetPath,
                canShowScrollHead: false,
                pageSpacing: 2,
              ),
          ],
        ),
      ),
    );
  }
}
