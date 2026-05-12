import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_icons.dart';
import '../Models/discrive_models.dart';

class TopPicksList extends StatelessWidget {
  final List<DiscoverMovie> movies;
  const TopPicksList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF994A24), // orange — top left
            Color(0xFF1B1616), // dark brown — middle
            Color(0xFF000000), // dark brown — middle
          ],
          stops: [0.0, 0.40, 2.0],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Top Picks",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF76212),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...movies.asMap().entries.map((entry) {
            int idx = entry.key;
            DiscoverMovie movie = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: Image.asset(
                            movie.image,
                            width: 30.w,
                            height: 35.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF76212),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.r),
                              bottomLeft: Radius.circular(4.r),
                            ),
                          ),
                          child: CustomText(
                            text: "${idx + 1}",
                            fontSize: 4.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: movie.title,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFFFFFF),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.fire_icon,
                                width: 10.w,
                                height: 10.w,
                              ),
                              SizedBox(width: 4.w),
                              CustomText(
                                text: "307k",
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFEC6A1A),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Explore More",
                fontSize: 10.sp,
                color: const Color(0xFFD9D9D9),
              ),
              SizedBox(width: 5.w),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFFD9D9D9),
                size: 10.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
