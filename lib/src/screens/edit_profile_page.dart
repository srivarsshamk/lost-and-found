import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'dart:io'; // To handle File objects
import 'package:flutter/foundation.dart'; // For kIsWeb

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _mobileNumber;
  String? _idNumber;
  String? _role;
  File? _profileImage; // File to hold the profile image
  final ImagePicker _picker = ImagePicker(); // To pick images

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.purple,
      ),
      backgroundColor:
          const Color.fromARGB(255, 243, 195, 252), // Set the background color
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
                      backgroundImage: _profileImage != null
                          ? (kIsWeb
                              ? NetworkImage(_profileImage!
                                  .path) // Use NetworkImage on web
                              : FileImage(_profileImage!)
                                  as ImageProvider) // Use FileImage on mobile
                          : null, // Use null if no image is selected
                      child: _profileImage == null
                          ? const Icon(Icons.person,
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
                          child: const Icon(
                            Icons.edit,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Name TextField
                buildTextField(
                  label: 'Name',
                  icon: Icons.person,
                  onSaved: (value) => _name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Email TextField
                buildTextField(
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Mobile Number TextField
                buildTextField(
                  label: 'Mobile Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _mobileNumber = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // ID Number TextField
                buildTextField(
                  label: 'ID Number',
                  icon: Icons.badge,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _idNumber = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Role TextField
                buildTextField(
                  label: 'Role',
                  icon: Icons.account_circle,
                  onSaved: (value) => _role = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your role (e.g., Student, Teacher)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                // Save Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Purple button
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Handle profile update logic here
                      print(
                          'Name: $_name, Email: $_email, Mobile: $_mobileNumber, ID: $_idNumber, Role: $_role');

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set the text color to white
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

  // Helper function to build a TextFormField with a consistent design
  Widget buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Input text color
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.purple), // Label text color
        hintStyle: const TextStyle(color: Colors.purple), // Hint text color
        prefixIcon: Icon(icon, color: Colors.purple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.purple, // Border color
            width: 2.0, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.purple, // Focused border color
            width: 2.5, // Focused border width
          ),
        ),
        filled: true, // Ensures the background is filled
        fillColor: const Color.fromARGB(
            255, 249, 248, 249), // Background color inside text field
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
