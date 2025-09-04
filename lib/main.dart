import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

late CloudinaryObject cloudinary;

/*
LISTA REPRODUCCION
https://www.youtube.com/playlist?list=PLkVpKYNT_U9frI8-qia9vN3k-V7huavBB

10) https://www.youtube.com/watch?v=EWFcxoNrRGY - Imagenes
11) https://www.youtube.com/watch?v=eBIWYzktK1U&list=PLkVpKYNT_U9frI8-qia9vN3k-V7huavBB&index=23 - Texto
    - fonts.google.com/specimen/Fruktur (11:27)
    - Fuentes online: https://pub.dev/packages/google_fonts/install
12) https://www.youtube.com/watch?v=FlqzZmwzlPs&list=PLkVpKYNT_U9frI8-qia9vN3k-V7huavBB&index=24
      
*/

/*
void main() { 
  cloudinary = CloudinaryObject.fromCloudName(
    cloudName: dotenv.env['CLOUD_NAME']!
    );

  runApp(MyApp()); 
}
*/

Future<void> main() async {

  // Necesario para inicializaciones antes de runApp()
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "dev.env");//nombre archivo

  cloudinary = CloudinaryObject.fromCloudName(
    cloudName: dotenv.env['CLOUD_NAME']!,
    );

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Imagenes App',
      debugShowCheckedModeBanner: false,//desaparece el cartel 'debug' en el angulo superior derecho.
      home: MyHomePage(title: 'Imagenes'),
    );
  }
}

class MyHomePage extends StatefulWidget{
 MyHomePage({Key? key, this.title}):super(key:key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage>{
  
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("${widget.title}", 
        style: TextStyle(color: Colors.white,),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Material Icon: ', 
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Icon(
                  Icons.home,
                  color: Colors.deepPurple,
                  size: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Cupertino Icon: ', 
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Icon(
                  CupertinoIcons.home,
                  color: Colors.indigo,
                  size: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'FontAwesome Icono: ', 
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Icon(
                  FontAwesomeIcons.house,
                  color: Colors.blueGrey,
                  size: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/CocineraColor.jpg',
                  width: 250,
                  ),
              ],
            ),
            /* INICIO CORTE */
            Padding(padding: EdgeInsets.all(10)),// separa las imagenes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  // si no levanta la imagen desde la web, paramos el proyecto y en la terminal 
                  // ponemos " flutter run -d chrome --no-sound-null-safety --web-renderer=html"
                  // eso renderiza la pagina de la que tomamos la imagen y la carga,
                  // con el emulador no hace falta
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCBNjE5HAnkdh3TIXkz2PqoE-dkdMgBEMATw&s',
                  width: 250,
                  ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),
            // cloudinary
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 140,
                  child: CldImageWidget(
                  cloudinary: cloudinary,
                  publicId: "bzmro1shx1cuavvvek07.jpg",
                ),
              ),]
            ),
            /* FIN CORTE */
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width / 1.2, //anchura del dispositivo
              color: Colors.black,
              child: const Text(
                '1 Este es un texto cualquiera',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Fruktur'
                ),
                textAlign: TextAlign.left,
                //TextOverflow.clip: cuando el contenedor se queda sin espacio, corta el texto.
                //TextOverflow.elipsis: corta el texto y le agrega 3 puntos(...)
                //TextOverflow.fade: se disfumina el texto que no entra.
                //TextOverflow.visible: se ve el texto fuera del container.
                overflow: TextOverflow.visible, 
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              'Letras con Google fonts',
              style: GoogleFonts.pacifico(
                color: Colors.purple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}