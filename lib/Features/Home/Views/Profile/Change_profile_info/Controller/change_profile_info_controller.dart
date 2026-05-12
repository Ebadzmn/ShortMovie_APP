import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChangeProfileInfoController extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  final selectedGender = "Male".obs;
  final genderList = ["Male", "Female", "Other"];

  final selectedDate = "DD.MM.YY".obs;

  void updateGender(String? value) {
    if (value != null) {
      selectedGender.value = value;
    }
  }

  Future<void> chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFF76212),
              onPrimary: Colors.white,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFF76212),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('dd.MM.yyyy').format(pickedDate);
    }
  }
}
