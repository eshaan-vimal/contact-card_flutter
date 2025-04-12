import 'package:flutter/material.dart';

import 'package:contact_card/models/contact_field.dart';
import 'package:contact_card/features/qr/pages/qr_display_page.dart';
import 'package:contact_card/features/scanner/pages/qr_scan_page.dart';
import 'package:contact_card/features/home/widgets/contact_field_input.dart';


class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  final List<ContactField> contactFields = [
    ContactField(label: 'Name', key: 'name', icon: Icons.person),
    ContactField(label: 'Email', key: 'email', icon: Icons.email),
    ContactField(label: 'Phone', key: 'phone', icon: Icons.phone),
    ContactField(label: 'LinkedIn', key: 'linkedin', icon: Icons.link),
    ContactField(label: 'Instagram', key: 'instagram', icon: Icons.camera_alt),
    ContactField(label: 'GitHub', key: 'github', icon: Icons.code),
    ContactField(label: 'Website', key: 'website', icon: Icons.language),
    ContactField(label: 'Company', key: 'company', icon: Icons.business),
    ContactField(label: 'Job Title', key: 'job', icon: Icons.work),
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Contact Card'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Generate QR',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _generateQRCode();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'Scan QR',
            onPressed: () => _scanQRCode(),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            ...contactFields.map((field) => ContactFieldInput(
              field: field,
              onToggleSelected: () => setState(() {
                field.isSelected = !field.isSelected;
              }),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() 
  {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Your Digital Contact Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Fill in your details and select which information to include in your QR code.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _generateQRCode() 
  {
    Map<String, String> qrData = {};
    
    for (var field in contactFields) 
    {
      if (field.isSelected && field.value.isNotEmpty) 
      {
        qrData[field.key] = field.value;
      }
    }
    
    if (qrData.isEmpty) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill and select at least one field')),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRDisplayPage(qrData: qrData),
      ),
    );
  }

  void _scanQRCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScanPage(),
      ),
    );
  }
}