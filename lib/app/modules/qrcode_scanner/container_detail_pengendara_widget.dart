import 'package:flutter/material.dart';

class ContainerDetailPengendara extends StatelessWidget {
  final String title;
  final String middleText;
  const ContainerDetailPengendara(
      {Key? key, required this.title, required this.middleText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            middleText,
            style: const TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }
}
