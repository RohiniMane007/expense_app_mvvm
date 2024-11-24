import 'package:flutter/material.dart';

import '../../../../core/utils/custom_textstyle.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.image,
      required this.category,
      required this.description,
      required this.amount,
      required this.date});
  final String image, category, description, amount, date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.teal,
      color: Colors.white,
      margin: const EdgeInsets.only(right: 10, left: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.only(right: 10),
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 35,
                height: 35,
                child: CircleAvatar(
                  // backgroundColor: Colors.teal,
                  child: Image.asset(image),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      category,
                      style: CustomTextStyle.titleTextStyle(fontsize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 50,
                      child: Text(description,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.subTextStyle(
                              fontstyle: FontStyle.normal)),
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: Text(
                    "\u20B9${double.parse(amount).toStringAsFixed(2)}",
                    style: CustomTextStyle.titleTextStyle(
                        color: Colors.deepOrange),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Text(
                    date,
                    style: CustomTextStyle.subTextStyle(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
