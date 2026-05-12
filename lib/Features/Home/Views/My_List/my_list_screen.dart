import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uremz100/Config/routes.dart';
import 'package:uremz100/Shared/Widgets/Custom_AppBar.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_icons.dart';
import 'Controller/my_list_controller.dart';
import 'Model/my_list_model.dart';
import '../Bottom_NabBar/Controller/Bottom_NabBar_Controller.dart';

class MyListScreen extends GetView<MyListController> {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyListController());
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Collection",
        onBackPressed: () {
          final NavigationController navController =
              Get.find<NavigationController>();
          navController.changeIndex(0);
        },
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.standardVip),
              child: SvgPicture.asset(
                AppIcons.vip_icon,
                height: 30.w,
                width: 30.w,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildSectionHeader("Recently Watched"),
                SizedBox(height: 15.h),
                Obx(
                  () => _buildMovieGrid(
                    controller.recentlyWatched,
                    controller.isSelectionMode.value,
                  ),
                ),
                SizedBox(height: 18.h),
                _buildSectionHeader("My Collection"),
                SizedBox(height: 16.h),
                Obx(
                  () => _buildMovieGrid(
                    controller.myCollection,
                    controller.isSelectionMode.value,
                  ),
                ),
                SizedBox(height: 100.h), // Space for bottom buttons
              ],
            ),
          ),
          Obx(
            () => controller.isSelectionMode.value
                ? _buildBottomActionBar()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return CustomText(
      text: title,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }

  Widget _buildMovieGrid(List<MovieItem> items, bool isSelectionMode) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.55,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildMovieCard(item, isSelectionMode);
      },
    );
  }

  Widget _buildMovieCard(MovieItem item, bool isSelectionMode) {
    return GestureDetector(
      onLongPress: controller.toggleSelectionMode,
      onTap: () {
        if (controller.isSelectionMode.value) {
          controller.toggleItemSelected(item.id);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  item.image,
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Ribbon Badge
              if (item.badge != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getBadgeColor(item.badge!),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r),
                      ),
                    ),
                    child: CustomText(
                      text: item.badge!,
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              // Play Count
              Positioned(
                bottom: 8.h,
                right: 4.w,
                child: Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 16.sp),
                    SizedBox(width: 2.w),
                    CustomText(
                      text: item.views,
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              // Selection Overlay
              if (isSelectionMode)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Obx(() {
                    final isSelected = controller.selectedItems.contains(
                      item.id,
                    );
                    return Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFFD700) // Golden/Yellow circle
                            : Colors.black38,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.w),
                      ),
                      child: Icon(
                        Icons.check,
                        color: isSelected ? Colors.white : Colors.transparent,
                        size: 12.sp,
                      ),
                    );
                  }),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: item.title,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFFE3E3E3),
            overflow: TextOverflow.ellipsis,
          ),
          CustomText(
            text: item.subtitle,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFFE3E3E3),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(String badge) {
    switch (badge.toLowerCase()) {
      case 'exclusive':
        return Color(0xFFF76212);
      case 'new':
        return Color(0xFFF76212);
      case 'vip':
        return Color(0xFFF76212);
      default:
        return Color(0xFFF76212);
    }
  }

  Widget _buildBottomActionBar() {
    return Positioned(
      bottom: 20.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange100),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextButton(
                onPressed: controller.selectAll,
                child: CustomText(
                  text: "Select All",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: controller.removeSelected,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: CustomText(
                  text: "Remove",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
