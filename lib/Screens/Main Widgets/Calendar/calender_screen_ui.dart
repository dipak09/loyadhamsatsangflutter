// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
import 'package:loyadhamsatsang/Controllers/calander_controller.dart';
import 'package:loyadhamsatsang/Models/Calander.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomAppBar.dart';
import 'package:loyadhamsatsang/Screens/Custom%20Widgets/CustomText.dart';
import 'package:loyadhamsatsang/globals.dart';

class CalenderScreenUI extends StatefulWidget {
  DateTime currentMonth;
  CalenderScreenUI({Key? key, required this.currentMonth}) : super(key: key);

  @override
  State<CalenderScreenUI> createState() => _CalenderScreenUIState();
}

class _CalenderScreenUIState extends State<CalenderScreenUI> {
  late PageController _pageController;
  late CalanderController calanderController;

  //DateTime widget.currentMonth = DateTime.now();
  bool english = true;
  bool gujarati = false;
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    //_pageController = PageController(initialPage: DateTime.now().month - 1);
    //_pageController = PageController(initialPage: DateTime.now().month);
    _pageController = PageController(
      initialPage: widget.currentMonth.month -
          1 +
          (12 * (widget.currentMonth.year - DateTime.now().year)),
    );
    calanderController = Get.put(CalanderController());
    calanderController.startdate = null;
    calanderController.enddate = null;
    english = true;
    gujarati = false;
    log("currentDate${DateFormat('MMMM').format(widget.currentMonth)}");
  }

  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Calendar",
      ),
      body: Obx(
        () => calanderController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Language selection buttons
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
                            color: english ? AppColors.apptheme : Colors.white,
                            border: Border.all(
                              color:
                                  english ? AppColors.apptheme : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              "EN",
                              style: TextStyle(
                                color: english ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
                            color: gujarati ? AppColors.apptheme : Colors.white,
                            border: Border.all(
                              color:
                                  gujarati ? AppColors.apptheme : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              "GUJ",
                              style: TextStyle(
                                color: gujarati ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Header with month and year selection
                  _buildHeader(),
                  // Display the days of the week
                  _buildWeeks(),
                  // Display the calendar
                  // Expanded(
                  //   child: PageView.builder(
                  //     controller: _pageController,
                  //     onPageChanged: (index) {
                  //       setState(() {
                  //         widget.currentMonth = DateTime(
                  //             widget.currentMonth.year, (index % 12) + 1, 1);
                  //       });
                  //     },
                  //     itemCount: 12, // Show 10 years
                  //     itemBuilder: (context, pageIndex) {
                  //       print(pageIndex);
                  //       //DateTime month = DateTime(widget.currentMonth.year, (pageIndex % 12) + 1, 1);
                  //       return _buildCalendar(
                  //           widget.currentMonth, calanderController);
                  //     },
                  //   ),
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: 12,
                  //     scrollDirection: Axis.horizontal,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemBuilder: (context, index) {
                  //       return _buildCalendar(
                  //           widget.currentMonth, calanderController);
                  //     },
                  //   ),
                  // )
                  CarouselSlider.builder(
                    itemCount: 12,
                    carouselController: carouselSliderController,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        color: Colors.red,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: screenWidth(context),
                        child: Text(
                          index.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      aspectRatio: 0.7,
                      onPageChanged: (index, reason) {
                        Future.delayed(Duration(milliseconds: 600), () {
                          setState(() {
                            sliderIndex = index;
                            print('index::::$sliderIndex');
                          });
                        });
                      },
                      scrollPhysics: sliderIndex > 0
                          ? null
                          : OneDirectionScrollPhysics(allowLeftToRight: false),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Build the header with month and year selection
  Widget _buildHeader() {
    bool isLastMonthOfYear = widget.currentMonth.month == 12;
    bool isFirstMonthOfYear = widget.currentMonth.month == 1;
    print("Last Month:::$isLastMonthOfYear");
    print("Last Month:::$isFirstMonthOfYear");
    // print("Last Month:::${_pageController.page}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // if (_pageController.page! > 0 && !isFirstMonthOfYear) {
              //   _pageController.previousPage(
              //     duration: Duration(milliseconds: 300),
              //     curve: Curves.easeInOut,
              //   );
              // }
              if (sliderIndex > 0) {
                // setState(()
                carouselSliderController.previousPage();
              }
              // });
            },
          ),
          Text(
            DateFormat('MMMM').format(widget.currentMonth),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<int>(
            value: widget.currentMonth.year,
            onChanged: (int? year) {
              if (year != null) {
                // setState(() {
                //   widget.currentMonth = DateTime(year, widget.currentMonth.month, 1);
                //     calanderController.enddate = "${widget.currentMonth.year}-12-31";
                //     calanderController.startdate = "${widget.currentMonth.year}-01-01";
                //     calanderController.getData("${widget.currentMonth.year}-01-01", "${widget.currentMonth.year}-12-31");
                //   _pageController.jumpToPage((widget.currentMonth.month - 1) + (12 * (year - DateTime.now().year)));
                // });
                // log("year1${widget.currentMonth.month}");
                // log("year1${(widget.currentMonth.month - 1) + (12 * (year - DateTime.now().year))}");
                setState(() {
                  widget.currentMonth = DateTime(year, 1, 1);
                  calanderController.enddate = "$year-12-31";
                  calanderController.startdate = "$year-01-01";
                  calanderController.getData("$year-01-01", "$year-12-31");

                  int yearDiff = DateTime.now().year - year;
                  int monthIndex =
                      12 * yearDiff + widget.currentMonth.month - 1;
                  log("monthIndex${monthIndex}");
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
              // print('::::::::::${_pageController.page}');
              // carouselSliderController.jumpToPage(2);
              if (sliderIndex < 11) {
                carouselSliderController.nextPage();
              }
              // setState(() {});
              // if (!isLastMonthsOfYear) {
              //   setState(() {
              //     _pageController.nextPage(
              //       duration: Duration(milliseconds: 300),
              //       curve: Curves.easeInOut,
              //     );
              //   });
              // }
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

  Widget _buildEventItem(CalenderEvent event, String monthDate) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
      child: ListTile(
        leading: event.icon != null
            ? Image.network(
                event.icon!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
            : Image.asset(
                "assets/images/favicon.png",
                width: 40,
                height: 40,
              ),
        // Placeholder if icon is null
        title: Text(
          gujarati
              ? event.vratUtsavNameGuj.toString()
              : event.vratUtsavNameEng.toString(),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          monthDate,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        onTap: () {
          // Handle event tap
          // Add your logic here
        },
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
    log("Month${month}");
    log("Month calendar${calendar}");
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    log("daysInMonth${DateTime(month.year, month.month + 1, 0).day}");

    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay =
        firstDayOfMonth.weekday; // Get weekday of the first day

    // Calculate the last day of the previous month
    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;
    log("itemCount${daysInMonth + weekdayOfFirstDay - 1}");
    log("itemCount${daysInMonth + weekdayOfFirstDay - 1}");
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: (daysInMonth + weekdayOfFirstDay - 1) == 36 ||
                    (daysInMonth + weekdayOfFirstDay - 1) == 37
                ? 577
                : 500,
            width: screenWidth(context),
            color: Colors.red,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.6,
              ),
              itemCount: daysInMonth + weekdayOfFirstDay - 1,
              itemBuilder: (context, index) {
                print('object:::::${daysInMonth + weekdayOfFirstDay - 1}');
                if (index < weekdayOfFirstDay - 1) {
                  // Show dates from the previous month in grey
                  int previousMonthDay =
                      daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
                  DateTime date = DateTime(
                      month.year, month.month, index - weekdayOfFirstDay + 2);

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide.none,
                        // Remove top line
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        // Example: left border
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        // Example: right border
                        bottom: BorderSide(
                            width: 1.0,
                            color: Colors.grey), // Example: bottom border
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      previousMonthDay.toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                } else {
                  DateTime date = DateTime(
                      month.year, month.month, index - weekdayOfFirstDay + 2);
                  String text = date.day.toString(); // Day number text
                  bool isCurrentDate = DateTime.now().isSameDate(date);
                  Calender? currentDateData = calendar.list.firstWhere(
                    (element) => DateTime.parse(element.icDate!.toString())
                        .isSameDate(date),
                    orElse: () => Calender(),
                  );
                  bool hasEvents = currentDateData.calenderEvent != null &&
                      currentDateData.calenderEvent!.isNotEmpty;

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
                          currentDateData.calenderEvent,
                          calendar);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: const Border(
                          top: BorderSide.none,
                          // Remove top line
                          left: BorderSide(width: 1.0, color: Colors.grey),
                          // Example: left border
                          right: BorderSide(width: 1.0, color: Colors.grey),
                          // Example: right border
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey), // Example: bottom border
                        ),
                        color: isCurrentDate
                            ? AppColors.apptheme
                            : hasEvents
                                ? Colors.grey.withOpacity(0.3)
                                : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
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

                          // if (currentDateData.calenderEvent!.isEmpty)
                          //   const Expanded(
                          //     flex: 0,
                          //     child: SizedBox(
                          //       width: 40,
                          //       height: 40,
                          //     ),
                          //   ),

                          if (currentDateData.calenderEvent!.isNotEmpty)
                            if (currentDateData.calenderEvent![0].icon != null)
                              Expanded(
                                flex: 0,
                                child: SizedBox(
                                  child: Image.network(
                                    currentDateData.calenderEvent![0].icon
                                        .toString(),
                                    // Replace with your image URL
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          // if (currentDateData.calenderEvent!.isNotEmpty)
                          //   if (currentDateData.calenderEvent![0].icon == null)
                          //     const Expanded(
                          //       flex: 0,
                          //       child: SizedBox(
                          //         width: 40,
                          //         height: 40,
                          //       ),
                          //     ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, right: 3.0),
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
                                                : Color.fromARGB(
                                                    255, 127, 126, 126)),
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
                                                : Color.fromARGB(
                                                    255, 127, 126, 126)),
                                      )),
                          ),
                          // Display the month title
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (calendar.list.isNotEmpty)
            Container(
              //height: 200,
              width: screenWidth(context),
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                      'Calender Events',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: AppColors.apptheme,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: calendar.list.length,
                    itemBuilder: (context, index) {
                      Calender monthData = calendar.list[index];
                      DateTime monthDate = DateTime.parse(monthData.icDate!);
                      String formattedDate =
                          DateFormat('dd-MMM-yyyy').format(monthDate);
                      if (DateTime.parse(monthData.icDate!).year ==
                              month.year &&
                          DateTime.parse(monthData.icDate!).month ==
                              month.month) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: monthData.calenderEvent!
                              .map((event) =>
                                  _buildEventItem(event, formattedDate))
                              .toList(),
                        );
                      } else {
                        return SizedBox(); // Return an empty container for months without events
                      }
                    },
                  ),
                ],
              ),
            ),
          if (calendar.list
              .where((monthData) =>
                  DateTime.parse(monthData.icDate!).year == month.year &&
                  DateTime.parse(monthData.icDate!).month == month.month)
              .every((monthData) => monthData.calenderEvent!.isEmpty))
            Container(
              //height: 100,
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No events for this month',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

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
  List<CalenderEvent>? calenderEvent,
  CalanderController calendar,
) async {
  var aplhaMonth = DateFormat.MMMM().format(DateTime(2000, month));

  // Calculate the height needed for the events section
  double eventsHeight =
      calenderEvent!.isEmpty ? 0.0 : calenderEvent.length * 20.0;
  log("eventsHeight${eventsHeight}");

  // Calculate the total height needed for the dialog
  double totalHeight = calenderEvent.isEmpty
      ? 150.0
      : 250.0 + eventsHeight; // 250.0 is the initial height

  // Show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
          height: totalHeight,
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
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            aplhaMonth.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          year,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 10.0),
                      child: gujSelect
                          ? Text(
                              "${month_title_guj} ${paksha_title_guj} ${tithi_titl_eGuj}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "${monttitle} ${pakshaTitle} ${tithiTitle}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: calenderEvent.map((event) {
                      return Text(
                        event.vratUtsavNameEng.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class OneDirectionScrollPhysics extends ScrollPhysics {
  final bool
      allowLeftToRight; // Determines if left-to-right scrolling is allowed

  OneDirectionScrollPhysics(
      {this.allowLeftToRight = true, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  OneDirectionScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OneDirectionScrollPhysics(
        allowLeftToRight: allowLeftToRight, parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (!allowLeftToRight && value < position.pixels) {
      return value - position.pixels; // Prevent left-to-right scroll
    }
    return super.applyBoundaryConditions(position, value);
  }
}
