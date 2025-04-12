import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'package:contact_card/models/contact_data.dart';


class QRDisplayPage extends StatelessWidget 
{
  final Map<String, String> qrData;
  
  const QRDisplayPage({
    super.key,
    required this.qrData,
  });

  @override
  Widget build(BuildContext context) 
  {
    final contactData = ContactData(data: qrData);
    final String jsonData = contactData.toJson();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareQRCode(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQRCard(context, jsonData),
              const SizedBox(height: 24),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRCard(BuildContext context, String jsonData) 
  {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Scan to connect',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: QrImageView(
                data: jsonData,
                version: QrVersions.auto,
                size: 280,
                backgroundColor: Colors.white,
                errorStateBuilder: (context, error) {
                  return Center(
                    child: Text(
                      'Error generating QR code',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your contact information is embedded in this QR code',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) 
  {
    return ElevatedButton.icon(
      icon: const Icon(Icons.content_copy),
      label: const Text('Save to Gallery'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        // Implement save to gallery functionality
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR Code saved to gallery')),
        );
      },
    );
  }

  void _shareQRCode() 
  {
    Share.share('Connect with me using my QR Contact Card!');
  }
}