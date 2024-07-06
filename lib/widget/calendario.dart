import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendario extends StatefulWidget {
  final double? height;
  final double? width;
  final Function(DateTime)? onDaySelected;

  const Calendario({
    this.height = 0,
    this.width = 0,
    this.onDaySelected,
    Key? key,
  }) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String capitalizeMonth(DateTime date) {
    String month = DateFormat.MMMM('pt_BR').format(date);
    return month[0].toUpperCase() + month.substring(1);
  }

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
        headerStyle: HeaderStyle(
          headerPadding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonVisible: false,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          titleTextFormatter: (date, locale) => capitalizeMonth(date),
        ),
        calendarStyle: CalendarStyle(
          tablePadding: const EdgeInsets.only(left: 10, right: 10),
          outsideDaysVisible: false,
          selectedDecoration: const BoxDecoration(
            color: Color.fromRGBO(255, 124, 147, 1),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          holidayTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          todayTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2099, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return _selectedDay == day;
        },
        onDaySelected: (selectedDay, focusedDay) async {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });

          if (widget.onDaySelected != null) {
            widget.onDaySelected!(selectedDay);
          }
        },
      ),
    );
  }
}
