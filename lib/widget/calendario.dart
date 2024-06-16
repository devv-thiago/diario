import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendario extends StatefulWidget {
  final double? height;
  final double? width;

  const Calendario({this.height = 0, this.width = 0, super.key});

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 112, 137, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TableCalendar(
        locale: 'pt_BR',
        calendarFormat: CalendarFormat.month,
        daysOfWeekHeight: 25.0,
        rowHeight: 40.0,
        headerStyle: const HeaderStyle(
          headerPadding:
              EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
        calendarStyle: const CalendarStyle(
          tablePadding: EdgeInsets.only(left: 10, right: 10),
          outsideDaysVisible: false,
          selectedDecoration: BoxDecoration(
            color: Color.fromRGBO(255, 124, 147, 1),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          holidayTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          weekendTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          todayTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.white, fontSize: 15),
          weekendStyle: TextStyle(color: Colors.white, fontSize: 15),
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
      ),
    );
  }
}
