import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactDetailItem extends StatelessWidget 
{
  final MapEntry<String, String> entry;
  
  const ContactDetailItem({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) 
  {
    IconData icon;
    String label;
    String value = entry.value;
    bool isUrl = false;
    String? urlPrefix;
    
    switch (entry.key) 
    {
      case 'name':
        icon = Icons.person;
        label = 'Name';
        break;
      case 'email':
        icon = Icons.email;
        label = 'Email';
        isUrl = true;
        urlPrefix = 'mailto:';
        break;
      case 'phone':
        icon = Icons.phone;
        label = 'Phone';
        isUrl = true;
        urlPrefix = 'tel:';
        break;
      case 'linkedin':
        icon = Icons.link;
        label = 'LinkedIn';
        isUrl = true;
        if (!value.startsWith('http')) 
        {
          value = 'https://linkedin.com/in/$value';
        }
        break;
      case 'instagram':
        icon = Icons.camera_alt;
        label = 'Instagram';
        isUrl = true;
        if (!value.startsWith('http')) 
        {
          value = 'https://instagram.com/$value';
        }
        break;
      case 'github':
        icon = Icons.code;
        label = 'GitHub';
        isUrl = true;
        if (!value.startsWith('http')) 
        {
          value = 'https://github.com/$value';
        }
        break;
      case 'website':
        icon = Icons.language;
        label = 'Website';
        isUrl = true;
        if (!value.startsWith('http')) 
        {
          value = 'https://$value';
        }
        break;
      case 'company':
        icon = Icons.business;
        label = 'Company';
        break;
      case 'job':
        icon = Icons.work;
        label = 'Job Title';
        break;
      default:
        icon = Icons.info;
        label = entry.key.substring(0, 1).toUpperCase() + entry.key.substring(1);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: isUrl ? () => _launchUrl(urlPrefix != null ? '$urlPrefix$value' : value) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              if (isUrl)
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async 
  {
    if (await canLaunch(url)) 
    {
      await launch(url);
    }
  }
}