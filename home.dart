import 'package:flutter/material.dart';

import 'package:todo_application/constants/colors.dart';
import 'package:todo_application/widgets/ToDo-Item.dart';

import '../model/ToDo.dart';
class Home extends StatefulWidget {
  const Home({Key?key}) : super(key: key);

  @override

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> foundToDo = [];
final todoController  = TextEditingController();
@override
  void initState() {
   foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: 50,
                                    bottom: 20
                                ),
                                child: Text('All ToDos',
                                  style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight.w500,),
                                )
                            ),
                            for(ToDo todo in foundToDo.reversed)
                              ToDoItems(todo: todo,
                                onToDoChanged: _handleToDoChange,
                                onDeleteItems: _deleteToDoItem,


                              ),

                          ]
                      ),
                    )
                  ],
                )
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 20,
                                right: 20,
                                left: 20
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: TextField(
                              controller: todoController,
                              decoration: InputDecoration(
                                  hintText: 'Add a new todo item',
                                  border: InputBorder.none
                              ),
                            ),
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 20, right: 20
                        ),
                        child: ElevatedButton(

                          onPressed: () {
                           addToDoItem(todoController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tdBlue,
                            minimumSize: Size(60, 60),
                            elevation: 6,
                          ),

                          child: Text('+', style: TextStyle(fontSize: 40),),
                        ),
                      )
                    ]
                )
            ),
          ],
        )
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }
void addToDoItem(String todo){
    setState(() {
      todoList.add(ToDo(id:DateTime.now().millisecondsSinceEpoch.toString(),todoText:todo));
    });
  todoController.clear();
}
void runFilter(String enteredKeywords){
  List<ToDo> result = [];
  if(enteredKeywords.isEmpty){
    result = todoList;
  }else{
    result = todoList.where((item) => item.todoText!.toLowerCase().contains(enteredKeywords.toLowerCase())).toList();
  }
  setState(() {
    foundToDo = result;
  });
}
  Widget searchBox() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

        ),
        child: TextField(
          onChanged: (value) => runFilter(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,

            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
          ),
        )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,

        elevation: 0,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu, color: tdBlack, size: 30,
              ),
              SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/avator.jpg')

                  )
              )
            ]
        )
    );
  }
}








