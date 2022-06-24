import 'package:flutter/material.dart';

class UserInfoPanel extends StatelessWidget {
  final String nameUser;
  final String levelUser;
  const UserInfoPanel(
      {Key? key, required this.nameUser, required this.levelUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(color: Colors.blue),
        ),
        Row(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  color: Colors.white,
                  height: 80,
                  width: 80,
                  child: const Icon(
                    Icons.local_parking,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameUser.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.orange,
                            child: Text(
                              levelUser.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Container(
        //   margin: const EdgeInsets.only(top: 50),
        //   child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Container(
        //           width: MediaQuery.of(context).size.width * 0.3,
        //           child: Container(
        //             color: Colors.white,
        //             height: 80,
        //             width: 80,
        //             child: const Icon(
        //               Icons.local_parking,
        //               size: 60,
        //               color: Colors.blue,
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 30,
        //         ),
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Text(
        //               'NAMA PENGGUNA',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               height: 10,
        //             ),
        //             Container(
        //               padding: EdgeInsets.all(5),
        //               color: Colors.orange,
        //               child: Text(
        //                 'LEVEL AKUN',
        //                 style: TextStyle(
        //                     color: Colors.white, fontWeight: FontWeight.bold),
        //               ),
        //             )
        //           ],
        //         )
        //       ]),
        // ),
      ],
    );
  }
}
