# Date Range Selector

A customizable Flutter date range picker widget with an elegant UI and flexible color options.

![Range Selector Preview](https://raw.githubusercontent.com/Anthony20602/date_range_selector/main/assets/screenshots/range_selector.png)

## Features

- 🎨 **Customizable Colors** - Pass your own primary color to match your app's theme
- 📅 **Intuitive Date Selection** - Easy-to-use interface for selecting date ranges
- 🎯 **Flexible Configuration** - Configure title, starting date selection mode, and more
- ✨ **Modern UI** - Clean and modern design that works with any app
- 🔄 **Auto-adjustment** - Automatically handles date validation and range logic

## Installation

### Option 1: Local Path (For Development)

```yaml
dependencies:
  intl: ^0.19.0  # Required dependency
  date_range_selector:
    path: C:/Users/.../date_range_selector
    # Or use relative path: ../date_range_selector
```

### Option 2: Git Repository (Recommended)

```yaml
dependencies:
  intl: ^0.19.0  # Required dependency
  date_range_selector:
    git:
      url: https://github.com/yourusername/date_range_selector.git
      ref: main
```

### Option 3: pub.dev (When Published)

```yaml
dependencies:
  date_range_selector: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:date_range_selector/date_range_selector.dart';

// In your widget:
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now();

// Show the date range picker
await showCustomDateRangePicker(
  context,
  startDate,
  endDate,
  (DateTime from, DateTime to) {
    setState(() {
      startDate = from;
      endDate = to;
    });
  },
);
```

### With Custom Color

```dart
await showCustomDateRangePicker(
  context,
  startDate,
  endDate,
  (DateTime from, DateTime to) {
    setState(() {
      startDate = from;
      endDate = to;
    });
  },
  primaryColor: const Color(0xFF6200EE), // Your custom color
  title: 'Select Date Range',
);
```

### Complete Example with Custom Button

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_selector/date_range_selector.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  DateTime? startDate;
  DateTime? endDate;
  
  // Define your custom color (e.g., from your app's globals)
  final Color medcoBlue = const Color(0xFF1976D2);

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
                startDate = from;
                endDate = to;
                // Add your filter logic here
              });
            },
            primaryColor: medcoBlue, // Pass your custom color
            title: 'Select Date Range',
          );
        },
        child: Container(
          height: 40,
          width: (startDate != null && endDate != null) ? 280 : 140,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: startDate != null ? medcoBlue.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: startDate != null ? medcoBlue : Colors.transparent,
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
                    color: startDate != null ? medcoBlue : Colors.black,
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
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: medcoBlue,
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
      body: Center(
        child: _buildDateFilter(),
      ),
    );
  }
}
```

## API Reference

### showCustomDateRangePicker

Shows a custom date range picker dialog.

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context for the dialog |
| `fromDate` | `DateTime` | Yes | - | Initial start date |
| `tillDate` | `DateTime` | Yes | - | Initial end date |
| `onDateRangeSelected` | `Function(DateTime, DateTime)` | Yes | - | Callback when date range is selected |
| `primaryColor` | `Color` | No | `Color(0xFF2196F3)` | Primary color for the picker UI |
| `title` | `String` | No | `'Select Date Range'` | Dialog title |
| `startWithFromDate` | `bool` | No | `true` | Whether to start with selecting from date |
| `onApply` | `Future<void> Function()?` | No | `null` | Optional callback when Apply button is pressed |

#### Returns

`Future<void>` - Completes when the dialog is dismissed

## Screenshots

(Add screenshots of your date range picker here)

## Dependencies

- `flutter` - Flutter SDK
- `intl: ^0.19.0` - For date formatting

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you have any questions or issues, please open an issue on GitHub.
