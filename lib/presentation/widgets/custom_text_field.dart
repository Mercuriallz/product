import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscureText;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.hintText,
    this.maxLines = 1,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue.shade600),
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        counterText: maxLength != null ? null : '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        filled: true,
        fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
