import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Features/Home/Views/Discover/Controller/movie_details_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uremz100/Utils/app_icons.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String contentId = Get.arguments as String;
    // Instantiate or find the controller specifically for this contentId
    final controller = Get.put(MovieDetailsController(contentId: contentId), tag: contentId);

    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFF76212),
            ),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.redAccent, size: 48.sp),
                SizedBox(height: 16.h),
                CustomText(
                  text: controller.errorMessage.value,
                  fontSize: 14.sp,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.fetchDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF76212),
                  ),
                  child: const Text("Retry", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        final details = controller.movieDetails.value;
        if (details == null) {
          return const Center(
            child: CustomText(
              text: "No details found.",
              color: Colors.white,
            ),
          );
        }

        return Stack(
          children: [
            // Background Poster Image with Top-to-Bottom Gradient
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 480.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  details.posterUrl.isNotEmpty
                      ? (details.posterUrl.startsWith('http')
                          ? Image.network(
                              details.posterUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey[900],
                                child: const Icon(Icons.broken_image, color: Colors.white54, size: 50),
                              ),
                            )
                          : Image.asset(
                              details.posterUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey[900],
                                child: const Icon(Icons.broken_image, color: Colors.white54, size: 50),
                              ),
                            ))
                      : Container(color: Colors.grey[900]),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                          const Color(0xFF0C0C0C),
                        ],
                        stops: const [0.0, 0.4, 0.8, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content details
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 320.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0C0C),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie Title & Basic Details (Release Year, Duration)
                        CustomText(
                          text: details.title,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF76212).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: const Color(0xFFF76212), width: 0.5),
                              ),
                              child: CustomText(
                                text: details.type,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFF76212),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: "${details.releaseYear}",
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.fiber_manual_record, size: 6.w, color: Colors.grey),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: "${details.duration} min",
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                            ),
                            if (details.planStatus.isNotEmpty) ...[
                              SizedBox(width: 8.w),
                              Icon(Icons.fiber_manual_record, size: 6.w, color: Colors.grey),
                              SizedBox(width: 8.w),
                              CustomText(
                                text: details.planStatus.join(", "),
                                fontSize: 12.sp,
                                color: const Color(0xFFF76212),
                                fontWeight: FontWeight.w600,
                              ),
                            ]
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Play Button
                        Obx(() {
                          final isPlayLoading = controller.isLoadingPlayback.value;
                          return GestureDetector(
                            onTap: isPlayLoading ? null : () => controller.playMovie(),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF76212),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF76212).withOpacity(0.3),
                                    blurRadius: 10.r,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: isPlayLoading
                                  ? SizedBox(
                                      height: 20.w,
                                      width: 20.w,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.play_arrow, color: Colors.white, size: 20.sp),
                                        SizedBox(width: 6.w),
                                        CustomText(
                                          text: "Play Movie",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        }),
                        SizedBox(height: 20.h),

                        // Description
                        CustomText(
                          text: "Storyline",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: details.description.isNotEmpty
                              ? details.description
                              : "No description available for this content.",
                          fontSize: 13.sp,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 24.h),

                        // Metadata Genres / Cast
                        if (details.genres.isNotEmpty) ...[
                          CustomText(
                            text: "Genres",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: details.genres.map((genre) => _buildGenreTag(genre)).toList(),
                          ),
                          SizedBox(height: 20.h),
                        ],

                        if (details.cast.isNotEmpty) ...[
                          CustomText(
                            text: "Cast",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: details.cast.join(", "),
                            fontSize: 13.sp,
                            color: Colors.grey[400],
                          ),
                        ],
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Back Floating Button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              left: 16.w,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildGenreTag(String genre) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: genre,
        fontSize: 12.sp,
        color: Colors.grey[300],
      ),
    );
  }
}
