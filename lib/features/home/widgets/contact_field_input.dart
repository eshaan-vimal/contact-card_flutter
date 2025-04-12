import 'package:flutter/material.dart';

import 'package:contact_card/models/contact_field.dart';


class ContactFieldInput extends StatelessWidget 
{
  final ContactField field;
  final VoidCallback onToggleSelected;

  const ContactFieldInput({
    super.key,
    required this.field,
    required this.onToggleSelected,
  });

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: field.label,
                prefixIcon: Icon(field.icon),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              initialValue: field.value,
              onSaved: (value) {
                field.value = value ?? '';
              },
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: field.isSelected,
            onChanged: (_) => onToggleSelected(),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}