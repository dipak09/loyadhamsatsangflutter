import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';
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
  var Calander = Get.put(CalanderController());

  final kToday = DateTime.now();
  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 10, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 10, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Calendar"),
      body: Obx(() => Calander.isLoading.value
          ? SizedBox.shrink()
          : SfCalendar(
              appointmentTextStyle: TextStyle(
                color: AppColors.apptheme,
                fontSize: 7,
              ),
              view: CalendarView.month,
              dataSource: _getCalendarDataSource(),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayCount: 5,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
            )),
    );
  }

  _DataSource _getCalendarDataSource() {
    List<Appointment> appointments = [];

    for (CalenderData data in Calander.list) {
      if (data.icDate != null) {
        print("Data for ${data.icDate}: ${data.tithiTitleEng}");
        // Create an appointment for each CalenderData item
        appointments.add(Appointment(
          startTime: data.icDate!,
          color: Colors.transparent,
          endTime: data.icDate!,
          subject:
              "${data.monthTitleEng}${data.pakshaTitleEng}${data.tithiTitleEng}", // Replace with your data
          notes: data.descriptionGuj ?? "Description", // Replace with your data
          isAllDay: true,
        ));
      }
    }

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
