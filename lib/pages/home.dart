import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String userToDo ;
  List todoList = [];



  void initFireBase() async{
    WidgetsFlutterBinding.ensureInitialized();


    await Firebase.initializeApp();
  }


@override
  void initState(){
  super.initState();
  initFireBase() ;
  todoList.addAll(['Buy Milk', 'Wash dishes', 'Купить картошку']);
}

void _menuOpen(){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text('Меню'),),
        body: Row(
          children: [
            ElevatedButton(onPressed:  (){
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil( context, '/', (route) => false);
            }, child: Text('На главную')),
            Padding(padding: EdgeInsets.only (left: 15) ),
            Text('Наше простое меню')
          ],
        )
      );
    })
  );
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900] ,
       appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
         actions: [
           IconButton(
             icon: Icon(Icons.menu_outlined ),
             onPressed: _menuOpen,
           )
         ],
      ),
        body: ListView.builder(
          itemCount: todoList.length ,
            itemBuilder: (BuildContext context, int index){
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                      title: Text(todoList[index]),
                  trailing: IconButton(

                    icon: Icon (
                      Icons.delete_sweep,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      setState(() {
                        todoList.removeAt( index);
                      });
                    },
                  ),
                  ),
              ),
              onDismissed: (direction) {
                  //if(direction == DismissDirection.endToStart )
                setState(() {
                  todoList.removeAt( index);
                });
              },
            );
            }
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(context: context , builder:(BuildContext context) {
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value){
                  userToDo = value;
                },
              ),
              actions: [

                ElevatedButton(onPressed: () {
                  setState(() {
                    todoList.add(userToDo);
                  });
                  Navigator.of(context).pop();
                } , child: Text('Добавить'))
              ],

            );
          });

        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        )
      ),
    );
  }
}
