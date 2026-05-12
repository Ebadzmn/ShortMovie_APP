import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uremz100/Config/routes.dart';
import 'package:uremz100/Shared/Widgets/Custom_AppBar.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_images.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final isPasswordVisible = false.obs;
  final isAccountExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black100,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            // User Profile Info
            Row(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundImage: AssetImage(AppImages.profile_image),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Md Ibrahim Khalil",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      text: "UID: 637676603",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD4D4D4),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Personal Section
            _buildSectionHeader("Personal"),
            Obx(
              () => Column(
                children: [
                  _buildSettingItem(
                    "Account Info",
                    isExpandable: true,
                    isExpanded: isAccountExpanded.value,
                    onTap: () => isAccountExpanded.toggle(),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isAccountExpanded.value
                        ? Column(
                            children: [
                              _buildSettingItem(
                                "Change Profile Info",
                                onTap: () =>
                                    Get.toNamed(Routes.changeProfileInfo),
                              ),
                              _buildSettingItem(
                                "Change Password",
                                onTap: () => Get.toNamed(Routes.changePassword),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Else Section
            _buildSectionHeader("Else"),
            _buildSettingItem(
              "Privacy Policy",
              onTap: () => Get.toNamed(Routes.privacyPolicy),
            ),
            _buildSettingItem(
              "User Agreement",
              onTap: () => Get.toNamed(Routes.userAgreement),
            ),
            _buildSettingItem(
              "Delete Account",
              onTap: () => _showDeleteAccountModal(context),
            ),

            SizedBox(height: 174.h),

            // Logout Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: ElevatedButton(
                onPressed: () => _showLogoutModal(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: CustomText(
                  text: "Log Out",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: CustomText(
        text: title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFFB9B5B5),
      ),
    );
  }

  Widget _buildSettingItem(
    String title, {
    bool isExpandable = false,
    bool isExpanded = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        child: Row(
          children: [
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            const Spacer(),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isExpandable ? Icons.keyboard_arrow_down : Icons.chevron_right,
                color: const Color(0xFFB7B3B3),
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            CustomText(
              text: "Do you want to log out of your\nprofile?",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: Color(0xFFE6EDF7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: CustomText(
                      text: "Cancel",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Logout
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: CustomText(
                      text: "Log Out",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.all(20.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: "Want to delete account !",
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Please confirm your password to\nremove your account.",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              color: Color(0xFFE0E0E0),
            ),
            SizedBox(height: 18.h),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: "New password",
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => TextField(
                obscureText: isPasswordVisible.value,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Color(0xFFCDCDCD)),
                  filled: true,
                  fillColor: Colors.black,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isPasswordVisible.value = !isPasswordVisible.value;
                    },
                    child: Icon(
                      isPasswordVisible.value
                          ? Icons
                                .visibility // eye open  → text visible
                          : Icons.visibility_off, // eye off   → text hidden
                      color: const Color(0xFFCDCDCD),
                      size: 20.sp,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: Color(0xFFE6EDF7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: CustomText(
                      text: "Cancel",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Logout
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: CustomText(
                      text: "Log Out",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
