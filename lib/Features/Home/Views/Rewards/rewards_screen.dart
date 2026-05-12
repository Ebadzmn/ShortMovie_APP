import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_icons.dart';
import 'package:uremz100/Utils/app_images.dart';
import 'Controller/rewards_controller.dart';
import 'Vip_games/vip_games.dart';
import 'Widget/reward_step_widget.dart';
import 'Widget/task_item_widget.dart';

class RewardsScreen extends StatelessWidget {
  RewardsScreen({super.key});

  final RewardsController controller = Get.put(RewardsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black, // match bottom nav background
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // 1. Background Image (Shown for both tabs)
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    AppImages.rewards_image,
                    height: 365.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // 2. Main Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ), // Safe area top padding approximation
                    _buildHeader(context),
                    Obx(() {
                      return controller.isRewardsTab.value
                          ? _buildRewardsContent()
                          : const VipGames();
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 75.w, vertical: 10.h),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          height: 30.h, // Further reduced height
          child: TabBar(
            onTap: (index) {
              controller.toggleTab(index == 0);
            },
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.h, color: AppColors.orange100),
              insets: EdgeInsets.only(
                left: 22.w,
                bottom: 2.h, // Pushes the indicator up towards the text
              ), // Icon (18w) + Gap (4w) = 22w
            ),
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF8E8E8E),
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            tabs: [
              Tab(
                height: 30.h, // Reduced tab height
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.short_reword_icon,
                      width: 18.w,
                      height: 18.w,
                    ),
                    SizedBox(width: 4.w),
                    const Text("Rewards"),
                  ],
                ),
              ),
              Tab(
                height: 30.h, // Reduced tab height
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.vip_games_icon,
                      width: 18.w,
                      height: 18.w,
                    ),
                    SizedBox(width: 4.w),
                    const Text("VIP Gems"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardsContent() {
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
                    text: "Coins,",
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
                      text: "Balance",
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.rewards__rank_icon,
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

              // Rewards Progress Card
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
                      text: "Watch Dramas And Quest Coins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      text: "Watch 3 more mins +10 Coins",
                      fontSize: 12.sp,
                      color: const Color(0xFFEDADA1),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 15.h),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.rewardsSteps.map((step) {
                          return RewardStepWidget(
                            coins: step.coins,
                            time: step.time,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF76212),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {},
                        child: CustomText(
                          text: "Quest Coins",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Today's Benefits Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFE36D00).withOpacity(0.2),
                      const Color(0xFF1A1B20).withOpacity(0.2),
                      const Color(0xFF1A1B20),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.0, 0.4, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(color: Colors.white10, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Today's Benefits",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    SizedBox(height: 14.h),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.todayBenefits.length,
                        itemBuilder: (context, index) {
                          final item = controller.todayBenefits[index];
                          return TaskItemWidget(
                            title: item.title,
                            titleSuffix: item.titleSuffix,
                            subtitle: item.subtitle,
                            coinsLabel: item.coinsLabel,
                            buttonText: item.buttonText,
                            isHighlight: item.isHighlight,
                            layoutType: item.layoutType,
                            steps: item.steps,
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Description Section
              CustomText(
                text: "Description",
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              SizedBox(height: 12.h),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.descriptions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "${index + 1}. ",
                            fontSize: 12.sp,
                            color: const Color(0xFFCFCDCD),
                            fontWeight: FontWeight.w400,
                          ),
                          Expanded(
                            child: CustomText(
                              text: controller.descriptions[index].replaceFirst(
                                RegExp(r'^\d+\.\s*'),
                                '',
                              ),
                              fontSize: 12.sp,
                              color: const Color(0xFFCFCDCD),
                              fontWeight: FontWeight.w400,
                              maxLines: 5,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ],
    );
  }
}
