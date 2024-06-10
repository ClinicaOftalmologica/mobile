import 'package:flutter/material.dart';
import 'package:medilab_prokit/services/reservation_service.dart';
import 'package:medilab_prokit/services/timetable_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLAppointmentData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLString.dart';
import 'package:medilab_prokit/model/timetable.dart';

import '../main.dart';

class MLAppointmentDetailListComponent extends StatefulWidget {
  static String tag = '/MLAppointmentDetailListComponent';

  @override
  MLAppointmentDetailListComponentState createState() =>
      MLAppointmentDetailListComponentState();
}

class MLAppointmentDetailListComponentState
    extends State<MLAppointmentDetailListComponent> {
  List<MLAppointmentData> data = mlAppointmentDataList();

  TimetableService timetableService = TimetableService();
  ReservationService reservationService = ReservationService();
  List<Timetable> timetable = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    timetableService.getTimetable().then((value) {
      setState(() {
        timetable = value!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Column(
            children: timetable.map(
              (e) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: appStore.isDarkModeOn
                            ? scaffoldDarkColor
                            : Colors.grey.shade50,
                        borderRadius: radius(12),
                      ),
                      child: Column(
                        children: [
                          20.height,
                          Row(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: mlColorDarkBlue,
                                  borderRadius: radius(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text((e.Date.toString().substring(8, 10)),
                                        style: boldTextStyle(
                                            size: 32, color: white)),
                                    Text((e.Date.toString().substring(0, 3)),
                                        style:
                                            secondaryTextStyle(color: white)),
                                  ],
                                ),
                              ),
                              8.width,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text((e.Date.toString().substring(0, 3)),
                                          style: boldTextStyle(size: 18)),
                                      8.height,
                                      Text(
                                          ('Doctor: ${e.doctor!.name} ${e.doctor!.lastName}')
                                              .validate(),
                                          style: secondaryTextStyle()),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: Colors.transparent,
                                      borderRadius: radius(30),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.1)),
                                    ),
                                    child: const Icon(
                                      Icons.notifications_none,
                                    ),
                                  ).paddingBottom(16.0)
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          8.height,
                          const Divider(thickness: 0.5),
                          8.height,
                          Row(
                            children: [
                              Text((e.Time.toString()),
                                  style: boldTextStyle(color: mlColorDarkBlue)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(mlSave_reservation!,
                                      style: secondaryTextStyle(
                                          color: mlColorDarkBlue)),
                                  4.width,
                                  Icon(Icons.arrow_forward,
                                      color: mlPrimaryColor, size: 16),
                                ],
                              ).onTap(
                                () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Confirm Reservation'),
                                        content: const Text(
                                            'Quieres confirmar la reservación?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Cierra el diálogo
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              _confirmReservation(e.id);
                                            },
                                            child: const Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ).expand()
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          16.height,
                        ],
                      ),
                    ).paddingBottom(16.0),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReservation(String? idTimeTable) async {
    try {
      final response = await reservationService.createReservation(
        idTimeTable: idTimeTable!,
      );
      if (response != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reservation confirmed!')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error confirming reservation')),
        );
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error confirming reservation')),
        );
      }
    }
  }
}
