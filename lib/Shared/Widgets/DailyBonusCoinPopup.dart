import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uremz100/Features/Home/Views/Discover/Controller/discover_controller.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_icons.dart';
import 'package:uremz100/Features/Home/Views/Discover/Models/discrive_models.dart';

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
                      Column(
                        children: [
                          Row(
                            children: List.generate(4, (index) {
                              final bonus = controller.dailyBonus[index];
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: index < 3 ? 10.w : 0),
                                  child: _buildBonusCard(bonus, false),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: _buildBonusCard(controller.dailyBonus[4], false),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: _buildBonusCard(controller.dailyBonus[5], false),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: _buildBonusCard(controller.dailyBonus[6], true),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Obx(() => GestureDetector(
                        onTap: controller.canCheckIn.value 
                            ? () { controller.claimCheckIn(); } 
                            : null,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 9.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: controller.canCheckIn.value 
                                ? const Color(0xFFF76212) 
                                : Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: CustomText(
                              text: controller.canCheckIn.value 
                                  ? "Check-In" 
                                  : "Available in ${controller.checkInRemainingTime.value}",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
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

  Widget _buildBonusCard(BonusItem bonus, bool isWide) {
    return Container(
      height: 100.h,
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
            height: isWide ? 32.w : 28.w,
            width: isWide ? 32.w : 28.w,
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
  }
}
