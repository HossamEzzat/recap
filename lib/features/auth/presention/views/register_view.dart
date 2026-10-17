import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recap/features/products/presention/views/home_view.dart';

import '../../../../core/shared/widgets/input_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "fill in your details to create your account",
                    style: TextStyle(fontSize: 16),
                  ),
                  InputField(
                    email: email,
                    icon: Icon(Icons.email),
                    label: "Email",
                  ),
                  SizedBox(height: 15),
                  InputField(
                    email: password,
                    icon: Icon(Icons.lock),
                    label: "Password",
                  ),
                  SizedBox(height: 15),
                  InputField(
                    email: firstName,
                    icon: Icon(Icons.person),
                    label: "First Name",
                  ),
                  SizedBox(height: 15),
                  InputField(
                    email: lastName,
                    icon: Icon(Icons.person),
                    label: "Last Name",
                  ),
                  SizedBox(height: 15),
                  InputField(
                    email: address,
                    icon: Icon(Icons.home),
                    label: "Address",
                  ),
                  SizedBox(height: 15),
                  InputField(
                    email: phone,
                    icon: Icon(Icons.phone),
                    label: "Phone",
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              context.read<AuthCubit>().register(
                                email: email.text,
                                password: password.text,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                address: address.text,
                                phone: phone.text,
                              );
                            },
                      child: state is AuthLoading
                          ? CircularProgressIndicator()
                          : Text("Sign Up"),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Already have an account? Login"),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
