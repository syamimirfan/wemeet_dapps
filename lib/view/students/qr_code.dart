import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_lecturers.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String lectName = "";

  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
            "Scan Qr Code",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        actions: [
           IconButton(
              onPressed: () { 
                nextScreen(context, About());
              },
              icon: Icon(Icons.info_outline_rounded)
             ),
        ],
      ),
      body: _buildQrView(context),
      floatingActionButton: controller != null
          ? FloatingActionButton(
            backgroundColor: Constants().secondaryColor,
              onPressed: () {
                if (controller != null) {
                  controller!.toggleFlash();
                }
              },
              child: Icon(Icons.flash_on),
            )
          : null,
    );
  }

goMetamask(var url) async {
       Uri uri = Uri.parse(url);
    await launchUrl(uri); 
}

void _onQRViewCreated(QRViewController controller) {
  setState(() {
    this.controller = controller;
  });
   controller.resumeCamera();
  controller.scannedDataStream.listen((scanData) async {
    if (mounted) {
      setState(() {
        result = scanData;
      });
      
      await goMetamask(result!.code);
    }
  });
 }

 Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
  }


     //to view some of lecturer data  
   viewLecturer(String? staffNo) async {
      var responseLecturer = await new Lecturer().getLecturerDetail(staffNo!);
      if(responseLecturer['success']) {
         setState(()  {
           lectName = responseLecturer['lecturer'][0]['lecturerName'];
           
         });
      } else {
         throw Exception("Failed to get the data");
      }
  }


}