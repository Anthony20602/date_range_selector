import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Shows a custom date range picker dialog
///
/// [context] - Build context for the dialog
/// [fromDate] - Initial start date
/// [tillDate] - Initial end date
/// [onDateRangeSelected] - Callback when date range is selected
/// [primaryColor] - Primary color for the picker UI (default: blue)
/// [title] - Dialog title (default: 'Select Date Range')
/// [startWithFromDate] - Whether to start with selecting from date (default: true)
/// [onApply] - Optional callback when Apply button is pressed
Future<void> showCustomDateRangePicker(
  BuildContext context,
  DateTime fromDate,
  DateTime tillDate,
  Function(DateTime, DateTime) onDateRangeSelected, {
  Color primaryColor = const Color(0xFF2196F3),
  String title = 'Select Date Range',
  bool startWithFromDate = true,
  Future<void> Function()? onApply,
}) async {
  DateTime tempFromDate = fromDate;
  DateTime tempToDate = tillDate;
  bool isSelectingFrom = startWithFromDate;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 420,
                maxHeight: 620,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.black54, size: 24),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setDialogState(() {
                                    isSelectingFrom = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: isSelectingFrom
                                        ? primaryColor.withValues(alpha: 0.1)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelectingFrom
                                          ? primaryColor
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'FROM',
                                        style: TextStyle(
                                          color: isSelectingFrom
                                              ? primaryColor
                                              : Colors.grey.shade600,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        DateFormat('dd MMM yyyy').format(tempFromDate),
                                        style: TextStyle(
                                          color: isSelectingFrom
                                              ? primaryColor
                                              : Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_forward, color: primaryColor, size: 20),
                            SizedBox(width: 12),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setDialogState(() {
                                    isSelectingFrom = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: !isSelectingFrom
                                        ? primaryColor.withValues(alpha: 0.1)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: !isSelectingFrom
                                          ? primaryColor
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TO',
                                        style: TextStyle(
                                          color: !isSelectingFrom
                                              ? primaryColor
                                              : Colors.grey.shade600,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        DateFormat('dd MMM yyyy').format(tempToDate),
                                        style: TextStyle(
                                          color: !isSelectingFrom
                                              ? primaryColor
                                              : Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Calendar
                  Expanded(
                    child: Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: primaryColor,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black87,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: primaryColor,
                          ),
                        ),
                      ),
                      child: CalendarDatePicker(
                        initialDate: () {
                          DateTime candidateDate = isSelectingFrom ? tempFromDate : tempToDate;
                          DateTime firstDate = DateTime(2000);
                          DateTime lastDate = DateTime(2100);
                          if (candidateDate.isBefore(firstDate)) {
                            return firstDate;
                          } else if (candidateDate.isAfter(lastDate)) {
                            return lastDate;
                          }
                          return candidateDate;
                        }(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        currentDate: DateTime.now(),
                        onDateChanged: (DateTime selectedDate) {
                          setDialogState(() {
                            if (isSelectingFrom) {
                              tempFromDate = selectedDate;
                              if (tempFromDate.isAfter(tempToDate)) {
                                tempToDate = selectedDate;
                              }
                              isSelectingFrom = false;
                            } else {
                              if (selectedDate.isBefore(tempFromDate)) {
                                tempToDate = tempFromDate;
                                tempFromDate = selectedDate;
                              } else {
                                tempToDate = selectedDate;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  // Action Buttons
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            onDateRangeSelected(tempFromDate, tempToDate);
                            Navigator.of(context).pop();

                            if (onApply != null) {
                              await onApply();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}