import 'package:flutter/material.dart';
import 'package:first_flutter_eval/models/task.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la Tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(task.description),
            const SizedBox(height: 16),
            Text(
              'Date de début:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(task.startDate.toString().substring(0, 10)),
            const SizedBox(height: 16),
            Text(
              'Date de fin:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(task.endDate.toString().substring(0, 10)),
          ],
        ),
      ),
    );
  }
}