import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase/data/model/record.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class FirebaseController extends GetxController {
  var _records = <Record>[].obs;

  List<Record> get entries => _records;

  //Implementa los getters necesarios para los datos y el stream

  final CollectionReference baby =
      FirebaseFirestore.instance.collection('baby');

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('baby').snapshots();

  @override
  void onInit() {
    suscribeUpdates();
    super.onInit();
  }

  //Implementa el metodo para suscribirse a cambios en lo datos
  suscribeUpdates() async {
    logInfo('suscribeLocatioUpdates');
    _usersStream.listen((event) {
      logInfo(' agregar nuevo item de firestore');
      _records.clear();
      event.docs.forEach((element) {  
        _records.add(Record.fromSnapshot(element));
      });
      print('obtener ${_records.length}');
    });
  }

  //Implementa el metodo para agregar datos en firestore
  addEntry(name) {
    baby
        .add({'name': name, 'votes': 0})
        .then((value) => print('bebe agregado de forma correcta'))
        .catchError(
            (onError) => print('ha fallado el ingreso de bebe  $onError'));
  }
}
