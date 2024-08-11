import 'package:cleanup_mobile/Providers/profileProivder.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: AppColor.rank1Color,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextFormField Widgets with Cards
              Column(
                children: [
                  _buildTextField(
                    controller: profileProvider.nameController,
                    label: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: profileProvider.emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: profileProvider.phoneController,
                    label: 'Mobile',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: profileProvider.passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: false,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: profileProvider.cpasswordController,
                    label: 'Confirm Password',
                    icon: Icons.lock_outline,
                    obscureText: false,
                    validator: (value) {
                      if (value?.isEmpty ?? true)
                        return 'Please confirm your password';
                      if (value != profileProvider.passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: profileProvider.locationController,
                    label: 'Location',
                    icon: Icons.location_on,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: profileProvider.dobController,
                    label: 'Date of Birth',
                    icon: Icons.calendar_today,
                    hintText: 'YYYY-MM-DD',
                    keyboardType: TextInputType.datetime,
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Save Changes Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final success = await profileProvider.editProfile(
                        context: context,
                        data: {
                          'name': profileProvider.nameController.text,
                          'email': profileProvider.emailController.text,
                          'mobile': profileProvider.phoneController.text,
                          'password': profileProvider.passwordController.text,
                          'password_confirmation':
                              profileProvider.cpasswordController.text,
                          'location': profileProvider.locationController.text,
                          'dob': profileProvider.dobController.text,
                        },
                      );

                      if (success) {
                        Navigator.pop(
                            context); // Go back to the previous screen if update is successful
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update profile')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.rank1Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(350, 52),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return Card(
      color: AppColor.backgroundcontainerColor,
      elevation: 0.3,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColor.rank1Color,
          ),
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
