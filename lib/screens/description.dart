import 'package:biom/state/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DescriptionScreen extends ConsumerStatefulWidget {
	const DescriptionScreen({super.key});

	@override
	ConsumerState<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends ConsumerState<DescriptionScreen> {
  final _controller = TextEditingController();

  @override
	void initState() {
		super.initState();
	}

  void _setDescrition() {
    final inputStateNotifier = ref.read(diagnosisInputProvider.notifier);
    inputStateNotifier.setDescription(_controller.text);
    if(mounted) { context.pop(); context.push('/processing'); }
  }
  
	@override
	Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primaryContainer,
        title: Row(
          spacing: 12,
          children: [
            Icon(Icons.search, size: 36, color: colors.primary ),
            Text('Description', style: TextStyle(color: colors.primary),)
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "What have you noticed? Type here...",
            border: InputBorder.none
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setDescrition,
        child: Icon(Icons.done, color: colors.primary),
      ),
    );
  }
}