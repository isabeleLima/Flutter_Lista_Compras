import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/cart.dart';

class Item extends StatelessWidget {
  final Cart cart;
  final onToDoChange;
  final onDeleteItem;

  const Item({super.key, required this.cart, this.onToDoChange, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          onToDoChange(cart);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          cart.isDone? Icons.check_box : Icons.check_box_outline_blank,
           color:tdBlue,
        ),
        title: Text(
          cart.text!,
          style: TextStyle(
            fontSize: 16,
            color:tdBlack,
            decoration: cart.isDone? TextDecoration.lineThrough: null,),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(children: [
            Container(
                padding: const EdgeInsets.all(0),
                height: 20,
                width: 40,

                child: Text(
                cart.amount!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold
                )
            )),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              height: 35,
              width: 35,

              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(cart.id);
                },
              )
            )
          ]),
        ),
      ),
    );
  }

}