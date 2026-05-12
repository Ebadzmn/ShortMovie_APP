import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uremz100/Features/Home/Views/Rewards/Controller/rewards_controller.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_icons.dart';
import 'package:uremz100/Utils/app_images.dart';

class VipGames extends StatelessWidget {
  const VipGames({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardsController controller = Get.find<RewardsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Spacer for Header Text
        SizedBox(height: 30.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: "Quest ",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: "Gems,",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.yellow100,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: "Unlock ",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.yellow100,
                  ),
                  CustomText(
                    text: "Dramas",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF121316),
                      const Color(0xFFB27D4C).withOpacity(0.3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white12, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "My VIP Gems",
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.vip_games_icon,
                          width: 18.w,
                          height: 18.w,
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: "0",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Crack the Box Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6C4E32),
                      const Color(0xFF1A1B20).withOpacity(0.5),
                      const Color(0xFF1A1B20),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: "Crack the Box! Huge Gems Drop!",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      text: "Just Redeemed 1-Day VIP Pass",
                      fontSize: 12.sp,
                      color: Color(0xFFE0DADA),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 15.h),
                    Image.asset(
                      AppImages.crack_box_image,
                      height: 108.h,
                      width: 164.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 15.h),
                    CustomText(
                      text: "Daily Drop: 100% Chance to win, Max 3000Gems!",
                      fontSize: 12.sp,
                      color: Color(0xFFE0DADA),
                    ),
                    SizedBox(height: 15.h),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 74.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDFDAB), // Light yellow
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: "Standard_VIP to claim",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF272424),
                            ),
                            CustomText(
                              text: "\$4.00/ Month",
                              fontSize: 12.sp,
                              color: Color(0xFF272424),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // VIP Benefits & Redemption Tabs Container
              Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        const Color(0xFF6C4E32).withOpacity(0.2),
                        const Color(0xFF1A1B20),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.white12, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF764820).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          children: [
                            _buildTabItem(
                              "VIP Benefits",
                              isSelected: controller.vipTabIndex.value == 0,
                              onTap: () => controller.changeVipTab(0),
                              isFirst: true,
                            ),
                            _buildTabItem(
                              "Redemption",
                              isSelected: controller.vipTabIndex.value == 1,
                              onTap: () => controller.changeVipTab(1),
                              isFirst: false,
                            ),
                          ],
                        ),
                      ),

                      // Dynamic Grid content
                      _buildPassGrid(
                        isRedemption: controller.vipTabIndex.value == 1,
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
    required bool isFirst,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF513B28) : Colors.transparent,
            borderRadius: isFirst
                ? BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(4.r),
                    bottomRight: Radius.circular(4.r),
                  ),
          ),
          child: CustomText(
            text: text,
            fontSize: 16.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildPassGrid({required bool isRedemption}) {
    final RewardsController controller = Get.find<RewardsController>();
    // Different data for different tabs from controller
    final data = isRedemption
        ? controller.redemptionPasses
        : controller.vipBenefits;

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return _buildPassItem(title: data[index].title, gems: data[index].gems);
      },
    );
  }

  Widget _buildPassItem({required String title, required String gems}) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF6C4E32).withOpacity(0.4),
            const Color(0xFF1A1B20),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.vip_pass_icon, width: 80.w),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomText(
              text: title,
              fontSize: 10.sp,
              color: Color(0xFFD0D0D0),
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF764820),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppIcons.vip_games_icon,
                  width: 14.w,
                  height: 14.w,
                ),
                SizedBox(width: 6.w),
                CustomText(
                  text: gems,
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
