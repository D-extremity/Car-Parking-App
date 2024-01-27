import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/pages/homepage.dart';

import 'package:parking_system/pages/slot_booking.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/utils/drawerui.dart';
// import 'package:parking_system/utils/farestyle.dart';

import 'package:parking_system/widgets/parkingwidget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      drawer: getDrawer(context, size, username),
      appBar: AppBar(
        title: Text(
          'Find Vehicle',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.height * 0.04,
              color: titleColor),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[backgroundColor, backgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                SearchBar(hintText: "Vehicle Number",
                  leading: Icon(
                    Icons.search,
                    color: lightBackgroundColor,
                  ),
                  elevation: MaterialStatePropertyAll(6),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      parkedVehicle = parkedVehicleList;
                      setState(() {});
                    } else {
                      parkedVehicle = parkedVehicle
                          .where((vehicle) =>
                              vehicle['vehicle'].toString().contains(value))
                          .toList();
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                //!ListView.Builder will come
                Expanded(
                    child: ListView.builder(
                        itemCount: parkedVehicle.length,
                        itemBuilder: (context, int index) {
                          return searchedvehicleTile(
                              size, index, parkedVehicle[index], context);
                        }))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
