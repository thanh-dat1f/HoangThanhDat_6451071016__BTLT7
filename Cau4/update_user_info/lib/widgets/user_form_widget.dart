import 'package:flutter/material.dart';

class UserFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController websiteCtrl;
  final bool isLoading;
  final VoidCallback onSave;

  const UserFormWidget({
    super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.websiteCtrl,
    required this.isLoading,
    required this.onSave,
  });

  Widget _buildField(
    String label,
    TextEditingController ctrl,
    IconData icon, {
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildField('Họ tên', nameCtrl, Icons.person,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Không được để trống' : null),
          _buildField('Email', emailCtrl, Icons.email,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Không được để trống' : null),
          _buildField('Điện thoại', phoneCtrl, Icons.phone),
          _buildField('Website', websiteCtrl, Icons.web),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : onSave,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(isLoading ? 'Đang lưu...' : 'Lưu thay đổi'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}