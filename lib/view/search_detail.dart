// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'search.dart';

class SearchDetail extends HookConsumerWidget {
  const SearchDetail({
    super.key,
    required this.name,
    required this.ownerIcon,
    required this.language,
    required this.star,
    required this.watcher,
    required this.fork,
    required this.issue,
  });

  final String name;
  final String ownerIcon;
  final String language;
  final int star;
  final int watcher;
  final int fork;
  final int issue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(getTheme);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Center(
                  child: Text(
                    '検索詳細',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      ownerIcon,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    name,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Text(
                  '開発言語：$language',
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                  ),
                ),
                _iconLabel(
                  icon: Icons.star_border,
                  color: color,
                  text: star.toString(),
                ),
                _iconLabel(
                  icon: Icons.visibility_outlined,
                  color: color,
                  text: watcher.toString(),
                ),
                _iconLabel(
                  icon: Icons.fork_right_outlined,
                  color: color,
                  text: fork.toString(),
                ),
                _iconLabel(
                  icon: Icons.bug_report_outlined,
                  color: color,
                  text: issue.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconLabel({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
