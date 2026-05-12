import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Models/discrive_models.dart';
import '../Data/discover_data.dart';

class DiscoverController extends GetxController {
  var selectedCategory = 'Popular'.obs;
  var showBonusPopup = false.obs;
  var vipPeriod = 'Daily'.obs;
  var selectedRankingTab = 'Popular'.obs;
  var selectedMovie = Rxn<DiscoverMovie>(); // Selected movie for popup
  var showMoviePopup = false.obs; // Toggle movie popup visibility
  var showLoginPopup = false.obs; // Toggle login popup visibility
  static bool _hasShownInitialPopups = false;

  late ScrollController popularScrollController;
  Timer? _marqueeTimer;

  final List<String> categories = DiscoverData.categories;
  final List<DiscoverMovie> allMovies = DiscoverData.allMovies;
  final List<BonusItem> dailyBonus = DiscoverData.dailyBonus;

  @override
  void onInit() {
    super.onInit();
    popularScrollController = ScrollController();
    _startMarquee();
  }

  void _startMarquee() {
    _marqueeTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (popularScrollController.hasClients) {
        double maxScroll = popularScrollController.position.maxScrollExtent;
        double currentScroll = popularScrollController.offset;

        if (currentScroll >= maxScroll) {
          // Go back to start
          popularScrollController.jumpTo(0);
        } else {
          // Slide by exactly 3 items (120w item * 3 = 360w)
          popularScrollController.animateTo(
            currentScroll + 360.w,
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn,
          );
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Trigger popups on first load
    if (!_hasShownInitialPopups) {
      if (allMovies.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          openMoviePopup(allMovies.first);
          _hasShownInitialPopups = true;
        });
      }
    }
  }

  void openMoviePopup(DiscoverMovie movie) {
    selectedMovie.value = movie;
    showMoviePopup.value = true;
  }

  void closeMoviePopup() {
    showMoviePopup.value = false;
    // After 500ms, show login popup
    Future.delayed(const Duration(milliseconds: 500), () {
      showLoginPopup.value = true;
    });
  }

  void closeLoginPopup() {
    showLoginPopup.value = false;
    // After 1 second, show bonus popup
    Future.delayed(const Duration(seconds: 1), () {
      showBonusPopup.value = true;
    });
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void changeVipPeriod(String period) {
    vipPeriod.value = period;
  }

  List<DiscoverMovie> get vipMovies {
    final period = vipPeriod.value;
    if (period == 'Daily') {
      return allMovies.take(6).toList();
    } else if (period == 'Weekly') {
      return allMovies.skip(3).take(6).toList();
    }
    return allMovies.take(6).toList();
  }

  void changeRankingTab(String tab) {
    selectedRankingTab.value = tab;
  }

  List<DiscoverMovie> get filteredMovies {
    if (selectedCategory.value == 'Popular') {
      return allMovies;
    }
    return allMovies
        .where((movie) => movie.categories.contains(selectedCategory.value))
        .toList();
  }

  List<DiscoverMovie> get rankingMovies {
    // selectedRankingTab.value অ্যাক্সেস করার মাধ্যমে এই গেটারটিকে রিঅ্যাক্টিভ করা হয়েছে
    // যাতে ইউজার যখনই ট্যাবে ক্লিক করবে, তখনই ডাটা আপডেট হয়।
    final tab = selectedRankingTab.value;

    // মডেল থেকে সব ডাটা নিয়ে আসা হচ্ছে।
    // এখানে আপনি প্রতিটি ক্যাটাগরির জন্য আলাদা ফিল্টারিং লজিক দিতে পারেন।
    if (tab == 'Popular') {
      // Popular ক্যাটাগরির মুভিগুলো রিটার্ন করা হচ্ছে
      return allMovies.where((m) => m.categories.contains('Popular')).toList();
    } else if (tab == 'Daily Top') {
      // Daily Top ক্যাটাগরির মুভিগুলো ফিল্টার করে আনা হচ্ছে
      return allMovies
          .where(
            (m) => m.categories.contains('Daily Top') || m.views.contains('M'),
          )
          .toList();
    } else if (tab == 'Weekly Top') {
      // Weekly Top এর জন্য ডাটা ফিল্টার করা হচ্ছে
      return allMovies
          .where((m) => m.categories.contains('Weekly Top') || m.isVip)
          .toList();
    } else if (tab == 'Monthly Top') {
      // Monthly Top এর জন্য মডেল থেকে ডাটা ফিল্টার করা হচ্ছে
      return allMovies
          .where((m) => m.categories.contains('Monthly Top') || m.badge != null)
          .toList();
    }

    // ডিফল্টভাবে সব মুভি দেখানো হচ্ছে যদি কোনো কন্ডিশন না মিলে
    return allMovies;
  }

  void closePopup() {
    showBonusPopup.value = false;
  }

  @override
  void onClose() {
    _marqueeTimer?.cancel();
    popularScrollController.dispose();
    super.onClose();
  }
}
