import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Controllers/calander_controller.dart';
import 'package:loyadhamsatsang/Models/Calander.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreenUI extends StatefulWidget {
  const CalenderScreenUI({super.key});

  @override
  State<CalenderScreenUI> createState() => _CalenderScreenUIState();
}

class _CalenderScreenUIState extends State<CalenderScreenUI> {
  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  var Calander = Get.put(CalanderController());
  DateTime _currentMonth = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Calendar",
        ),
        body: Obx(
          () => Calander.isLoading.value
              ? SizedBox.shrink()
              : Column(
                  children: [
                    _buildHeader(),
                    _buildWeeks(),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentMonth =
                                DateTime(_currentMonth.year, index + 1, 1);
                            // if (_currentVisibleMonth.year >
                            //     DateTime.now().year) {
                            //   _currentVisibleMonth = DateTime(
                            //       DateTime.now().year,
                            //       _currentVisibleMonth.month,
                            //       1);
                            // }
                          });
                        },
                        itemCount: 12 *
                            10, // Show 10 years, adjust this count as needed
                        itemBuilder: (context, pageIndex) {
                          DateTime month = DateTime(
                              _currentMonth.year, (pageIndex % 12) + 1, 1);
                          return _buildCalendar(month, Calander);
                        },
                      ),
                    ),
                  ],
                ),
        ));
  }

  DateTime _currentVisibleMonth = DateTime.now();

  Widget _buildHeader() {
    bool isLastMonthOfYear = _currentMonth.month == 12;
    bool isCurrentYear = _currentMonth.year == DateTime.now().year;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_pageController.page! > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          Text(
            '${DateFormat('MMMM yyyy').format(_currentMonth)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              if (!isLastMonthOfYear || isCurrentYear) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeeks() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWeekDay('Mon'),
          _buildWeekDay('Tue'),
          _buildWeekDay('Wed'),
          _buildWeekDay('Thu'),
          _buildWeekDay('Fri'),
          _buildWeekDay('Sat'),
          _buildWeekDay('Sun'),
        ],
      ),
    );
  }

  Widget _buildWeekDay(String day) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCalendar(DateTime month, CalanderController calendar) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay =
        firstDayOfMonth.weekday; // Get weekday of the first day

    // Calculate the last day of the previous month
    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.4,
        //crossAxisSpacing: 4.0,
        //  mainAxisSpacing: 4.0,
      ),
      itemCount: daysInMonth + weekdayOfFirstDay - 1,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          // Show dates from the previous month in grey
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide.none, // Remove top line
              left: BorderSide(
                  width: 1.0, color: Colors.grey), // Example: left border
              right: BorderSide(
                  width: 1.0, color: Colors.grey), // Example: right border
              bottom: BorderSide(
                  width: 1.0, color: Colors.grey), // Example: bottom border
            )),
            alignment: Alignment.center,
            child: Text(
              previousMonthDay.toString(),
              style: TextStyle(color: Colors.grey),
            ),
          );
        } else {
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          String text = date.day.toString(); // Day number text

          CalenderData? currentDateData = calendar.list.firstWhere(
            (element) =>
                DateTime.parse(element.icDate!.toString()).isSameDate(date),
            orElse: () => CalenderData(),
          );

          return InkWell(
            onTap: () {
              // Handle date cell tap
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide.none, // Remove top line
                  left: BorderSide(
                      width: 1.0, color: Colors.grey), // Example: left border
                  right: BorderSide(
                      width: 1.0, color: Colors.grey), // Example: right border
                  bottom: BorderSide(
                      width: 1.0, color: Colors.grey), // Example: bottom border
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (currentDateData.icon != null)
                    Image.network(
                      currentDateData.icon
                          .toString(), // Replace with your image URL
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                    child: Text(
                      "${currentDateData.monthTitleEng}${currentDateData.pakshaTitleEng}${currentDateData.tithiTitleEng}" ??
                          '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 127, 126, 126)),
                    ),
                  ), // Display the month title
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
