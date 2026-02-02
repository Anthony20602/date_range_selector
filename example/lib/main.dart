import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_selector/date_range_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Range Selector Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Date Range Selector Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? startDate;
  DateTime? endDate;
  DateTimeRange? pickedRange;

  // Define your custom color here
  final Color customColor = const Color(0xFF6200EE); // Example: Purple

  Widget _buildDateFilter() {
    String buttonText;
    if (startDate != null && endDate != null) {
      final formatter = DateFormat('dd/MM/yyyy');
      buttonText = "From: ${formatter.format(startDate!)} - To: ${formatter.format(endDate!)}";
    } else {
      buttonText = "Date";
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await showCustomDateRangePicker(
            context,
            startDate ?? DateTime.now(),
            endDate ?? DateTime.now(),
            (DateTime from, DateTime to) {
              setState(() {
                pickedRange = DateTimeRange(start: from, end: to);
                startDate = from;
                endDate = to;
              });
            },
            primaryColor: customColor, // Pass your custom color here
            title: 'Select Date Range',
          );
        },
        child: Container(
          height: 40,
          width: (startDate != null && endDate != null) ? 280 : 140,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: startDate != null ? customColor.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: startDate != null ? customColor : Colors.transparent,
              width: 1,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: startDate != null ? customColor : Colors.black,
                    fontSize: 14,
                    fontWeight: startDate != null ? FontWeight.w600 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (startDate != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      startDate = null;
                      endDate = null;
                      pickedRange = null;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: customColor,
                    size: 18,
                  ),
                )
              else
                const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Click the button below to select a date range:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildDateFilter(),
            const SizedBox(height: 20),
            if (startDate != null && endDate != null)
              Text(
                'Selected: ${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate!)}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
