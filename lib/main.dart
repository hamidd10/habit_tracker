import 'package:flutter/material.dart';

import 'habit_class.dart';

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HabitListScreen(),
    );
  }
}



class HabitListScreen extends StatefulWidget {
  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  List<Habit> habits = [];
  TextEditingController _habitController = TextEditingController();

  void _addHabit(String habitName) {
    if (habitName.isNotEmpty) {
      setState(() {
        habits.add(Habit(name: habitName));
      });
      _habitController.clear();
    }
  }

  void _toggleHabitCompletion(int index) {
    setState(() {
      habits[index].isCompleted = !habits[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90CAF8),
      appBar: AppBar(
        title: const Text(
          'Habit Tracker',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              fontSize: 24),
        ),
        backgroundColor: const Color(0xFF339EEC),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _habitController,
                    decoration: InputDecoration(
                      hintText: 'Enter a new habit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addHabit(_habitController.text),
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: habits[index].isCompleted,
                    onChanged: (_) => _toggleHabitCompletion(index),
                  ),
                  title: Text(
                    habits[index].name,
                    style: TextStyle(
                      decoration: habits[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        habits.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
