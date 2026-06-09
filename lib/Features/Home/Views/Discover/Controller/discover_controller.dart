import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Models/discrive_models.dart';
import '../Data/discover_data.dart';
import 'package:uremz100/Data/Repositories/home_repository.dart';
import 'package:uremz100/Data/Models/home_content_model.dart';

class DiscoverController extends GetxController {
  final HomeRepository _homeRepository = Get.find<HomeRepository>();

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

  // New API State
  // Popular API State
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // New Tab API State
  var isNewLoading = false.obs;
  var hasNewError = false.obs;
  var newErrorMessage = ''.obs;
  var newSections = <HomeSection>[].obs;

  // VIP Tab API State
  var isVipLoading = false.obs;
  var hasVipError = false.obs;
  var vipErrorMessage = ''.obs;
  var vipSections = <HomeSection>[].obs;

  // Dynamic Lists mapped to DiscoverMovie for Popular Tab
  var trendingMovies = <DiscoverMovie>[].obs;
  var seriesMovies = <DiscoverMovie>[].obs;
  var continueWatchingMovies = <DiscoverMovie>[].obs;
  var youMightLikeMovies = <DiscoverMovie>[].obs;
  var topPicksMovies = <DiscoverMovie>[].obs;

  @override
  void onInit() {
    super.onInit();
    popularScrollController = ScrollController();
    _startMarquee();
    fetchHomeContent();
  }

  Future<void> fetchHomeContent() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final response = await _homeRepository.getHomeContent('popular');

    if (response.isSuccess && response.data != null) {
      _mapSectionsToState(response.data!.sections);
    } else {
      hasError.value = true;
      errorMessage.value = response.message;
    }
    
    isLoading.value = false;
  }

  Future<void> fetchNewContent() async {
    isNewLoading.value = true;
    hasNewError.value = false;
    newErrorMessage.value = '';

    final response = await _homeRepository.getHomeContent('new');

    if (response.isSuccess && response.data != null) {
      newSections.value = response.data!.sections;
    } else {
      hasNewError.value = true;
      newErrorMessage.value = response.message;
    }
    
    isNewLoading.value = false;
  }

  Future<void> refreshData() async {
    if (selectedCategory.value == 'Popular') {
      await fetchHomeContent();
    } else if (selectedCategory.value == 'New') {
      await fetchNewContent();
    } else if (selectedCategory.value == 'VIP') {
      await fetchVipContent(vipPeriod.value.toLowerCase());
    }
    // For other tabs, add fetch calls as they are implemented
  }

  Future<void> fetchVipContent(String filter) async {
    isVipLoading.value = true;
    hasVipError.value = false;
    vipErrorMessage.value = '';

    final response = await _homeRepository.getHomeContent('vip', filter: filter);

    if (response.isSuccess && response.data != null) {
      vipSections.value = response.data!.sections;
    } else {
      hasVipError.value = true;
      vipErrorMessage.value = response.message;
    }
    
    isVipLoading.value = false;
  }

  void _mapSectionsToState(List<HomeSection> sections) {
    trendingMovies.clear();
    seriesMovies.clear();
    continueWatchingMovies.clear();
    youMightLikeMovies.clear();
    topPicksMovies.clear();

    for (var section in sections) {
      final mappedItems = section.items.map((item) => DiscoverMovie(
        id: item.id.toString(),
        title: item.title,
        subtitle: item.contentType,
        image: item.poster,
        badge: item.isRecent ? 'New' : null,
        views: item.rating.toString(),
        categories: ['Popular'],
      )).toList();

      switch (section.type) {
        case 'TRENDING':
          trendingMovies.addAll(mappedItems);
          break;
        case 'SERIES':
          seriesMovies.addAll(mappedItems);
          break;
        case 'CONTINUE_WATCHING':
          continueWatchingMovies.addAll(mappedItems);
          break;
        case 'YOU_MIGHT_LIKE':
          youMightLikeMovies.addAll(mappedItems);
          break;
        case 'TOP_PICKS':
          topPicksMovies.addAll(mappedItems);
          break;
      }
    }
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
    if (category == 'New' && (newSections.isEmpty || hasNewError.value)) {
      fetchNewContent();
    } else if (category == 'VIP' && (vipSections.isEmpty || hasVipError.value)) {
      fetchVipContent(vipPeriod.value.toLowerCase());
    }
  }

  void changeVipPeriod(String period) {
    if (vipPeriod.value != period) {
      vipPeriod.value = period;
      fetchVipContent(period.toLowerCase());
    }
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
    final tab = selectedRankingTab.value;

    if (tab == 'Popular') {
      return allMovies.where((m) => m.categories.contains('Popular')).toList();
    } else if (tab == 'Daily Top') {
      return allMovies
          .where(
            (m) => m.categories.contains('Daily Top') || m.views.contains('M'),
          )
          .toList();
    } else if (tab == 'Weekly Top') {
      return allMovies
          .where((m) => m.categories.contains('Weekly Top') || m.isVip)
          .toList();
    } else if (tab == 'Monthly Top') {
      return allMovies
          .where((m) => m.categories.contains('Monthly Top') || m.badge != null)
          .toList();
    }

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
