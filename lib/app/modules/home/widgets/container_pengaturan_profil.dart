import 'package:flutter/material.dart';

class ContainerPengaturanProfil extends StatelessWidget {
  final String title;
  final String middleText;
  const ContainerPengaturanProfil(
      {Key? key, required this.title, required this.middleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const Text(' : '),
          Flexible(
            child: Text(
              middleText,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
