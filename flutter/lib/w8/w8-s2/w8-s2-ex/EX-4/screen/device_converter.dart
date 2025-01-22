import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

enum Devices {
  riel,
  euro,
  dong,
}

class _DeviceConverterState extends State<DeviceConverter> {
  final _valueController = TextEditingController();
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );
  Devices device = Devices.riel;
  double amountSelected = 0;

  @override
  void initState() {
    super.initState();

    _valueController.addListener(() {
      _performConversion();
    });
  }

  @override
  void dispose() {
    _valueController.dispose(); // Clean up the controller
    super.dispose();
  }

  void _performConversion() {
    if (_valueController.text.isNotEmpty) {
      double amount = double.parse(_valueController.text);
      setState(() {
        switch (device) {
          case Devices.riel:
            amountSelected = amount * 4000;
            break;
          case Devices.euro:
            amountSelected = amount * 0.85;
            break;
          case Devices.dong:
            amountSelected = amount * 23000;
            break;
        }
      });
    } else {
      setState(() {
        amountSelected = 0;
      });
    }
  }

  void convertion(Devices? value) {
    if (value is Devices) {
      setState(() {
        device = value;
      });
    }
    _performConversion();
    print("$device");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),
          TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _valueController,
              decoration: InputDecoration(
                  prefix: const Text('\$ '),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter an amount in dollar',
                  hintStyle: const TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 30),
          DropdownButton(
            items: Devices.values
                .map((device) => DropdownMenuItem<Devices>(
                      value: device,
                      child: Text(device.name.toUpperCase()),
                    ))
                .toList(),
            value: device,
            onChanged: convertion,
          ),
          const SizedBox(height: 30),
          const Text("Amount in selected device:"),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: textDecoration,
            child: Text(
              amountSelected
                  .toStringAsFixed(2), // Displays with 2 decimal places
              style: const TextStyle(
                  color: Colors.black), // Adjust text color as needed
            ),
          )
        ],
      )),
    );
  }
}
