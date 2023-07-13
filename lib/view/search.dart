import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/search_model.dart';
import '../view_model/dark_theme_provider.dart';

final listProdcutSearchProvider = StateProvider<List<SearchModel>>((_) => []);

final getTheme = Provider((ref) {
  final isDark = ref.watch(themeState);
  return isDark
      ? Colors.white.withOpacity(0.9)
      : Colors.black.withOpacity(0.85);
});

class Search extends HookConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(getTheme);
    final size = MediaQuery.of(context).size;
    final searchTextController = useTextEditingController();
    final searchTextFocusNode = useFocusNode();
    final listProdcutSearch = ref.watch(listProdcutSearchProvider);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: searchTextFocusNode,
                  controller: searchTextController,
                  onChanged: (value) {},
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
                        color:
                            searchTextFocusNode.hasFocus ? Colors.red : color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            listProdcutSearch.isEmpty
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
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.61),
                    children: List.generate(
                      listProdcutSearch.length,
                      (index) {
                        return Container();
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
