import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_images.dart';
import 'Modet/more_model.dart';
import 'Widget/more_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample Data for Cast
    final List<CastModel> castList = [
      CastModel(
        name: "Jesse Morales",
        seriesCount: "27",
        imageUrl: AppImages.profile_image,
      ),
      CastModel(
        name: "Anna DeRusso",
        seriesCount: "2",
        imageUrl: AppImages.profile_image,
      ),
      CastModel(
        name: "Robert Watkins",
        seriesCount: "1",
        imageUrl: AppImages.profile_image,
      ),
      CastModel(
        name: "Danielle Vivcharenko",
        seriesCount: "1",
        imageUrl: AppImages.profile_image,
      ),
      CastModel(
        name: "Sully Christian",
        seriesCount: "4",
        imageUrl: AppImages.profile_image,
      ),
      CastModel(
        name: "Payton Thomas",
        seriesCount: "1",
        imageUrl: AppImages.profile_image,
      ),
    ];

    // Sample Data for Related Content
    final List<RelatedContentModel> relatedList = [
      RelatedContentModel(
        title: "Ms. CEO's Baby Daddy Is the...",
        category: "Flash Marriage",
        views: "300.4M",
        imageUrl: AppImages.move_1,
      ),
      RelatedContentModel(
        title: "Breathe",
        category: "First Love",
        views: "48.9M",
        imageUrl: AppImages.move_2,
      ),
      RelatedContentModel(
        title: "My Sister Is the Warlord Queen",
        category: "Hidden Identity",
        views: "531.8M",
        imageUrl: AppImages.move_3,
      ),
      RelatedContentModel(
        title: "Scandalous",
        category: "Enemies to Lovers",
        views: "27.5M",
        imageUrl: AppImages.move_4,
        isNew: true,
      ),
      RelatedContentModel(
        title: "The Cooking Queen: A Reci...",
        category: "Contract Lovers",
        views: "29.3M",
        imageUrl: AppImages.move_5,
      ),
      RelatedContentModel(
        title: "Pucked in the Friend Zone",
        category: "Fake Relationship",
        views: "14.4M",
        imageUrl: AppImages.move_6,
        isNew: true,
      ),
      RelatedContentModel(
        title: "In the Palm of His Hand",
        category: "Love-Hate",
        views: "110.7M",
        imageUrl: AppImages.move_7,
      ),
      RelatedContentModel(
        title: "In Love with a Single Farm...",
        category: "Flash Marriage",
        views: "224.2M",
        imageUrl: AppImages.move_2,
      ),
      RelatedContentModel(
        title: "Bound by Honor",
        category: "First Love",
        views: "366.3M",
        imageUrl: AppImages.move_3,
      ),
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Stack(
        children: [
          // Background Top Gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xFF630E0E).withOpacity(0.8),
                    const Color(0xFF121212).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              // Drag Handle
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Title and Basic Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            AppImages.move_1,
                            width: 72.w,
                            height: 96.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text:
                                    "After Divorce, I'm Spoiled by Three Brothers",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              SizedBox(height: 4.h),
                              CustomText(
                                text: "319.6K Views",
                                fontSize: 12.sp,
                                color: const Color(0xFF8E8E8E),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Synopsis Section
                    MoreScreenWidgets.buildSectionTitle("Synopsis"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          MoreScreenWidgets.buildTag("Drama"),
                          SizedBox(width: 12.w),
                          MoreScreenWidgets.buildTag("Strong Heroine"),
                          SizedBox(width: 12.w),
                          MoreScreenWidgets.buildTag("Contract Lovers"),
                          SizedBox(width: 12.w),
                          MoreScreenWidgets.buildTag("Identity"),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFB3B3B3),
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "Catherine Rowen spent three years as a contract wife, treated like a servant and discarded the moment her divorce papers were signed. ... ",
                          ),
                          TextSpan(
                            text: "More",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Add to My List Button
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF292929),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.white24, width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.bookmark_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8.w),
                          CustomText(
                            text: "Add to My List",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Episodes Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MoreScreenWidgets.buildSectionTitle("Episodes"),
                        Row(
                          children: [
                            CustomText(
                              text: "38 Episodes in total",
                              fontSize: 13.sp,
                              color: const Color(0xFF8E8E8E),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.sp,
                              color: const Color(0xFF8E8E8E),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Episode Range Selection
                    Row(
                      children: [
                        CustomText(
                          text: "1-30",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(width: 24.w),
                        CustomText(
                          text: "31-38",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8E8E8E),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Horizontal Episode List
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          // Trailer Item
                          Container(
                            width: 68.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF222222),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            alignment: Alignment.center,
                            child: CustomText(
                              text: "Trailer",
                              fontSize: 13.sp,
                              color: const Color(0xFF8E8E8E),
                            ),
                          ),
                          SizedBox(width: 10.w),

                          // Episode 1 (Active with Animation Bars)
                          Container(
                            width: 52.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF4A4A4A),
                                  const Color(0xFF630E0E).withOpacity(0.5),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomText(
                                  text: "1",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                Positioned(
                                  bottom: 6.h,
                                  right: 6.w,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 2.w,
                                        height: 4.h,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 0.5.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            1.r,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 2.w,
                                        height: 8.h,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 0.5.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            1.r,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 2.w,
                                        height: 6.h,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 0.5.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            1.r,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),

                          // Other Episodes (2, 3, 4, 5, etc.)
                          ...List.generate(
                            10,
                            (index) => Container(
                              margin: EdgeInsets.only(right: 10.w),
                              width: 52.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF222222),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              alignment: Alignment.center,
                              child: CustomText(
                                text: "${index + 2}",
                                fontSize: 14.sp,
                                color: const Color(0xFF8E8E8E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // More Like This Section
                    MoreScreenWidgets.buildSectionTitle("More Like This"),
                  ]),
                ),
              ),

              // Related Content Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 24.h,
                    childAspectRatio: 0.48,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final related = relatedList[index];
                    return MoreScreenWidgets.buildRelatedItem(
                      related.title,
                      related.category,
                      related.views,
                      related.imageUrl,
                      related.isNew,
                    );
                  }, childCount: relatedList.length),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            ],
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: CircleAvatar(
              radius: 14.r,
              backgroundColor: const Color(0xFF292929),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.close, color: Colors.white, size: 18.sp),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
