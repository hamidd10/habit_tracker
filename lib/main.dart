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
  TextEditingController habitController = TextEditingController();

  void addHabit(String habitName) {
    if (habitName.isNotEmpty) {
      setState(() {
        habits.add(Habit(name: habitName));
      });
      habitController.clear();
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
      backgroundColor: const Color(0xFF90CAF8),
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                        color: Color(0xFF339EEC), fontStyle: FontStyle.italic),
                    controller: habitController,
                    decoration: InputDecoration(
                      hintText: 'Enter a new habit',
                      hintStyle: const TextStyle(
                          color: Color(0xFF339EEC),
                          fontStyle: FontStyle.italic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF339EEC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF339EEC)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF339EEC)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addHabit(habitController.text),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF339EEC),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 21),
                      textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  child: const Text('ADD'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 3, color: Color(0xFF90CAF8)),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      tileColor: const Color(0xFF339EEC),
                      leading: Checkbox(
                        value: habits[index].isCompleted,
                        onChanged: (_) => _toggleHabitCompletion(index),
                        checkColor: Colors.white,
                      ),
                      title: Text(
                        habits[index].name,
                        style: TextStyle(
                          decoration: habits[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            habits.removeAt(index);
                          });
                        },
                      ),
                    ),
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
