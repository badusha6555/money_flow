import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Terms and Conditions',
          style: TextStyle(
              color: Color.fromARGB(255, 235, 206, 120),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''1. Introduction
      Welcome to Money Flow. 
      By using our app, you agree to comply with these terms and conditions. If you do not agree, please refrain from using our services.
      2. Eligibility
      Users must be at least [insert age] years old. By using the app, you confirm that you meet this age requirement.
      3. Account Creation
      Users must create an account to access certain features. You agree to provide accurate, current, and complete information during the registration process and to update such information as needed.
      4. User Responsibilities
      You are responsible for maintaining the confidentiality of your account credentials.
      You agree to notify us immediately of any unauthorized use of your account or any other breach of security.
      5. Services Offered
      [Briefly describe the services your app provides, e.g., budgeting tools, expense tracking, financial insights.]
      6. User Data and Privacy
      We collect and process personal data in accordance with our Privacy Policy. By using the app, you consent to the collection and use of your information as outlined.
      7. Fees and Payments
      Certain features may require payment. You agree to pay all applicable fees and taxes associated with your use of the app.
      8. Intellectual Property
      All content, features, and functionality of the app are owned by [Your Company Name] and are protected by copyright, trademark, and other intellectual property laws.
      9. Limitation of Liability
      To the fullest extent permitted by law, [Your Company Name] is not liable for any indirect, incidental, special, or consequential damages arising out of or related to your use of the app.
      10. Termination
      We reserve the right to suspend or terminate your account if you violate these terms or engage in harmful conduct.
      11. Governing Law
      These terms shall be governed by and construed in accordance with the laws of [Your State/Country].
      12. Changes to Terms
      We may update these terms from time to time. We will notify you of any changes by posting the new terms on the app. Your continued use of the app constitutes acceptance of the new terms.
      13. Contact Information
      For any questions or concerns regarding these terms, please contact us at [contact information].''',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
