// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/calander_controller.dart';
import 'package:loyadhamsatsang/Models/Calander.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class CalenderScreenUI extends StatefulWidget {
  const CalenderScreenUI({super.key});

  @override
  State<CalenderScreenUI> createState() => _CalenderScreenUIState();
}

class _CalenderScreenUIState extends State<CalenderScreenUI> {
  // ignore: prefer_final_fields
  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  var Calander = Get.put(CalanderController());
  DateTime _currentMonth = DateTime.now();
  bool english = true;
  bool gujarati = false;
  bool selectedcurrentyear = false;
  @override
  void initState() {
    super.initState();
    Calander.startdate = null;
    Calander.enddate = null;
    english = true;
    gujarati = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Calendar",
        ),
        body: Obx(
          () => Calander.isLoading.value
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              english = true;
                              gujarati = false;
                            });
                          },
                          child: Container(
                            height: 30.0,
                            width: 70.0,
                            margin: EdgeInsets.only(top: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                color:
                                    english ? AppColors.apptheme : Colors.white,
                                border: Border.all(
                                    color: english
                                        ? AppColors.apptheme
                                        : Colors.black),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: Text(
                                "EN",
                                style: TextStyle(
                                    color:
                                        english ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              english = false;
                              gujarati = true;
                            });
                          },
                          child: Container(
                            height: 30.0,
                            width: 70.0,
                            margin: EdgeInsets.only(top: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                color: gujarati
                                    ? AppColors.apptheme
                                    : Colors.white,
                                border: Border.all(
                                    color: gujarati
                                        ? AppColors.apptheme
                                        : Colors.black),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: Text(
                                "GUJ",
                                style: TextStyle(
                                    color:
                                        gujarati ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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

  //DateTime _currentVisibleMonth = DateTime.now();
//! Months and year dropDown Code---------------->
  Widget _buildHeader() {
    bool isLastMonthOfYear = _currentMonth.month == 12;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            '${DateFormat('MMMM').format(_currentMonth)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<int>(
            value: _currentMonth.year,
            onChanged: (int? year) {
              if (year != null) {
                setState(() {
                  _currentMonth = DateTime(
                      year, 1, 1); // Set to January of the selected year
                  Calander.enddate = "$year-12-31";
                  Calander.startdate = "$year-01-01";
                  Calander.getData("$year-01-01", "$year-12-31");

                  int yearDiff = DateTime.now().year - year;
                  int monthIndex = 12 * yearDiff + _currentMonth.month - 1;
                  _pageController.jumpToPage(monthIndex);
                });
              }
            },
            items: [
              for (int year = DateTime.now().year;
                  year <= DateTime.now().year + 10;
                  year++)
                DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              if (!isLastMonthOfYear) {
                setState(() {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              }
            },
          ),
        ],
      ),
    );
  }

//! Weeks day Code------------------>
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

//! Whole Calendar Code-------------------->
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);

          return Container(
            decoration: BoxDecoration(
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
          bool isCurrentDate = DateTime.now().isSameDate(date);
          Calender? currentDateData = calendar.list.firstWhere(
            (element) =>
                DateTime.parse(element.icDate!.toString()).isSameDate(date),
            orElse: () => Calender(),
          );

          return InkWell(
            onTap: () {
              // Handle date cell tap
              popupdialog(
                  context,
                  text,
                  month.year.toString(),
                  month.month,
                  currentDateData.monthTitleEng.toString(),
                  currentDateData.pakshaTitleEng.toString(),
                  currentDateData.tithiTitleEng.toString(),
                  currentDateData.chandraTitleEng.toString(),
                  currentDateData.nakshatraTitleEng.toString(),
                  currentDateData.tithiTitleGuj.toString(),
                  currentDateData.chandraTitleGuj.toString(),
                  currentDateData.nakshatraTitleGuj.toString(),
                  gujarati,
                  currentDateData.monthTitleGuj.toString(),
                  currentDateData.pakshaTitleGuj.toString(),
                  currentDateData.sunset.toString(),
                  currentDateData.sunrise.toString(),
                  currentDateData.calenderEvent);
            },
            child: Container(
              decoration: BoxDecoration(
                border: const Border(
                  top: BorderSide.none, // Remove top line
                  left: BorderSide(
                      width: 1.0, color: Colors.grey), // Example: left border
                  right: BorderSide(
                      width: 1.0, color: Colors.grey), // Example: right border
                  bottom: BorderSide(
                      width: 1.0, color: Colors.grey), // Example: bottom border
                ),
                color: isCurrentDate ? AppColors.apptheme : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isCurrentDate ? Colors.white : null,
                        ),
                      ),
                    ),
                  ),
                  //  if (currentDateData.calenderEvent!)
                  if (currentDateData.calenderEvent!.isNotEmpty)
                    if (currentDateData.calenderEvent![0].icon != null)
                      Expanded(
                        flex: 0,
                        child: SizedBox(
                          child: Image.network(
                            currentDateData.calenderEvent![0].icon.toString(),
                            // Replace with your image URL
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  if (currentDateData.calenderEvent!.isNotEmpty)
                    if (currentDateData.calenderEvent![0].icon == null)
                      const Expanded(
                        flex: 0,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                        ),
                      ),
                  if (currentDateData.calenderEvent!.isEmpty)
                    const Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                      ),
                    ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: english
                            ? Text(
                                "${currentDateData.monthTitleEng}${currentDateData.pakshaTitleEng}${currentDateData.tithiTitleEng}" ??
                                    '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: isCurrentDate
                                        ? Colors.white
                                        : Color.fromARGB(255, 127, 126, 126)),
                              )
                            : Text(
                                "${currentDateData.monthTitleGuj}${currentDateData.pakshaTitleGuj}${currentDateData.tithiTitleGuj}" ??
                                    '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: isCurrentDate
                                        ? Colors.white
                                        : Color.fromARGB(255, 127, 126, 126)),
                              )),
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

//! Popup UI---------------------->
Future<void> popupdialog(
    BuildContext context,
    String date,
    String year,
    int month,
    String monttitle,
    String pakshaTitle,
    String tithiTitle,
    String chandra_title_eng,
    String nakshatra_title_eng,
    String tithi_titl_eGuj,
    String chandra_title_Guj,
    String nakshatar_title_Guj,
    bool gujSelect,
    String month_title_guj,
    String paksha_title_guj,
    String sunset,
    String sunRise,
    List<CalenderEvent>? calenderEvent) {
  var aplhaMonth = DateFormat.MMMM().format(DateTime(2000, month));
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              height: screenHeight(context) / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColors.apptheme,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(aplhaMonth.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                date,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(year,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 10.0),
                          child: gujSelect
                              ? Text(
                                  // ignore: unnecessary_brace_in_string_interps
                                  "${month_title_guj}"
                                  // ignore: unnecessary_brace_in_string_interps
                                  " ${paksha_title_guj}"
                                  // ignore: unnecessary_brace_in_string_interps
                                  " ${tithi_titl_eGuj}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              : Text(
                                  // ignore: unnecessary_brace_in_string_interps
                                  "${monttitle}"
                                  // ignore: unnecessary_brace_in_string_interps
                                  " ${pakshaTitle}"
                                  // ignore: unnecessary_brace_in_string_interps
                                  " ${tithiTitle}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: RichText(
                        text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                          fontSize: 17.0,
                          color: AppColors.apptheme,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        const TextSpan(text: 'Chandra: '),
                        gujSelect
                            ? TextSpan(
                                text: chandra_title_Guj.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 67, 67, 67),
                                    fontSize: 16.0))
                            : TextSpan(
                                text: chandra_title_eng.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 67, 67, 67),
                                    fontSize: 16.0))
                      ],
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: RichText(
                        text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                          fontSize: 17.0,
                          color: AppColors.apptheme,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(text: 'Nakshatra: '),
                        gujSelect
                            ? TextSpan(
                                text: nakshatar_title_Guj.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 67, 67, 67),
                                    fontSize: 16.0))
                            : TextSpan(
                                text: nakshatra_title_eng.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 67, 67, 67),
                                    fontSize: 16.0))
                      ],
                    )),
                  ),
                  calenderEvent!.isEmpty || calenderEvent!.length == 0
                      ? SizedBox()
                      : Expanded(
                          child: ListView.builder(
                          itemCount: calenderEvent!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(calenderEvent[index]
                                  .vratUtsavNameEng
                                  .toString()),
                            );
                          },
                        )),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/previews/012/811/968/original/sun-weather-sunset-sunrise-summer-line-and-glyph-web-button-in-blue-color-vertical-banner-for-ui-and-ux-website-or-mobile-application-free-vector.jpg',
                            // height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: RichText(
                                text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                  fontSize: 17.0,
                                  color: AppColors.apptheme,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(text: sunRise),
                              ],
                            )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: RichText(
                                text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(text: sunset),
                              ],
                            )),
                          ),
                        ],
                      )
                    ],
                  )
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  //   child: RichText(
                  //       text: TextSpan(
                  //     style: const TextStyle(
                  //         fontSize: 17.0,
                  //         color: AppColors.apptheme,
                  //         fontWeight: FontWeight.w500),
                  //     children: <TextSpan>[
                  //       TextSpan(text: 'SunSet: '),
                  //       TextSpan(
                  //           text: sunset.toString(),
                  //           style: const TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: Color.fromARGB(255, 67, 67, 67),
                  //               fontSize: 16.0))
                  //     ],
                  //   )),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  //   child: RichText(
                  //       text: TextSpan(
                  //     style: const TextStyle(
                  //         fontSize: 17.0,
                  //         color: AppColors.apptheme,
                  //         fontWeight: FontWeight.w500),
                  //     children: <TextSpan>[
                  //       TextSpan(text: 'SunRise: '),
                  //       TextSpan(
                  //           text: sunRise.toString(),
                  //           style: const TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: Color.fromARGB(255, 67, 67, 67),
                  //               fontSize: 16.0))
                  //     ],
                  //   )),
                  // ),

                  // const Padding(
                  //   padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  //   // padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     "Events",
                  //     style: TextStyle(
                  //         color: AppColors.apptheme,
                  //         fontSize: 17.0,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                ],
              ),
            ));
      });
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
