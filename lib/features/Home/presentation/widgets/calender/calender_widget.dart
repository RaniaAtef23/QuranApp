import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime today = DateTime.now();

  void _onDateSelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return TableCalendar(
      locale: "en_US",
      rowHeight: screenWidth * 0.1,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: screenWidth * 0.07,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Colors.black,
          size: screenWidth * 0.07,
        ),
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
          color: Color(0xffF04C29),
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          color: Color(0xffF04C29),
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: screenWidth * 0.04,
          color: Colors.black,
        ),
        weekendTextStyle: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: screenWidth * 0.04,
          color: Colors.black,
        ),
      ),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      focusedDay: today,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      onDaySelected: _onDateSelected,
    );
  }
}