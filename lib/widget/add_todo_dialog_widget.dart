import 'package:flutter/material.dart';


class AddTodoDialogWidget extends StatefulWidget{
  const AddTodoDialogWidget({super.key});

  @override
  _AddTodoDialogWidgetState createState() =>_AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {const AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          Text("Add Todo" ,
          style:  TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
        SizedBox(
            height: 10),


      ],
    ),

  ); return const  AlertDialog();}
}


