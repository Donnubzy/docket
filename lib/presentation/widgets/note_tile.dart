
import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onUpdate;
  final void Function()? onDelete;
  const NoteTile({super.key, required this.text, required this.onUpdate,
    required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: onUpdate,
                icon: const Icon(Icons.edit)
            ),
            IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete)
            ),
          ],
        ),
      ),
    );
  }
}
