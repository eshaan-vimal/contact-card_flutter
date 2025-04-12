import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:contact_card/models/contact_data.dart';
import 'package:contact_card/features/contact_details/widgets/contact_detail_item.dart';


class ContactDetailPage extends StatelessWidget 
{
  final ContactData contactData;
  
  const ContactDetailPage({
    super.key,
    required this.contactData,
  });

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactData.data['name'] ?? 'Contact Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareContact(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactHeader(context),
            const SizedBox(height: 16),
            _buildContactInfo(context),
            const SizedBox(height: 24),
            _buildSaveContactButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContactHeader(BuildContext context) 
  {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                _getInitials(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              contactData.data['name'] ?? 'No Name',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            if (contactData.data['job'] != null && contactData.data['company'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${contactData.data['job']} at ${contactData.data['company']}',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              )
            else if (contactData.data['job'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  contactData.data['job']!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              )
            else if (contactData.data['company'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  contactData.data['company']!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) 
  {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...contactData.data.entries.map((entry) => 
              ContactDetailItem(entry: entry)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveContactButton(BuildContext context) 
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.person_add),
          label: const Text('Save to Contacts'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            // Implement save to contacts functionality
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contact saved')),
            );
          },
        ),
      ],
    );
  }

  String _getInitials() 
  {
    if (contactData.data['name'] == null) return '?';
    
    List<String> nameParts = contactData.data['name']!.split(' ');
    if (nameParts.length == 1) 
    {
      return nameParts[0][0].toUpperCase();
    }
    
    return nameParts[0][0].toUpperCase() + nameParts[nameParts.length - 1][0].toUpperCase();
  }

  void _shareContact(BuildContext context) 
  {
    String shareText = 'Contact Information:\n';
    
    contactData.data.forEach((key, value) {
      shareText += '${key.substring(0, 1).toUpperCase() + key.substring(1)}: $value\n';
    });
    
    Share.share(shareText);
  }
}