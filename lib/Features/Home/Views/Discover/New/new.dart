import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uremz100/Config/routes.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import '../Models/discrive_models.dart';
import '../Controller/discover_controller.dart';
import '../Widget/discrive_widget.dart';

class NewView extends StatelessWidget {
  final DiscoverController controller;
  const NewView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Coming Soon"),
        SizedBox(height: 12.h),
        MovieGrid(items: controller.allMovies.take(3).toList(), count: 3),
        SizedBox(height: 24.h),
        SectionHeader(title: "New Release"),
        SizedBox(height: 12.h),
        // All 6 items in a 2-column grid (3 rows/lines) to match the picture
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6, // Showing 6 items (3 rows of 2 columns)
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio:
                0.55, // Adjusted to match the tall cards in the picture
          ),
          itemBuilder: (context, index) {
            final movie =
                controller.allMovies[index % controller.allMovies.length];
            // If it's the second card in a row (index 1, 3, 5) and in the last 2 rows (indices 2-5)
            bool isSecondInRow = index % 2 != 0;
            bool isLastTwoRows = index >= 2;

            return Padding(
              padding: EdgeInsets.only(
                top: (isSecondInRow && isLastTwoRows) ? 12.h : 0,
              ),
              child: _buildNewReleaseCard(movie),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNewReleaseCard(DiscoverMovie movie) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.shortsFullSeriesOverlay),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    movie.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // "New" Badge
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF76212),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: CustomText(
                      text: "New",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Play Icon and Views
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 14.sp),
                      SizedBox(width: 2.w),
                      CustomText(
                        text: "3.1M",
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: "Crinson Chars",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          CustomText(
            text: "Exclusive",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E8E8E),
          ),
        ],
      ),
    );
  }
}
