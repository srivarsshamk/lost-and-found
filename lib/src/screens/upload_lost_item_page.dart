import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class UploadLostItemPage extends StatefulWidget {
  const UploadLostItemPage({super.key});

  @override
  State<UploadLostItemPage> createState() => _UploadLostItemPageState();
}

class _UploadLostItemPageState extends State<UploadLostItemPage> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  String? _objectName;
  String? _placeFound;
  String? _hashtags;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Lost Item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: const Color.fromARGB(255, 243, 195, 252),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.purple,
                      backgroundImage: _pickedImage != null
                          ? (kIsWeb
                              ? NetworkImage(_pickedImage!.path)
                              : FileImage(_pickedImage!) as ImageProvider)
                          : null,
                      child: _pickedImage == null
                          ? const Icon(Icons.photo,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.purple, width: 2),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.edit, color: Colors.purple),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildTextField(
                  label: 'Object Name',
                  icon: Icons.work,
                  onSaved: (value) => _objectName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the object name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildTextField(
                  label: 'Place Found',
                  icon: Icons.place,
                  onSaved: (value) => _placeFound = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter where you found the item';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: buildTextField(
                      label: 'Date Found',
                      icon: Icons.calendar_today,
                      onSaved: (_) {},
                      validator: (value) {
                        if (_selectedDate == null) {
                          return 'Please select the date';
                        }
                        return null;
                      },
                      initialValue: _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : '',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: AbsorbPointer(
                    child: buildTextField(
                      label: 'Time Found',
                      icon: Icons.access_time,
                      onSaved: (_) {},
                      validator: (value) {
                        if (_selectedTime == null) {
                          return 'Please select the time';
                        }
                        return null;
                      },
                      initialValue: _selectedTime != null
                          ? _selectedTime!.format(context)
                          : '',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                buildTextField(
                  label: 'Relevant Hashtags',
                  icon: Icons.tag,
                  onSaved: (value) => _hashtags = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter relevant hashtags';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lost item uploaded successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Submit Item',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? initialValue,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // Set input box background to white
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.purple,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.purple,
            width: 2.5,
          ),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
