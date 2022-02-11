//material UI, components & custom theme - standard for every file
import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'package:passage_flutter/theme/app_theme.dart';

//for bluetooth connection
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

//for log statements
import 'dart:developer';

//for using platform exception
import 'package:flutter/services.dart';

class FiltersHome extends StatefulWidget {
  const FiltersHome({Key? key}) : super(key: key);

  @override
  State<FiltersHome> createState() => _FiltersHomeState();
}

class _FiltersHomeState extends State<FiltersHome> {
// Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Get the instance of the Bluetooth
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection? connection;

  int? _deviceState;

  bool isDisconnecting = false;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection!.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
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
      connection!
          .dispose(); //isConnected being true means connection cannot be null
      connection = null;
    }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<bool> enableBluetooth() async {
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
      log("Error");
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

  //returns list of devices to populate dropdown widget
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      for (var device in _devicesList) {
        items.add(DropdownMenuItem(
          child: device.name == null
              ? const Text('no device name')
              : Text(device.name!),
          value: device,
        ));
      }
    }
    return items;
  }

// Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      log('No device selected');
      setState(() => _isButtonUnavailable = false);
    } else {
      try {
        await BluetoothConnection.toAddress(_device?.address)
            .then((_connection) {
          log('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection?.input?.listen(null).onDone(() {
            if (isDisconnecting) {
              log('Disconnecting locally!');
            } else {
              log('Disconnected remotely!');
            }
            if (mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          log('Cannot connect, exception occurred');
          setState(() => _isButtonUnavailable = false);
          log(error);
        });
        log('Device connected');

        setState(() => _isButtonUnavailable = false);
      } catch (exception) {
        log(exception.toString());
      }
    }
  }

  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection?.close();
    log('Device disconnected');
    if (!connection!.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

  //HERE STARTS THE UI CODE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Filter'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Go home!'),
              ),
            ),
            Wrap(children: [
              SizedBox(
                width: 400,
                child: Column(children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/manualsHome');
                        },
                        child: const Text('Bluetooth settings'),
                      ),
                      Row(
                        children: [
                          const Text('Enable Bluetooth'),
                          Switch(
                            value: _bluetoothState.isEnabled,
                            onChanged: (bool value) {
                              future() async {
                                if (value) {
                                  await FlutterBluetoothSerial.instance
                                      .requestEnable();
                                } else {
                                  await FlutterBluetoothSerial.instance
                                      .requestDisable();
                                }
                                await getPairedDevices();
                                _isButtonUnavailable = false;
                                if (_connected) {
                                  _disconnect();
                                }
                              }

                              future().then((_) {
                                setState(() {});
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Paired Devices'),
                      DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (value) =>
                            setState(() => _device = value as BluetoothDevice?),
                        value: _devicesList.isNotEmpty ? _device : null,
                      ),
                      ElevatedButton(
                        onPressed: _isButtonUnavailable
                            ? null
                            : _connected
                                ? _disconnect
                                : _connect,
                        child: Text(_connected ? 'Disconnect' : 'Connect'),
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/manualsHome');
                    },
                    child: const Text(
                      'Manual',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ]),
            Row(
              children: [
                const Text('Statistics:'),
                const SizedBox(
                  width: 100,
                ),
                const Text('Device: '),
                Text(_connected ? 'Connected' : 'Disconnected',
                    style: _connected
                        ? const TextStyle(color: Colors.green)
                        : const TextStyle(color: Colors.red)),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Send 1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Send 0',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
