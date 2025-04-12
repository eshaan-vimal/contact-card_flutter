import 'package:flutter/material.dart';


class ContactField 
{
  final String label;
  final String key;
  final IconData icon;
  String value;
  bool isSelected;

  ContactField({
    required this.label,
    required this.key,
    required this.icon,
    this.value = '',
    this.isSelected = true,
  });
}