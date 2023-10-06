import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? onDelete;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            flex: 0,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(14),
            backgroundColor: Colors.red.shade500,
          )
        ],
      ),
      child: CheckboxListTile(
        value: taskCompleted,
        onChanged: onChanged,
        title: Text(
          taskName,
          style: TextStyle(
            decoration: taskCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        checkboxShape: const CircleBorder(),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
