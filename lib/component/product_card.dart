import 'package:flutter/material.dart';
import 'package:skmecom/utils/constants.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String oldPrice;
  final String newPrice;
  final String discount;

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.oldPrice,
    required this.newPrice,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: AppColors.primarycolor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
       elevation: 0,
      child: Container(
        height: 120,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: Image.asset(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        oldPrice,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        newPrice,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Column(
            //    mainAxisAlignment: MainAxisAlignment.end,
            //    crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     // if (discount.isNotEmpty)
            //     //   Container(
            //     //     padding:
            //     //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //     //     decoration: BoxDecoration(
            //     //       color: Colors.green,
            //     //       borderRadius: BorderRadius.circular(5),
            //     //     ),
            //     //     child: Text(
            //     //       discount,
            //     //       style: const TextStyle(
            //     //         color: Colors.white,
            //     //         fontSize: 12,
            //     //         fontWeight: FontWeight.bold,
            //     //       ),
            //     //     ),
            //     //   ),
            
               
               
            //   ],
            // ),

              
        
        
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                  //       if (discount.isNotEmpty) 
                  // Container(
                  //   // padding:
                  //   //     const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green,
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //     child: Text(
                  //       discount,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                 const  SizedBox(height: 40,),
               
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                                                      color:
                                                          AppColors.primarycolor.withOpacity(0.85),
                                                      backgroundBlendMode:
                                                          BlendMode.darken,
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(10),
                                                              topRight:
                                                                  Radius.circular(0),
                                                              bottomLeft:
                                                                  Radius.circular(0),
                                                              bottomRight:
                                                                  Radius.circular(10))),
                                                                  child: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.white,)),
                                  
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}