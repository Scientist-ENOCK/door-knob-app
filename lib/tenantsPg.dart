import 'dart:async';
import 'dart:convert';
import 'package:door_lock/LoginPg.dart';
import 'package:door_lock/status.dart';
// For using PlatformException
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class TenantsPg extends StatefulWidget {
  @override
  _TenantsPgState createState() => _TenantsPgState();
}

class _TenantsPgState extends State<TenantsPg> {
  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  int _deviceState;

  bool isDisconnecting = false;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // For retrieving and storing the paired devices
  // in a list.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  Color _bg = Colors.teal;

  // Now, its time to build the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _bg,
        appBar: (AppBar(
          backgroundColor: _bg,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1000),
                  pageBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return LoginPg();
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return Align(
                      child: SizeTransition(
                        sizeFactor: animation,
                        child: child,
                      ),
                    );
                  }));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            FlatButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              label: Text(
                'Reflesh',
                style: TextStyle(color: Colors.black),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              splashColor: Colors.deepPurple,
              onPressed: () async {
                // So, that when new devic es are paired
                // while the app is running, user can refresh
                // the paired devices list.
                await getPairedDevices().then((_) {
                  print('Device list refreshed');
                });
              },
            ),
          ],
        )),
        body: ListView(
          children: [
            Column(children: [
              Visibility(
                visible: _isButtonUnavailable &&
                    _bluetoothState == BluetoothState.STATE_ON,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 60,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                              ) {
                                return Status();
                              },
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return Align(
                                  child: SizeTransition(
                                    sizeFactor: animation,
                                    child: child,
                                  ),
                                );
                              }));
                        },
                        child: Text('STATUS')),
                  ),
                  SizedBox(
                    width: 230,
                  ),
                  Switch(
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.lime,
                    value: _bluetoothState.isEnabled,
                    onChanged: (bool value) {
                      future() async {
                        if (value) {
                          // Enable Bluetooth
                          await FlutterBluetoothSerial.instance.requestEnable();
                        } else {
                          // Disable Bluetooth
                          await FlutterBluetoothSerial.instance
                              .requestDisable();
                        }

                        // In order to update the devices list
                        await getPairedDevices();
                        _isButtonUnavailable = false;

                        // Disconnect from any device before
                        // turning off Bluetooth
                        if (_connected) {
                          _disconnect();
                        }
                      }

                      future().then((_) {
                        setState(() {});
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      1,
                      1,
                      210,
                      1,
                    ),
                    child: Text(
                      'paired device',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 1, 1, 1),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                            child: DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) =>
                                  setState(() => _device = value),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                          child: InkWell(
                            onTap: () {
                              _connect();
                            },
                            child: Container(
                              color: Colors.black54,
                              height: 50,
                              width: 70,
                              child: Center(
                                child: Text('connect'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                          child: InkWell(
                            onTap: () {
                              _disconnect();
                            },
                            child: Container(
                              color: Colors.black54,
                              height: 50,
                              width: 70,
                              child: Center(
                                child: Text('diconnect'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 120, 1, 1),
                child: Text(
                  'Scroll horizontaly close the door',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 300,

                    // aspectRatio: 16/9,
                    // viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    //  onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    InkWell(
                      onTap: () {
                        //    _colorChanger(items[10].color);

                        connection.output.add(utf8.encode("9" + "\r\n"));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: Center(
                            child: Text(
                              'Open',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //    _colorChanger(items[10].color);

                        connection.output.add(utf8.encode("8" + "\r\n"));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 60,
                          child: Center(
                            child: Text(
                              'Close',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('pair a device?'),
                  RaisedButton(
                    color: Colors.black54,
                    elevation: 2,
                    child: Text(
                      'Bluetooth Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      FlutterBluetoothSerial.instance.openSettings();
                    },
                  )
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      print('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        print('Device connected');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    print('Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }
}
