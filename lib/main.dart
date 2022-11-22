import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const AppointmentDisplayMode());

class AppointmentDisplayMode extends StatefulWidget {
  const AppointmentDisplayMode({super.key});

  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

List<String> _appointmentDisplayModes = <String>[
  'Appointment',
  'Indicator',
  'None',
];

class ScheduleExample extends State<AppointmentDisplayMode> {
  MonthAppointmentDisplayMode? _displayMode =
      MonthAppointmentDisplayMode.appointment;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Select display mode"),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () {}),
            PopupMenuButton<String>(
              icon: const Icon(Icons.party_mode),
              itemBuilder: (BuildContext context) {
                return _appointmentDisplayModes.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (String value) {
                setState(() {
                  if (value == 'Appointment') {
                    _displayMode = MonthAppointmentDisplayMode.appointment;
                  } else if (value == 'Indicator') {
                    _displayMode = MonthAppointmentDisplayMode.indicator;
                  } else if (value == 'None') {
                    _displayMode = MonthAppointmentDisplayMode.none;
                  }
                });
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: getCalendarDataSource(),
                monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode: _displayMode!, showAgenda: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 7)),
      subject: 'Performance check',
      color: Colors.amber,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}