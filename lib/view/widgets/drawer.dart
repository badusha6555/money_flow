import 'package:flutter/material.dart';
import 'package:money_flow/services/pie_data_services.dart';
import 'package:money_flow/view/startscreen.dart';
import 'package:money_flow/view/widgets/terms.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final reset =
        Provider.of<PieDataServices>(context, listen: false).resetData();

    return Drawer(
      backgroundColor: Colors.white,
      width: 300,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomButton(
                  iconButton: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 235, 206, 120),
                              title: const Text('Confirm Reset'),
                              content: const Text(
                                'Are you sure you want Reset your Data?',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    reset;
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete, color: Colors.black)),
                  text: "Delete & Reset",
                ),
                CustomButton(
                  iconButton: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      icon: Icon(Icons.exit_to_app, color: Colors.black)),
                  text: "Terms and Conditions",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromARGB(255, 235, 206, 120),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                icon: Icon(Icons.exit_to_app, color: Colors.black),
                label: Text("Sign out", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Startscreen()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconButton iconButton;
  final String text;

  CustomButton({required this.iconButton, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconButton,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
