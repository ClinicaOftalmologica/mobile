import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/reservation.dart';
import '../services/reservation_service.dart';

class MLReservationsScreen extends StatefulWidget {
  static String tag = '/MLReservationsScreen';

  @override
  State<MLReservationsScreen> createState() => _MLReservationsScreenState();
}

class _MLReservationsScreenState extends State<MLReservationsScreen> {
  ReservationService reservationService = ReservationService();

  List<Reservation> reservations = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      reservations = (await reservationService.getReservations())!;
    } catch (e) {
      if (e.toString().contains('Unauthorized access detected.')) {
        toast('Sesión expirada');
        finish(context);
        Navigator.pushNamed(context, '/login');
      }
    }

    setState(() {});
  }

  //dispose
  @override
  void dispose() {
    super.dispose();
  }

  void cancelReservation(String id) async {
    bool request = await reservationService.cancelReservation(id: id);
    if (request) {
      init();
    } else {
      toast('Error al cancelar la reserva');
    }
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
            children: reservations.map(
              (e) {
                return Container(
                  width: context.width(),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Doctor: ${e.timetable!.doctor!.name!}",
                          style: boldTextStyle(size: 16)),
                      8.height,
                      Text(e.place!, style: secondaryTextStyle()),
                      8.height,
                      Text(e.timetable!.Date.toString().substring(0, 10),
                          style: secondaryTextStyle()),
                      8.height,
                      Text(e.state, style: secondaryTextStyle()),
                      8.height,
                      Text(
                          'Hora: ${e.timetable?.Time.toString().substring(0, 5)}',
                          style: secondaryTextStyle()),
                      //Cancelar
                      if (e.state == 'PENDIENTE')
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Cancelar',
                                    style: TextStyle(color: Colors.white))
                                .onTap(() {
                              cancelReservation(e.id!);
                            }),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
