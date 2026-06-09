import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:uremz100/Data/Datasources/Remote/my_list_remote_datasource.dart';
import 'package:uremz100/Data/Models/my_collection_model.dart';
import 'package:uremz100/Data/Models/recently_watched_model.dart';
import 'package:uremz100/Data/Repositories/my_list_repository.dart';
import 'package:uremz100/Domain/UseCases/get_my_collection_usecase.dart';
import 'package:uremz100/Domain/UseCases/get_recently_watched_usecase.dart';

class MyListController extends GetxController {
  late final GetRecentlyWatchedUseCase _getRecentlyWatchedUseCase;
  late final GetMyCollectionUseCase _getMyCollectionUseCase;

  // Observables for Recently Watched
  final recentlyWatched = <RecentlyWatchedData>[].obs;
  final isRecentlyWatchedLoading = false.obs;
  final recentlyWatchedError = ''.obs;

  // Observables for My Collection
  final myCollection = <MyCollectionData>[].obs;
  final isMyCollectionLoading = false.obs;
  final isMyCollectionPaginating = false.obs;
  final myCollectionError = ''.obs;

  // Pagination states
  int _currentPage = 1;
  bool _hasNextPage = true;
  final ScrollController scrollController = ScrollController();

  // Selection state
  final isSelectionMode = false.obs;
  final selectedItems = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final remoteDataSource = MyListRemoteDataSource();
    final repository = MyListRepository(remoteDataSource);
    _getRecentlyWatchedUseCase = GetRecentlyWatchedUseCase(repository);
    _getMyCollectionUseCase = GetMyCollectionUseCase(repository);

    scrollController.addListener(_onScroll);

    fetchRecentlyWatched();
    fetchMyCollection();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreMyCollection();
    }
  }

  Future<void> refreshRecentlyWatched() async {
    await fetchRecentlyWatched();
  }

  Future<void> refreshMyCollection() async {
    _currentPage = 1;
    _hasNextPage = true;
    await fetchMyCollection();
  }

  Future<void> fetchRecentlyWatched() async {
    try {
      isRecentlyWatchedLoading(true);
      recentlyWatchedError('');
      if (kDebugMode) {
        print('Fetching Recently Watched...');
      }
      final response = await _getRecentlyWatchedUseCase.execute();
      recentlyWatched.assignAll(response.data);
      if (kDebugMode) {
        print('Recently Watched Data Size: ${recentlyWatched.length}');
      }
    } catch (e) {
      recentlyWatchedError(e.toString());
      if (kDebugMode) {
        print('Error Fetching Recently Watched: $e');
      }
    } finally {
      isRecentlyWatchedLoading(false);
    }
  }

  Future<void> fetchMyCollection() async {
    try {
      isMyCollectionLoading(true);
      myCollectionError('');
      if (kDebugMode) {
        print('Fetching My Collection - Page 1');
      }
      final response = await _getMyCollectionUseCase.execute(page: 1);
      myCollection.assignAll(response.data);
      if (response.meta != null) {
        _hasNextPage = response.meta!.hasNext;
        _currentPage = response.meta!.page;
      }
      if (kDebugMode) {
        print('My Collection Data Size: ${myCollection.length}, HasNext: $_hasNextPage');
      }
    } catch (e) {
      myCollectionError(e.toString());
      if (kDebugMode) {
        print('Error Fetching My Collection: $e');
      }
    } finally {
      isMyCollectionLoading(false);
    }
  }

  Future<void> loadMoreMyCollection() async {
    if (isMyCollectionPaginating.value || !_hasNextPage || isMyCollectionLoading.value) {
      return;
    }

    try {
      isMyCollectionPaginating(true);
      if (kDebugMode) {
        print('Fetching My Collection - Page ${_currentPage + 1}');
      }
      final response = await _getMyCollectionUseCase.execute(page: _currentPage + 1);
      myCollection.addAll(response.data);
      if (response.meta != null) {
        _hasNextPage = response.meta!.hasNext;
        _currentPage = response.meta!.page;
      }
      if (kDebugMode) {
        print('Loaded More My Collection. New Size: ${myCollection.length}, HasNext: $_hasNextPage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Loading More My Collection: $e');
      }
    } finally {
      isMyCollectionPaginating(false);
    }
  }

  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedItems.clear();
    }
  }

  void toggleItemSelected(String id) {
    if (selectedItems.contains(id)) {
      selectedItems.remove(id);
    } else {
      selectedItems.add(id);
    }
  }

  void selectAllRecentlyWatched() {
    final allIds = recentlyWatched.map((e) => e.contentId.id).toSet();
    if (selectedItems.length == allIds.length) {
      selectedItems.clear();
    } else {
      selectedItems.addAll(allIds);
    }
  }

  void selectAllMyCollection() {
    final allIds = myCollection.map((e) => e.itemId.id).toSet();
    if (selectedItems.length == allIds.length) {
      selectedItems.clear();
    } else {
      selectedItems.addAll(allIds);
    }
  }

  void removeSelected() {
    // Implement API call to remove items if backend supports it
    // For now, we just remove them locally
    recentlyWatched.removeWhere((item) => selectedItems.contains(item.contentId.id));
    myCollection.removeWhere((item) => selectedItems.contains(item.itemId.id));
    selectedItems.clear();
    isSelectionMode.value = false;
  }
}
