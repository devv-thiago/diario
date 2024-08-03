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
    super.key,
  });

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

  String capitalize(String stringToCap) {
    return "${stringToCap[0].toUpperCase()}${stringToCap.substring(1)}";
  }

  String removeDot(String day) {
    return day.replaceAll('.', '');
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
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleTextFormatter: (date, locale) => capitalizeMonth(date),
        ),
        calendarStyle: CalendarStyle(
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          tablePadding: const EdgeInsets.only(left: 10, right: 10),
          outsideDaysVisible: false,
          selectedDecoration: const BoxDecoration(
            color: Color.fromRGBO(252, 93, 127, 1),
            shape: BoxShape.circle,
          ),
          defaultDecoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
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
          dowTextFormatter: (date, locale) {
            String dayText = DateFormat.E(locale).format(date);
            String dayCap = capitalize(dayText);
            return removeDot(dayCap);
          },
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
