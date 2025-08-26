import 'package:flutter/material.dart';

class ProfileTextFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController locationController;
  final TextEditingController campusController;
  final String? Function(String?)? nameValidator;
  final String? Function(String?)? locationValidator;
  final List<String>? campusOptions;
  final bool showCampusAsDropdown;

  const ProfileTextFields({
    super.key,
    required this.nameController,
    required this.locationController,
    required this.campusController,
    this.nameValidator,
    this.locationValidator,
    this.campusOptions,
    this.showCampusAsDropdown = false,
  });

  Widget _buildRequiredTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF00487B),
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF5A8298), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildCampusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Campus',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF00487B),
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: campusController.text.isEmpty ? null : campusController.text,
          decoration: InputDecoration(
            hintText: 'Select your campus',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF5A8298), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: campusOptions?.map((String campus) {
            return DropdownMenuItem<String>(
              value: campus,
              child: Text(campus),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              campusController.text = newValue;
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a campus';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRequiredTextField(
          label: 'Name',
          controller: nameController,
          validator: nameValidator,
        ),
        const SizedBox(height: 16),
        _buildRequiredTextField(
          label: 'Location',
          controller: locationController,
          validator: locationValidator,
        ),
        const SizedBox(height: 16),
        
        // Campus field - dropdown or text field
        if (showCampusAsDropdown && campusOptions != null)
          _buildCampusDropdown()
        else
          _buildRequiredTextField(
            label: 'Campus',
            controller: campusController,
          ),
      ],
    );
  }
}