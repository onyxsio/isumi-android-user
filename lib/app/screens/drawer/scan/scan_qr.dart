import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Customer customer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> getUserData(String id) async {
    // setState(() => isLoading = true);
    customer = await FireRepo.getCustomer();
    return customer.order!.contains(id);
    // setState(() => isLoading = false);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        controller.pauseCamera();
      });
      // if (result != null) showMessage();
      if (result != null) {
        // var data = await getUserData(result!.code!);
        if (await getUserData(result!.code!)) showMessage();
      }
    });
  }

  void showMessage() {
    if (result != null) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 30.h,
            margin: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: AppColor.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset(AppIcon.done),
                  SizedBox(height: 5.w),
                  Text('Scan Success', style: TxtStyle.h11B),
                  Text(
                    'Your QR Code is successfully  scanned!',
                    textAlign: TextAlign.center,
                    style: TxtStyle.l5,
                  ),
                ],
              ),
            ),
          );
        },
      );
      Timer(const Duration(seconds: 3), () {
        Navigator.pop(context);
        Provider.of<ScanPageProvider>(context, listen: false)
            .qrCodeData(result!.code.toString());
        Provider.of<ScanPageProvider>(context, listen: false).jumpTo(1);
      });
    }
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Share your experience with others',
                textAlign: TextAlign.center,
                style: TxtStyle.l7,
              ),
              SizedBox(height: 10.w),
              ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                          borderColor: AppColor.yellow,
                          borderRadius: 10,
                          borderLength: 20,
                          borderWidth: 5,
                          cutOutSize: 150),
                      onPermissionSet: (ctrl, p) =>
                          _onPermissionSet(context, ctrl, p),
                    ),
                  )),
              SizedBox(height: 10.w),
              Text(
                'Please scan the QR Code for the review of the product.',
                textAlign: TextAlign.center,
                style: TxtStyle.l5,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(
          onTap: () async {
            await controller?.resumeCamera();
          },
          text: 'Scan now'),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
