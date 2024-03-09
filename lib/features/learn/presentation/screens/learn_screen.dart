import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recall_table/core/theme/constants.dart';
import 'package:recall_table/features/learn/data/number_repository.dart';

// Convert StatefulWidget to ConsumerStatefulWidget
class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

// Update the State class to extend ConsumerState
class _LearnScreenState extends ConsumerState<LearnScreen> {
  final _controller = ScrollController();
  int _itemCount = 20; // Initial number of items

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMoreIfNeeded());
    _controller.addListener(_loadMoreIfNeeded);
  }

  void _loadMoreIfNeeded() {
    if (!_controller.hasClients) return; // Ensure the controller is attached

    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.position.pixels;
    bool endOfListReached = maxScroll - currentScroll <= 0;
    bool listTooShort = maxScroll == 0;

    if (endOfListReached || listTooShort) {
      setState(() {
        _itemCount = _itemCount + 20 <= 100 ? _itemCount + 20 : 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              // context.pop(), // Corrected to use context.pop for back navigation
              context.go('/'),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: ThemeConstants.maxWidth),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                controller: _controller,
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  return FutureBuilder<String?>(
                    future: ref.read(hiveNumberProvider).getNumberWord(index),
                    builder: (context, snapshot) {
                      final word = snapshot.data ?? '';
                      return ListTile(
                        title: Text('$index'),
                        trailing: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: TextEditingController(text: word),
                            onChanged: (newValue) {
                              ref
                                  .read(hiveNumberProvider)
                                  .saveNumberWord(index, newValue);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
