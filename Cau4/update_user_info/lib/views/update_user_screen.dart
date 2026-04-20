import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../widgets/user_form_widget.dart';

class UpdateUserScreen extends StatefulWidget {
  final int userId;
  const UpdateUserScreen({super.key, required this.userId});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = UserController();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();

  bool _isLoading = false;
  bool _isFetching = true;
  User? _user;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _controller.loadUser(widget.userId);
      setState(() {
        _user = user;
        _nameCtrl.text = user.name;
        _emailCtrl.text = user.email;
        _phoneCtrl.text = user.phone;
        _websiteCtrl.text = user.website;
        _isFetching = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isFetching = false;
      });
    }
  }

  Future<void> _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final updated = User(
        id: _user!.id,
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        phone: _phoneCtrl.text,
        website: _websiteCtrl.text,
      );
      await _controller.updateUser(_user!.id, updated);
      setState(() => _user = updated);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật thành công!'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _websiteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập Nhật Hồ Sơ'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: _isFetching
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: UserFormWidget(
                    formKey: _formKey,
                    nameCtrl: _nameCtrl,
                    emailCtrl: _emailCtrl,
                    phoneCtrl: _phoneCtrl,
                    websiteCtrl: _websiteCtrl,
                    isLoading: _isLoading,
                    onSave: _handleUpdate,
                  ),
                ),
    );
  }
}