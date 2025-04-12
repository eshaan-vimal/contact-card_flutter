import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';

import 'package:contact_card/features/contact_details/pages/contact_detail_page.dart';
import 'package:contact_card/models/contact_data.dart';


class QRScanPage extends StatefulWidget 
{
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> 
{
  MobileScannerController controller = MobileScannerController();
  bool isScanning = true;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller.torchState,
              builder: (context, state, child) {
                return Icon(
                  state == TorchState.on ? Icons.flash_on : Icons.flash_off,
                );
              },
            ),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller.cameraFacingState,
              builder: (context, state, child) {
                return Icon(
                  state == CameraFacing.front ? Icons.camera_front : Icons.camera_rear,
                );
              },
            ),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (isScanning && barcode.rawValue != null) {
                    setState(() {
                      isScanning = false;
                    });
                    
                    try {
                      final Map<String, dynamic> jsonData = jsonDecode(barcode.rawValue!);
                      ContactData contactData = ContactData.fromJson(jsonData);
                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailPage(contactData: contactData),
                        ),
                      );
                    } catch (e) {
                      setState(() {
                        isScanning = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid QR Code')),
                      );
                    }
                  }
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Position the QR code in the frame',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}