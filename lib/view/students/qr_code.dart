import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wemeet_dapps/about.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/api_services/api_notify_services.dart';
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

  @override
  void initState() {
    super.initState();
    getMatricNo();
  }
  getMatricNo() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var matricNo = _sharedPreferences.getString('matricNo');
    getMessage(matricNo);
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
    await launch(url); 
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
        ? 200.0
        : 300.0;
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

    //to get notification message from lecturer
   getMessage(String? matricNo) async {
     final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
     String? staffNo = _sharedPreferences.getString("staffNumber");
     var responseChat = await new Chat().getUserMessage(matricNo!, staffNo!);
     if(responseChat['success']){
       final responseData = responseChat['chat'];
       if(responseData is List) {
         setState(() {
        bool lastMessageSentByLecturer = responseData.isNotEmpty && responseData.last['statusMessage'] == 2;
        if (lastMessageSentByLecturer && _sharedPreferences.getString("lecturerName") != "" && _sharedPreferences.getString("staffNumber") != "") {
             var lecturerName = _sharedPreferences.getString("lecturerName");
              NotificationService().showNotification(
              title: 'New message from Dr $lecturerName',
              body: responseData.last['messageText']).then((value) => {
                 _sharedPreferences.remove("lecturerName"),
                 _sharedPreferences.remove("staffNumber")
              });
           }
         });
       }else {
         print("Error fetching data: ${responseChat['message']}");
       }
     }
  }

}