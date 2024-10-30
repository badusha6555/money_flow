import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

import 'package:money_flow/model/user/user.dart';
import 'package:money_flow/view/widgets/editprofile.dart';

class ProfileProvider with ChangeNotifier {
  User userDb;

  ProfileProvider(this.userDb);

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  String? imagePath;

  Future<void> loadProfile() async {
    var box = await Hive.openBox('profileBox');
    final savedUser = box.get('profile') as User?;

    if (savedUser != null) {
      userDb = savedUser;
      nameController.text = savedUser.name ?? '';
      ageController.text = savedUser.age ?? '';
      phoneController.text = savedUser.phone ?? '';
      imagePath = savedUser.imagePath;
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      notifyListeners();
    }
  }

  Future<void> saveProfile() async {
    final user = User(
      name: nameController.text,
      age: ageController.text,
      phone: phoneController.text,
      imagePath: imagePath,
    );

    var userProfile = await Hive.openBox('profileBox');
    await userProfile.put('profile', user);
    userDb = user;
    notifyListeners();
  }

  Future<void> editProfile(BuildContext context) async {
    final editedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOrAdd(),
      ),
    );

    if (editedUser != null) {
      final userProfile = await Hive.openBox<User>('profileBox');
      await userProfile.put('profile', userDb);
      notifyListeners();
    }
  }
}
