import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TermsConditionPage extends StatelessWidget {
  static String routeName = 'terms_condition';
  const TermsConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfPdfViewer.asset(
          'assets/pdf/librepago.pdf',
          pageLayoutMode: PdfPageLayoutMode.continuous,
        ),
      ),
    );
  }
}
