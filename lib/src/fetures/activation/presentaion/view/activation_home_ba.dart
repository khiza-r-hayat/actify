import 'dart:developer';

import 'package:actify/src/constants/colors.dart';
import 'package:actify/src/fetures/performance/presentation/view/performance_screen.dart';
import 'package:actify/src/fetures/pitch/presentation/view/revise_pitch.dart';
import 'package:actify/src/fetures/stocks/manage_stocks/presentation/view/manage_stocks_screen.dart';
import 'package:actify/src/fetures/upload_photo/presentation/view/upload_photo_screen.dart';
import 'package:actify/src/fetures/videos/presentation/view/watch_videos/watch_videos_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/merquee_text.dart';
import '../../../../services/location_service/location_service.dart';
import '../../../pitch/presentation/view/start_pitch/start_pitch_screen.dart';
import '../../../sync_data/presentation/view/sync_data_screen.dart';

class ActivationHomeBAScreen extends StatefulWidget {
  const ActivationHomeBAScreen({super.key});

  @override
  State<ActivationHomeBAScreen> createState() => _ActivationHomeBAScreenState();
}

class _ActivationHomeBAScreenState extends State<ActivationHomeBAScreen> {
  final smallText = const TextStyle(color: Colors.black87, fontSize: 10);

  final smallTextLight = const TextStyle(color: Colors.black12, fontSize: 10);

  final largeTextDark = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  String _currentAddress = 'My Address';

  final LocationService _locationService = LocationService();

  final List<Map<String, dynamic>> actions = [
    {
      'index': 0,
      'screenName': 'TAKE SELFIE',
      'drawerName': '',
    },
    {
      'index': 1,
      'screenName': 'REVISE PITCH',
      'drawerName': 'Pitch',
    },
    {
      'index': 2,
      'screenName': "WATCH VIDEOS",
      'drawerName': 'Videos',
    },
    {
      'index': 3,
      'screenName': "START PITCH",
      'drawerName': '',
    },
    {
      'index': 4,
      'screenName': "CHECK PERFORMANCE",
      'drawerName': 'Performance',
    },
    {
      'index': 5,
      'screenName': "MANAGE STOCKS",
      'drawerName': 'Manage Stocks',
    },
    {
      'index': 6,
      'screenName': 'SYNC OFFLINE DATA',
      'drawerName': 'Sync Data',
    },
    {
      'index': 7,
      'screenName': '',
      'drawerName': 'Logout',
    },
  ];

  navigateTo(index, BuildContext context) {
    log('value on tap: $index');
    switch (index) {
      case 0:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const UploadPhotoScreen(isSupervisor: false)));
        }
        break;
      case 1:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RevisePitch()));
        }
        break;
      case 2:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WatchVideosScreen()));
        }
        break;
      case 3:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const StartPitchScreen()));
        }
        break;
      case 4:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PerformanceScreen()));
        }
        break;
      case 5:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ManageStocksScreen()));
        }
        break;
      case 6:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SyncDataScreen()));
        }
        break;
      case 7:
        {
          logout();
        }
        break;
    }
  }

  logout() {
    log('logout logic here');
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    String address = await _locationService.getCurrentAddress();
    setState(() {
      _currentAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    final size = MediaQuery.of(context).size;

    final userInfoWidget = Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.15),
      // padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'User Name',
            style: largeTextDark,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Login Time',
                    style: smallText,
                  ),
                  Text(
                    '00:00 PM',
                    style: smallText,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'GPS Location',
                    style: smallText,
                  ),
                  MarqueeText(
                    text: _currentAddress,
                    width: size.width*0.3,
                    style: smallText,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );

    widgets.add(userInfoWidget);

    for (var item in actions) {
      final widget = item['screenName'] != ''
          ? GestureDetector(
              onTap: () {
                navigateTo(item['index'], context);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: primaryColor),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                child: Center(
                    child: Text(
                  item['screenName'],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            )
          : const Text('');
      if (item['screenName'] != '') {
        widgets.add(widget);
      }
    }

    List<Widget> drawerItems = [];
    for (var item in actions) {
      final widget = item['drawerName'] != ''
          ? ListTile(
              onTap: () {
                navigateTo(item['index'], context);
              },
              subtitle: Text(item['drawerName']),
              textColor: Colors.white,
            )
          : const Text('');
      if (item['drawerName'] != '') {
        drawerItems.add(widget);
      }
    }

    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.58,
        backgroundColor: primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Column(
            children: drawerItems,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('activation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
