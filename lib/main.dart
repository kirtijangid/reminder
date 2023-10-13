import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReminderScreen(),
    );
  }
}

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final List<String> daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  String selectedDay = "Monday"; // Default day
  TimeOfDay selectedTime = TimeOfDay.now();
  final List<String> activities = [
    "Wake up",
    "Go to gym",
    "Breakfast",
    "Meetings",
    "Lunch",
    "Quick nap",
    "Go to library",
    "Dinner",
    "Go to sleep",
  ];
  String selectedActivity = "Wake up"; // Default activity
  bool isReminderSet = false; // Flag to track if the reminder is set

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedDay,
              items: daysOfWeek.map((day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (day) {
                setState(() {
                  selectedDay = day!;
                });
              },
            ),
            Text("Time: ${selectedTime.format(context)}"),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Pick a Time"),
            ),
            DropdownButton<String>(
              value: selectedActivity,
              items: activities.map((activity) {
                return DropdownMenuItem<String>(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (activity) {
                setState(() {
                  selectedActivity = activity!;
                });
              },
            ),
           isReminderSet
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReminderSet = false;
                      // Logic to cancel the scheduled reminder
                    });
                  },
                  child: Text("Done"),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                )
              : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReminderSet = true;
                      // Logic to schedule a reminder using flutter_local_notifications
                      // You can specify the selectedDay, selectedTime, and selectedActivity here
                      // Also, play the chime sound using audioplayers when the reminder is due
                    });
                  },
                  child: Text("Set Reminder"),
                ),
        ],
          
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}
