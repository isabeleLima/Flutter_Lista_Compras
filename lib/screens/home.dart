import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/cart.dart';
import '../widgets/to_do_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final itemList = Cart.itemList();
  final _itemName = TextEditingController();
  final _itemQTD = TextEditingController();


  List<Cart> _foundItem = [];

  void initState() {
    _foundItem = itemList;
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child:Column(children: [
                searchBox(),
                Expanded(child:
                ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top:50,bottom: 20),
                      child: const Text('Lista de compras', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),),
                    ),
                    for ( Cart cart in _foundItem)
                      Item(cart: cart,onToDoChange: _handleToDoChange,onDeleteItem:_deleteToDoItem ,),
                    
                  ],
                ),
                ),
              ],)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 0,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  TextField(
                    controller: _itemName,
                    decoration: InputDecoration(
                        hintText: 'Item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 50,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  TextField(
                    controller: _itemQTD,
                    decoration: InputDecoration(
                        hintText: 'QTD',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _addToDoItem(_itemName.text, _itemQTD.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget searchBox(){
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child:  TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color:tdBlack, size:20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Buscar',
            hintStyle: TextStyle(color:tdGrey)
        ),
      ),
    );
  }

  void _deleteToDoItem(String id){
    setState(() {
      itemList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String item, String qtd){
    setState(() {
      itemList.add(Cart(id:DateTime.now().millisecondsSinceEpoch.toString(), text: item, amount: qtd));
    });
    _itemName.clear();
    _itemQTD.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Cart> results = [];
    if (enteredKeyword.isEmpty) {
      results = itemList;
    } else {
      results = itemList
          .where((item) => item.text!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundItem = results;
    });
  }
  void _handleToDoChange(Cart todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}