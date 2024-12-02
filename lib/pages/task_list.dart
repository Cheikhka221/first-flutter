import 'package:flutter/material.dart';
import 'package:first_flutter_eval/models/task.dart';
import 'package:first_flutter_eval/pages/task_form.dart';
import 'package:first_flutter_eval/pages/task_details.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // Liste pour stocker les tâches
  final List<Task> _tasks = [];

  // Fonction pour ajouter une nouvelle tâche
  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }

  // Fonction pour supprimer une tâche
  void _deleteTask(String taskId) {
    setState(() {
      _tasks.removeWhere((task) => task.id == taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Tâches'),
        centerTitle: true,
      ),
      // Si la liste est vide, afficher un message
      body: _tasks.isEmpty
          ? const Center(
        child: Text(
          'Aucune tâche pour le moment.\nAppuyez sur + pour en ajouter une.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _tasks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                const SizedBox(height: 4),
                Text(
                  'Du ${task.startDate.toString().substring(0, 10)} au ${task.endDate.toString().substring(0, 10)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Confirmation avant suppression
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmer la suppression'),
                      content: const Text('Voulez-vous vraiment supprimer cette tâche ?'),
                      actions: [
                        TextButton(
                          child: const Text('Annuler'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Supprimer'),
                          onPressed: () {
                            _deleteTask(task.id);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            onTap: () async {
              // Navigation vers la page de détails
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsPage(task: task),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigation vers le formulaire d'ajout
          final result = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormPage()),
          );

          // Si une nouvelle tâche est retournée, l'ajouter à la liste
          if (result != null) {
            _addTask(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}