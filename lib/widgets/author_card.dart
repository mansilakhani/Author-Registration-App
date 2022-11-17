import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';

Widget authorCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            doc["a_name"],
            style: AppStyle.mainTitle,
          ),
          // Text(
          //   "b_name",
          //   style: AppStyle.mainTitle,
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            doc["b_content"],
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
