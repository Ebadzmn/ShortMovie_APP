import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_icons.dart';

class RewardStepWidget extends StatelessWidget {
  final String coins;
  final String time;
  final bool isCompleted;

  const RewardStepWidget({
    super.key,
    required this.coins,
    required this.time,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF131416).withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.rewards__rank_icon,
                height: 24.w,
                width: 24.w,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: coins,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        CustomText(
          text: time,
          fontSize: 12.sp,
          color: AppColors.white100,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
