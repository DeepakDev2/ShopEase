import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {

    // temporary list for testing purpose,
    List list= [
      "https://images.unsplash.com/photo-1732647169576-49abfdef3348?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyNDl8fHxlbnwwfHx8fHw%3D",
      "https://images.unsplash.com/photo-1732647169576-49abfdef3348?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyNDl8fHxlbnwwfHx8fHw%3D",
      "https://images.unsplash.com/photo-1732647169576-49abfdef3348?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyNDl8fHxlbnwwfHx8fHw%3D",
      "https://images.unsplash.com/photo-1732647169576-49abfdef3348?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyNDl8fHxlbnwwfHx8fHw%3D",
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15,),
              child: const Text("Your Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15,),
              child: Text("See all",style: TextStyle(color: GlobalVariables.selectedNavBarColor),),
            ),
          ],
        ),
        // display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10,top: 20,right: 0,),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context,index){
              return SingleProduct(image: list[index]);
            },
          ),
        ),
      ],
    );
  }
}