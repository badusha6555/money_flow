import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/controllers/registartion_comntroller.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegistartionComntroller>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 354,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 206, 120),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -65,
                    right: 22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                      child: Container(
                        height: 370,
                        width: 350,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 53.0),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 40,
                            color: const Color.fromARGB(255, 235, 206, 120),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome to',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 29,
                          ),
                        ),
                        Text(
                          'Money Flow',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 235, 206, 120),
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign up',
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your username';
                              } else {
                                return null;
                              }
                            },
                            controller: registerProvider.usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<RegistartionComntroller>(
                            builder: (context, snapshot, child) => Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller:
                                      registerProvider.passwordController,
                                  obscureText:
                                      registerProvider.isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: const OutlineInputBorder(),
                                    suffix: IconButton(
                                      onPressed: () {
                                        registerProvider
                                            .togglePasswordVisibility();
                                      },
                                      icon: registerProvider.isPasswordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      registerProvider.errorMesssage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerProvider.signUp(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
