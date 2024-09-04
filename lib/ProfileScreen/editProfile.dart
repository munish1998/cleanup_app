import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/profileProivder.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';

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
              _buildTextField(
                controller: profileProvider.nameController,
                label: 'Name',
                icon: Icons.person,
                validator: (value) => profileProvider.validateName(value),
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: profileProvider.emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => profileProvider.validateEmail(value),
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: profileProvider.phoneController,
                label: 'Mobile',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => profileProvider.validateMobile(value),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12), // Limit to 12 digits
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                ],
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: profileProvider.passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
                validator: (value) => profileProvider.validatePassword(value),
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: profileProvider.cpasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (value) => profileProvider.validateConfirmPassword(
                    value, profileProvider.passwordController.text),
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: profileProvider.locationController,
                label: 'Location',
                icon: Icons.location_on,
                validator: (value) => profileProvider.validateLocation(value),
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: profileProvider.dobController,
                label: 'Date of Birth',
                icon: Icons.calendar_today,
                hintText: 'YYYY-MM-DD',
                keyboardType: TextInputType.none, // Disable keyboard input
                validator: (value) =>
                    profileProvider.validateDateOfBirth(value),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    profileProvider.dobController.text =
                        pickedDate.toIso8601String().split('T')[0];
                  }
                },
              ),
              SizedBox(height: 20),
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
                        Navigator.pop(context);
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
                  child: const Row(
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
    Function()? onTap,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: Card(
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatters,
          ),
        ),
      ),
    );
  }
}
