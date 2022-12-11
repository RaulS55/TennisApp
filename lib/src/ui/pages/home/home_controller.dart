import 'package:flutter/cupertino.dart';
import 'package:tenis_app/src/data/database/database.dart';
import 'package:tenis_app/src/data/models/tennis_court.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    _getReservations();
  }

  List<TennisCourt> _reservations = [];

  List<TennisCourt> get reservations => _reservations;

  //BUSCAR RESERVA
  Future<int> _readReservation(DateTime date, String name) async {
    final lab = await MyDataBase.instance.readList(date, name);
    return lab.length;
  }

  //OBTENER TODAS LAS RESERVAS
  Future _getReservations() async {
    _reservations = await MyDataBase.instance.readAll();
    notifyListeners();
  }

  //Borrar una reserva
  Future deleteReservation(int id) async {
    await MyDataBase.instance.delete(id);
    _getReservations();
  }

  //AGREGAR UNA NUEVA RESERVA
  Future<bool> newTennisCourt(
      String name, String userName, DateTime date, double precipprob) async {
    final newTennisCourt = TennisCourt(
        precipprob: precipprob, name: name, userName: userName, dateTime: date);
    final cant = await _readReservation(date, name);
    if (cant <= 2) {
      await MyDataBase.instance.create(newTennisCourt);
      _getReservations();
      return true;
    } else {
      return false;
    }
  }
}
