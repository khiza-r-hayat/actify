import 'dart:developer';

import 'package:actify/src/common_widgets/merquee_text.dart';
import 'package:actify/src/constants/colors.dart';
import 'package:actify/src/fetures/checklist/presentation/view/checklist_screen.dart';
import 'package:actify/src/fetures/performance/presentation/view/performance_screen.dart';
import 'package:actify/src/fetures/stocks/assign_stocks/presentation/view/assign_stocks_screen.dart';
import 'package:actify/src/fetures/upload_photo/presentation/view/upload_photo_screen.dart';
import 'package:actify/src/models/acivity/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/location_service/location_service.dart';
import '../../../approval/approve_ba_returns/presentation/view/approve_ba_returns_screen.dart';
import '../../../authentication/data/user_data_state_provider.dart';
import '../../../home/presentation/view/home_screen.dart';

class ActivationHomeSupervisorScreen extends ConsumerStatefulWidget {
  final Activity activity;
  const ActivationHomeSupervisorScreen({super.key, required this.activity});

  @override
  ConsumerState<ActivationHomeSupervisorScreen> createState() => _ActivationHomeSupervisorScreenState();
}

class _ActivationHomeSupervisorScreenState extends ConsumerState<ActivationHomeSupervisorScreen> {
  final smallText = const TextStyle(color: Colors.black87, fontSize: 10);
  final smallTextLight = const TextStyle(color: Colors.black12, fontSize: 10);
  final largeTextDark = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);


  String _currentAddress = '';
  final LocationService _locationService = LocationService();

  final List<Map<String, dynamic>> actions = [
    {
      'index': 0,
      'screenName': 'TAKE SETUP & TEAM PHOTO',
      'drawerName': '',
    },
    {
      'index': 1,
      'screenName': 'CHECKLISTS',
      'drawerName': 'Checklists',
    },
    {
      'index': 2,
      'screenName': "ASSIGN BA'S STOCK",
      'drawerName': 'Assign Stocks',
    },
    {
      'index': 3,
      'screenName': "CHECK BA'S PERFORMANCE",
      'drawerName': 'Performance',
    },
    {
      'index': 4,
      'screenName': "APPROVE BA'S RETURNS",
      'drawerName': 'Returns Approval',
    },
    {
      'index': 6,
      'screenName': 'BACK',
      'drawerName': 'Home',
    },
    {
      'index': 5,
      'screenName': '',
      'drawerName': 'Logout',
    },
  ];

  navigateTo(index, BuildContext context,Activity activity) {
    log('value on tap: $index');
    switch (index) {
      case 0:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const UploadPhotoScreen(isSupervisor: true)));
        }
        break;
      case 1:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CheckListScreen(activity: activity,)));
        }
        break;
      case 2:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AssignStocksScreen()));
        }
        break;
      case 3:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PerformanceScreen()));
        }
        break;
      case 4:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ApproveBaReturnsScreen()));
        }
        break;
      case 5:
        {
          logout();
        }
        break;
      case 6:
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
        break;
    }
  }

  logout(){log('logout logic here');}
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
    final user = ref.watch(userStateProvider);
    Size size = MediaQuery.of(context).size;
    widget.activity;

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
            '${widget.activity.supervisorName}',
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
                  const SizedBox(height: 10,),
                  Text(
                    user!.loginTime!,
                    style: smallText,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'GPS Location',
                    style: smallText,
                  ),
                  const SizedBox(height: 10,),
                  _currentAddress == '' ? const SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): MarqueeText(
                    text: _currentAddress,
                    width: size.width*0.3,
                    style: smallText,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Assigned Location',
                    style: smallText,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'Tap to change',
                    style: smallTextLight,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );

    widgets.add(userInfoWidget);

    for (var item in actions) {
      final widgetItem = item['screenName'] != ''
          ? GestureDetector(
              onTap: () {
                navigateTo(item['index'], context,widget.activity);
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
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            )
          : const Text('');
      if (item['screenName'] != '') {
        widgets.add(widgetItem);
      }
    }

    List<Widget> drawerItems = [];
    for (var item in actions) {
      final widgetItem = item['drawerName'] != ''
          ? ListTile(
              onTap: () {
                navigateTo(item['index'], context,widget.activity);
              },
              subtitle: Text(item['drawerName']),
              textColor: Colors.white,
            )
          : const Text('');
      if (item['drawerName'] != '') {
        drawerItems.add(widgetItem);
      }
    }

    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.58,
        backgroundColor: primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Column(
            children: drawerItems,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('activation ${widget.activity.activityTitle}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
