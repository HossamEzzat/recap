import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recap/features/auth/presention/views/register_view.dart';

import '../../../../core/shared/widgets/input_field.dart';
import '../../../products/presention/views/home_view.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 100),
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
                  "Welcome to ShopApp",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text("Sign in to your account", style: TextStyle(fontSize: 18)),
                SizedBox(height: 25),
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
                            context.read<AuthCubit>().login(
                              email: email.text,
                              password: password.text,
                            );
                          },
                    child: state is AuthLoading
                        ? CircularProgressIndicator()
                        : Text("Login"),
                  ),
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: Text("Don't have an account? Register"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
