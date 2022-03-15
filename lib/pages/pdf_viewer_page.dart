import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import '../components/custom_app_bar.dart';

import 'dart:developer';
import 'package:pdfx/pdfx.dart';

class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({Key? key}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => PdfViewerPageState();
}

PdfController pdfController = PdfController(
    document: PdfDocument.openAsset('assets/lessonPdfs/lesson2.pdf'));

class PdfViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, 'PDF Viewer'),
        body: PdfView(controller: pdfController));
  }
}
