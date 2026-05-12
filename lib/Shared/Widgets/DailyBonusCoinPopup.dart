import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uremz100/Features/Home/Views/Discover/Controller/discover_controller.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_icons.dart';

class DailyBonusPopup extends StatelessWidget {
  final VoidCallback onClose;
  const DailyBonusPopup({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscoverController>();
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 25.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFB3651C).withOpacity(0.5),
                        const Color(0xFF000000).withOpacity(0.5),
                        const Color(0xFF000000),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [0.0, 0.4, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                      BoxShadow(
                        color: const Color(0xFFAE5F19).withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: "Claim Daily Bonus, Unlock\nNew Episodes.",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: controller.dailyBonus.length,
                        itemBuilder: (context, index) {
                          final bonus = controller.dailyBonus[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppIcons.rewards__rank_icon,
                                  height: 28.w,
                                  width: 28.w,
                                ),
                                SizedBox(height: 8.h),
                                CustomText(
                                  text: "+${bonus.coins}",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 12.h),
                                CustomText(
                                  text: bonus.time,
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          // controller.closePopup();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 9.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF76212),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "Check-In",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 45.w,
                top: 65.h,
                child: GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
