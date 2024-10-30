import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/model/user/user.dart';
import 'package:money_flow/services/profile_servises.dart';

import 'dart:io';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).loadProfile();

    return Scaffold(
        backgroundColor: const Color(0xFFA89A62),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 235, 206, 120),
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    User user = profileProvider.userDb;
                    Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 100, 98, 92),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                    );

                    return Column(
                      children: [
                        const SizedBox(height: 70),
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: user.imagePath != null &&
                                  user.imagePath!.isNotEmpty
                              ? FileImage(File(user.imagePath!))
                              : null,
                          child:
                              user.imagePath == null || user.imagePath!.isEmpty
                                  ? Icon(Icons.person, size: 50)
                                  : null,
                        ),
                        SizedBox(height: 100),
                        Card(
                          color: Color.fromARGB(255, 235, 206, 120),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  'Name: ${user.name ?? 'N/A'}',
                                  style:
                                      GoogleFonts.laBelleAurore(fontSize: 22),
                                ),
                                Text(
                                  'Age: ${user.age != null ? user.age.toString() : 'N/A'}',
                                  style:
                                      GoogleFonts.laBelleAurore(fontSize: 18),
                                ),
                                Text(
                                  'Phone: ${user.phone ?? 'N/A'}',
                                  style:
                                      GoogleFonts.laBelleAurore(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 235, 206, 120),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            profileProvider.editProfile(context);
                          },
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.laBelleAurore(fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
