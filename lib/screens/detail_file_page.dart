// import 'dart:io';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_filereader/flutter_filereader.dart';
// import 'package:get/get.dart';
// import 'package:blades/utils/dimentions.dart';
// import 'package:blades/utils/status_bar.dart';

// class FileDetailPage extends StatefulWidget {
//   final String contentUrl;
//   const FileDetailPage({Key? key, required this.contentUrl}) : super(key: key);

//   @override
//   _FileDetailPageState createState() => _FileDetailPageState();
// }

// class _FileDetailPageState extends State<FileDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     AppHelper.setStatusbar();
//     // if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }

//   Future<void> view() async {
//     // Load from assets

// // Load from URL
//     PDFDocument doc = await PDFDocument.fromURL(
//         'http://www.africau.edu/images/default/sample.pdf');
//     PDFViewer(document: doc);
// // Load from file
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Future<void> openFile() async {
//     //   try {
//     //     FilePickerResult? result = await FilePicker.platform.pickFiles(
//     //       allowMultiple: false,
//     //       type: FileType.custom,
//     //       allowedExtensions: [
//     //         'jpg',
//     //         'pdf',
//     //         'doc',
//     //         'mp4',
//     //         'docx',
//     //         'ppt',
//     //         'xlsx',
//     //         'png'
//     //       ],
//     //     );
//     //     if (result != null) {
//     //       var filePath = result.files.first.path;
//     //       final _result = await OpenFile.open(filePath);
//     //       setState(() {});
//     //     } else {
//     //       print("error");
//     //     }
//     //   } catch (e) {
//     //     print(e.toString());
//     //   }
//     // }

//     // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//     // return SafeArea(
//     //   child: Scaffold(
//     //     appBar: PreferredSize(
//     //       preferredSize:
//     //           Size.fromHeight(Get.height * 0.12), // here the desired height
//     //       child: Padding(
//     //         padding: EdgeInsets.symmetric(
//     //             horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
//     //         child: Column(
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           children: [
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //               children: [
//     //                 InkWell(
//     //                   onTap: () {
//     //                     Get.back();
//     //                   },
//     //                   child: Card(
//     //                     shape: OutlineInputBorder(
//     //                         borderRadius: BorderRadius.circular(9),
//     //                         borderSide: const BorderSide(
//     //                             width: 0, color: Colors.white)),
//     //                     elevation: 3.5,
//     //                     child: Padding(
//     //                         padding: EdgeInsets.all(Get.width * 0.02),
//     //                         child: const Icon(Icons.arrow_back)),
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                   height: mHeight * 0.07,
//     //                   child: Image.asset(
//     //                     "assets/icons/logo.png",
//     //                     fit: BoxFit.fitHeight,
//     //                   ),
//     //                 ),
//     //                 SizedBox(
//     //                   width: Get.width * 0.12,
//     //                 ),
//     //               ],
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //     // body: WebView(
//     //     //   initialUrl: widget.contentUrl,
//     //     //   javascriptMode: JavascriptMode.unrestricted,
//     //     // ),
//     //     // body: SfPdfViewer.network(
//     //     //   widget.contentUrl,
//     //     //   key: _pdfViewerKey,
//     //     // ),
//     //     // floatingActionButton: FloatingActionButton(
//     //     //   onPressed: () {
//     //     //     openFile();
//     //     //   },
//     //     // ),
//     //   ),
//     // );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("doc"),
//       ),
//       body: FileReaderView(
//         loadingWidget: CircularProgressIndicator(),
//         filePath: widget.contentUrl,
//       ),
//     );
//   }
// }
