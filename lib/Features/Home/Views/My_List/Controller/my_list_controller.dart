import 'package:get/get.dart';
import '../Model/my_list_model.dart';
import '../Data/my_list_data.dart';

class MyListController extends GetxController {
  final recentlyWatched = <MovieItem>[...MyListData.recentlyWatchedData].obs;
  final myCollection = <MovieItem>[...MyListData.myCollectionData].obs;

  final isSelectionMode = false.obs;
  final selectedItems = <String>{}.obs;

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

  void selectAll() {
    final allIds = [
      ...recentlyWatched,
      ...myCollection,
    ].map((e) => e.id).toSet();
    if (selectedItems.length == allIds.length) {
      selectedItems.clear();
    } else {
      selectedItems.addAll(allIds);
    }
  }

  void removeSelected() {
    recentlyWatched.removeWhere((item) => selectedItems.contains(item.id));
    myCollection.removeWhere((item) => selectedItems.contains(item.id));
    selectedItems.clear();
    isSelectionMode.value = false;
  }
}
