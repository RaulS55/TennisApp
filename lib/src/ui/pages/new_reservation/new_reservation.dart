import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/src/data/models/weather.dart';
import 'package:tenis_app/src/ui/pages/home/home_controller.dart';
import 'package:tenis_app/src/ui/pages/new_reservation/widgets/custom_combo_box.dart';
import 'package:tenis_app/src/ui/pages/new_reservation/widgets/custom_datepicker.dart';
import 'package:tenis_app/src/ui/pages/new_reservation/reservation_controller.dart';
import 'package:tenis_app/src/ui/pages/new_reservation/widgets/custom_weather.dart';
import 'package:tenis_app/src/ui/util/global_functions.dart';
import 'package:tenis_app/src/ui/util/responsive.dart';
import 'package:tenis_app/src/ui/widgets/custom_buton.dart';
import 'package:tenis_app/src/ui/widgets/dialogs/error_dialog.dart';
import 'package:tenis_app/src/ui/widgets/dialogs/success_dialog.dart';
import 'package:tenis_app/src/ui/widgets/loading/custom_loading.dart';
import 'package:tenis_app/src/ui/widgets/loading/custom_loading_controller.dart';

// ignore: must_be_immutable
class NewReservationPage extends StatelessWidget {
  NewReservationPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  DateTime? _date;
  String name = "Cancha A";
  final style = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey.shade700);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return ChangeNotifierProvider(
      create: (context) => ReservationController(),
      builder: (context, child) {
        final controller =
            Provider.of<ReservationController>(context, listen: false);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Nuevo alquiler",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            elevation: 1,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //NOMBRE
                      SizedBox(height: responsive.hp(2)),
                      Text("Nombre:", style: style),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nombre"),
                          )),

                      //SELECCIONAR CANCHA
                      SizedBox(height: responsive.hp(2)),
                      Text("Seleccione la cancha:", style: style),
                      ComboBox(
                        list: const ["Cancha A", "Cancha B", "Cancha C"],
                        onChanged: (value) {
                          name = value!;
                        },
                      ),

                      //SELECCIONAR FECHA
                      SizedBox(height: responsive.hp(2)),
                      Text("Seleccione fecha:", style: style),
                      MyDatePicker(
                        date: (date) {
                          _date = date!;
                        },
                      ),

                      //PRECIPITACION
                      SizedBox(height: responsive.hp(2)),
                      Text("Probabilidad de lluvia:", style: style),
                      Selector<ReservationController, Weather?>(
                        selector: (_, c) => c.weather,
                        builder: (context, weather, child) =>
                            ValueListenableBuilder(
                                valueListenable: LoadingWidgetController
                                    .instance.loadingNotifier,
                                builder: (context, bool value, Widget? child) {
                                  return value
                                      ? const CustomLoading()
                                      : weather != null
                                          ? CustomWeather(
                                              weather:
                                                  weather.days[0].precipprob)
                                          : SizedBox(height: responsive.hp(5));
                                }),
                      ),

                      //GUARDAR
                      SizedBox(height: responsive.hp(30)),
                      CustomButton(onPressed: () async {
                        if (!LoadingWidgetController.instance.loadingValue()) {
                          if (nameController.text.isNotEmpty &&
                              _date != null &&
                              controller.weather != null) {
                            final ok = await Provider.of<HomeController>(
                                    context,
                                    listen: false)
                                .newTennisCourt(name, nameController.text,
                                    _date!, controller.precipprob);
                            if (ok) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const SuccessDialog());
                            } else {
                              formatDate(_date!);
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorDialog(
                                      name: name, day: formatDate(_date!)));
                            }
                          }
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
