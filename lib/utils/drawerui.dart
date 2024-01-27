import 'package:flutter/material.dart';
import 'package:parking_system/pages/homepage.dart';
import 'package:parking_system/pages/searchpage.dart';
import 'package:parking_system/pages/settingspage.dart';
import 'package:parking_system/pages/slot_booking.dart';
import 'package:parking_system/utils/colours.dart';
import 'package:parking_system/widgets/signoutdialog.dart';

Drawer getDrawer(BuildContext context, Size size, String username) {
  return Drawer(
    shadowColor: titleColor,
    // surfaceTintColor: titleColor,
    clipBehavior: Clip.hardEdge,
    width: 250,
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(),
    elevation: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.04,
        ),
        Text(
          username.substring(0,8),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.height * 0.04,
              color: titleColor),
        ),
        SizedBox(
            width: 200,
            child: Divider(
              height: size.height * .005,
            )),
        //! Parking
        //! Book Slot
        //! setting to change fare price
        //! Sign out
        SizedBox(
          height: size.height * 0.08,
        ),
        getDrawerItem(size, "Parking", Icons.local_parking_rounded,
            () => onpressed(1, context, size, username)),
        SizedBox(
          height: size.height * 0.04,
        ),
        getDrawerItem(size, "Book Slot", Icons.car_crash_sharp,
            () => onpressed(2, context, size, username)),
        SizedBox(
          height: size.height * 0.04,
        ),
        getDrawerItem(size, "Find Vehicle", Icons.search,
            () => onpressed(4, context, size, username)),
        SizedBox(
          height: size.height * 0.04,
        ),
        getDrawerItem(size, "Settings", Icons.settings,
            () => onpressed(3, context, size, username)),
        SizedBox(
          height: size.height * 0.34,
        ),
        SizedBox(
          width: size.width * 0.46,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: titleColor, shape: const LinearBorder()),
            child: Row(
              children: [
                Icon(
                  Icons.settings_power_outlined,
                  color: backgroundColor,
                  size: size.height * 0.036,
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  "Sign Out",
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: size.height * 0.028,
                  ),
                ),
              ],
            ),
            onPressed: () async {
              signOutDialog(context, size, auth);
            },
          ),
        ),
      ],
    ),
  );
}

Widget getDrawerItem(
    Size size, String itemName, IconData icon, VoidCallback onpressed) {
  return Padding(
    padding: EdgeInsets.only(
      left: 30,
      top: size.height * 0.01,
    ),
    child: InkWell(
      onTap: onpressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: lightBackgroundColor,
            size: size.height * 0.036,
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Text(
            itemName,
            style: TextStyle(
              color: const Color.fromARGB(221, 58, 55, 55),
              fontSize: size.height * 0.032,
            ),
          ),
        ],
      ),
    ),
  );
}

onpressed(int n, BuildContext context, Size size, String username) {
  switch (n) {
    case 1:
      {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      }
      break;
    case 2:
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                BookingPage(size: size, username: username, auth: auth)));
      }
    case 3:
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                SettingsPage(size: size, username: username)));
      }
    case 4:
      {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const SearchPage()));
      }
  }
}
