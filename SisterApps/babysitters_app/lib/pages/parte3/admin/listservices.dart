
import 'package:babysitters_app/pages/parte3/admin/homeadmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';



//import 'package:nani/utils/colors.dart' as utils;

class ListServicePage extends StatefulWidget {
  @override
  _ListServicePageState createState() => _ListServicePageState();
}

class _ListServicePageState extends State<ListServicePage> {
 // adminControllerInit con = adminControllerInit();
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  bool _activo = false;
  
  bool searchState = false;
  final CollectionReference _nanis =
      FirebaseFirestore.instance.collection("serviciosdisponibles");

  @override
  void initState() {
    // TODo implement initState
    super.initState();

    //readData();
  }

  @override
  void dispose() {
    super.dispose();
    
  }

  Widget appBarTitle = Text(
    "Buscar ",
    style: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'omegle',
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    ('metodo build');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade50,
        title: !searchState
            ? Text(
                "Servicios",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'omegle',
                ),
              )
            : TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Buscar...",
                    hintStyle: TextStyle(color: Colors.black)),
                onChanged: (text) {
                 
                },
              ),
        actions: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GestureDetector(
              onTap: () {
                
              },
              child: Icon(
                Icons.search_outlined,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => (homeAdmin())),
              );
            },
            child: const Text(
              'Atras',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'omegle',
              ),
            ),
          ),
        ],
        shadowColor: Colors.amberAccent,
      ),
      body: StreamBuilder(
          stream: _nanis.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                  return Card(
                    color: Colors.pink.shade50,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        
                            'Descripción:\n\n' +
                            documentSnapshot['descripcion'] +
                            '\n\n' +
                           'Cantidad Niños:\n\n' +
                            documentSnapshot['c_ninos'] +
                            '\n\n'+
                            'Precio Dia:\n\n' +
                            documentSnapshot['precio_hora_dia'].toString() +
                            '\n\n'+
                            'Precio Noche:\n\n' +
                            documentSnapshot['precio_hora_noche'].toString() +
                            '\n\n'
                          
                            
                           
                            ,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: Text('Nombre:' + documentSnapshot['nombre']),
                      leading: Card(
                        
                        elevation: 5,
                        color: Colors.pink.shade50,
                        child: CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: 
                                 AssetImage(
                                    'assets/img/campana.gif')),
                      ),
                     
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }





  void _showAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                  _activo ? "Desactivar Servicio" : "Activar este servicio"),
              content: Text(_activo
                  ? "Cancelar Servicio,¿Seguro?"
                  : "Activar Servicio,¿Seguro?"),
              actions: [
                TextButton(
                    onPressed: () {
                      ("No");

                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar")),
                TextButton(
                    onPressed: () {
                      ("Activar");
                      setState(() {
                        _activo = !_activo;
                      });

                      Navigator.pop(context);
                    },
                    child: Text(_activo ? "Desactivar" : "Activar"))
              ],
            ));
  }

  Widget bannerApp() {
    //metodo para invocar la parte superior
    return ClipPath(
      //Fondo de los iconos
      clipper: WaveClipperOne(),
      child: Container(
        color: Colors.blue.shade50,
        height: MediaQuery.of(context).size.height * 0.30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/img/ninos.gif',
              width: 250,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }


}


