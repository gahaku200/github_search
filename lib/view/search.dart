import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../service/error_dialog.dart';
import '../view_model/dark_theme_provider.dart';
import '../view_model/search_provider.dart';

final getTheme = Provider((ref) {
  final isDark = ref.watch(themeState);
  return isDark
      ? Colors.white.withOpacity(0.9)
      : Colors.black.withOpacity(0.85);
});
final pageProvider = StateProvider<int>((_) => 1);
final isLoadingProvider = StateProvider<bool>((_) => false);

class Search extends HookConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(getTheme);
    final searchTextController = useTextEditingController();
    final searchTextFocusNode = useFocusNode();
    final scrollController = ScrollController();
    final page = ref.watch(pageProvider);
    final pageNotifier = ref.read(pageProvider.notifier);
    final result = ref.watch(searchProvider);
    final searchNotifier = ref.read(searchProvider.notifier);
    final isLoading = ref.watch(isLoadingProvider);
    final isLoadingNotifier = ref.read(isLoadingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'github検索画面',
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // 検索入力widget
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: searchTextFocusNode,
                      controller: searchTextController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                          ),
                        ),
                        hintText: 'githubリポジトリ名を入力',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchTextController.clear();
                            searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: searchTextFocusNode.hasFocus
                                ? Colors.red
                                : color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 検索ボタンwidget
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '検索',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (searchTextController.text.isNotEmpty) {
                        searchTextFocusNode.unfocus();
                        isLoadingNotifier.state = true;
                        pageNotifier.state = 1;
                        // 検索処理
                        final response = await searchNotifier.searchQuery(
                          searchTextController.text,
                          '1',
                        );
                        // 検索結果が上手くいかなかった場合エラーダイアログを表示する
                        if (response != 'success') {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ErrorDialog.errorDialog(
                              subtitle: response,
                              context: context,
                            );
                          });
                        }
                        pageNotifier.state++;
                        isLoadingNotifier.state = false;
                      }
                    },
                  ),
                ),
                // 検索結果の表示
                result.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '検索結果なし',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 800,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification &&
                                scrollController.position.extentAfter == 0) {
                              // スクロールが終了し、リストの末尾に到達した場合、追加のデータをロード
                              if (!isLoading) {
                                isLoadingNotifier.state = true;
                                searchNotifier
                                    .searchQuery(
                                  searchTextController.text,
                                  page.toString(),
                                )
                                    .then((response) {
                                  // 検索結果が上手くいかなかった場合エラーダイアログを表示する
                                  if (response != 'success') {
                                    ErrorDialog.errorDialog(
                                      subtitle: response,
                                      context: context,
                                    );
                                  }
                                  pageNotifier.state++;
                                  isLoadingNotifier.state = false;
                                });
                              }
                            }
                            return false;
                          },
                          // 検索結果リストwidget
                          child: ListView.builder(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: result.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      result[index].ownerIcon,
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                title: Text(result[index].name),
                                subtitle: Row(
                                  children: [
                                    const Icon(Icons.star_border),
                                    const SizedBox(width: 4),
                                    Text(result[index].star.toString()),
                                  ],
                                ),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ),
          // 検索中にローディングさせる
          isLoading
              ? Opacity(
                  opacity: 0.8,
                  child: Container(
                    color: Colors.grey,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
