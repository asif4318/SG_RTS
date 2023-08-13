import 'package:flutter/material.dart';
import 'package:rts_flutter/services/bus_service.dart';
import 'package:rts_flutter/services/repository/db_service.dart';

class DisplayRoutePopupMenuButton extends StatefulWidget {
  final BusService busService;
  final DbService dbService;

  const DisplayRoutePopupMenuButton({Key? key, required this.busService, required this.dbService})
      : super(key: key);

  @override
  State<DisplayRoutePopupMenuButton> createState() =>
      _DisplayRoutePopupMenuButtonState();
}

class _DisplayRoutePopupMenuButtonState extends State<DisplayRoutePopupMenuButton> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([widget.busService.getRoutes(), widget.dbService.getSelectedRoutes()]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PopupMenuButton(
            itemBuilder: (context) {
              return snapshot.data![0]
                  .map((e) => CheckedPopupMenuItem(
                value: e.routeNumber,
                checked: snapshot.data![1].where((element) => element.routeNumber == e.routeNumber).isNotEmpty,
                child: Text("${e.routeDesignator}. ${e.routeName}"),
              ))
                  .toList() ??
                  [];
            },
            onSelected: (routeNumber) {
              setState(() {
                // Toggle the isSelected value for the selected route
                var allRoutes = snapshot.data![0];
                var selectedRoute = allRoutes.firstWhere(
                        (element) => element.routeNumber == routeNumber);

                if (selectedRoute != null) {
                  selectedRoute.isSelected = !selectedRoute.isSelected;
                  widget.dbService.upsertRoutes([selectedRoute]);
                }
              });
            },
            icon: const Icon(Icons.add_road),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:rts_flutter/services/bus_service.dart';
// import 'package:rts_flutter/services/repository/db_service.dart';
//
// class DisplayRoutePopupMenuButton extends StatefulWidget {
//   final BusService busService;
//   final DbService dbService;
//
//   const DisplayRoutePopupMenuButton({Key? key, required this.busService, required this.dbService})
//       : super(key: key);
//
//   @override
//   State<DisplayRoutePopupMenuButton> createState() =>
//       _DisplayRoutePopupMenuButtonState();
// }
//
// class _DisplayRoutePopupMenuButtonState extends State<DisplayRoutePopupMenuButton> {
//   late Future _getSelectedRoutes;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getSelectedRoutes = widget.dbService.getSelectedRoutes();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Future.wait([widget.busService.getRoutes(), widget.dbService.getSelectedRoutes()]),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return PopupMenuButton(
//               itemBuilder: (context) {
//                 return snapshot!.data![0]
//                         ?.map((e) => CheckedPopupMenuItem(
//                             value: e.routeNumber,
//                             checked: snapshot!.data![1].where((element) => element.routeNumber == e.routeNumber).isNotEmpty,
//                             child:
//                                 Text("${e.routeDesignator}. ${e.routeName}")))
//                         .toList() ??
//                     [];
//               },
//               onSelected: (item) {},
//               icon: const Icon(Icons.add_road));
//         }
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
