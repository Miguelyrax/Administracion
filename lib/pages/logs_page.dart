import 'package:administracion/model/log_model.dart';
import 'package:administracion/services/logs_service.dart';
import 'package:administracion/widgets/alert.dart';
import 'package:administracion/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class LogsPage extends StatefulWidget {

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final txtContoller = TextEditingController();
  final log = LogsService();
  Color color1 = Color(0xff1B1464);
  Color color2 = Color(0xff0652DD);
  List<Log> logs = [];

  @override
    void initState() {
     this.getLogs();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return 
   Scaffold(
      body: Stack(
        children: [
         
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.only(top: 300),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: DataTable(
               sortColumnIndex: 1,
               sortAscending: true,
                columns: [
                  DataColumn(label: Text('Usuario')),
                  DataColumn(label: Text('Log')),
                  DataColumn(label: Text('Fecha')),
                ],
                rows: 
                  List<DataRow>.generate(
                    logs.length, (index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      // All rows will have the same selected color.
                      if (states.contains(MaterialState.selected))
                        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                      // Even rows will have a grey color.
                      if (index.isEven) {
                        return Colors.grey.withOpacity(0.3);
                      }
                      return null;  // Use default value for other states and odd rows.
                      })
                      ,cells: [
                      DataCell(Text(logs[index].usuario.nombre)),
                      DataCell(Text(logs[index].log)),
                      DataCell(Text('${logs[index].createdAt.day}/${logs[index].createdAt.month}'))
                      
                      ],))
                ,
              ),
            )
          ),
          Header(
          color1:color1 , titulo: 'Logs', color2:color2 , icono: FontAwesomeIcons.book,
        ),
        
      
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.plus),
        onPressed: ()=>alertLog(context,txtContoller,getLogs),
        backgroundColor: color2,
      ),
   );
  }

  void getLogs()async {
    this.logs =await log.logs();
    setState(() {
          
        }); 
  }


  
}