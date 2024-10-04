import 'dart:io';
import '../lib/colorCode.dart' as color;
import 'dart:math';

// ANSI escape codes for explosion background colors
const List<String> explosionBackgroundColors = [
  "\x1B[41m", // Red
  "\x1B[42m", // Green
  "\x1B[43m", // Yellow
  "\x1B[44m", // Blue
  "\x1B[45m", // Magenta
  "\x1B[46m", // Cyan
];

void moveTo(int row, int col) {
  stdout.write('\x1B[${row};${col}H');
}

// Function to print the firework before it explodes
void printFrame1(int centerX, int centerY, String colorSelect) {
  moveTo(centerY, centerX);
  stdout.write('${colorSelect}|${color.RESET}');
}

// Function to print the firework explosion as a snowflake (starting stage)
void printFrame2(int centerX, int centerY, String colorSelect) {
  // Draw the initial snowflake shape
  moveTo(centerY - 1, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');

  // Add diagonal parts to resemble snowflake arms
  moveTo(centerY - 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY - 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');

  // Additional arms for snowflake
  moveTo(centerY - 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 2);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 2);
  stdout.write('${colorSelect}*${color.RESET}');
}

// Function to print the full snowflake explosion
void printFrame3(int centerX, int centerY, String colorSelect) {
  // Center explosion
  moveTo(centerY, centerX);
  stdout.write('${colorSelect}*${color.RESET}');

  // Full snowflake pattern
  moveTo(centerY - 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 2, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 2);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 2);
  stdout.write('${colorSelect}*${color.RESET}');

  // Diagonal arms for a snowflake look
  moveTo(centerY - 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY - 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX - 1);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 1, centerX + 1);
  stdout.write('${colorSelect}*${color.RESET}');

  // Extended snowflake arms
  moveTo(centerY - 3, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY + 3, centerX);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX - 3);
  stdout.write('${colorSelect}*${color.RESET}');
  moveTo(centerY, centerX + 3);
  stdout.write('${colorSelect}*${color.RESET}');
}

// Function to clear the screen
void clearScreen() {
  stdout.write('\x1B[2J\x1B[0;0H');
}

// Function to print the HBD ANO message
Future<void> printHBDMessage() async {
  const List<String> message = [
    " **  **  ******   *******           ***         ****     **    *****   ",
    " **  **  **    *  **    ***        **  **       ** **    **   **   **  ",
    " ******  ** ***   **       *      **    **      **  **   **   **   **  ",
    " **  **  **    *  **     **      **********     **   **  *    **   **  ",
    " **  **  ******   *******       **        **    **     **      *****   ",
  ];

  // Move the message up from the bottom to the middle
  for (int i = message.length - 1; i >= 0; i--) {
    moveTo(15 - (message.length - 1 - i), 10); // Start from the bottom
    stdout.write(message[i]);
    await Future.delayed(Duration(milliseconds: 300)); // Delay between lines
  }
  
  // Keep the message on the screen longer
  await Future.delayed(Duration(seconds: 3));
}

Future<void> kembangApi(centerX, centerY, String colorSelect) async {
  clearScreen();

  // Frame 1: Firework rises (central point before explosion)
  for (int i = centerY; i > centerY - 5; i--) { // Move cursor up
    printFrame1(centerX, i, colorSelect);
    await Future.delayed(Duration(milliseconds: 100)); // Speed of ascent
    clearScreen();
  }

  // After reaching the top
  printFrame1(centerX, centerY - 5, colorSelect);
  await Future.delayed(Duration(milliseconds: 500)); // Delay before explosion

  // Frame 2: Firework begins to explode
  clearScreen();
  printFrame2(centerX, centerY - 5, colorSelect);
  String explosionBackground = explosionBackgroundColors[Random().nextInt(explosionBackgroundColors.length)];
  stdout.write(explosionBackground); // Change background for explosion
  await Future.delayed(Duration(milliseconds: 500));

  // Frame 3: Full explosion in snowflake shape
  clearScreen();
  printFrame3(centerX, centerY - 5, colorSelect);
  await Future.delayed(Duration(milliseconds: 500));

  // Print HBD ANO message
  clearScreen();
  await printHBDMessage(); // Call the function to print HBD ANO

  // Reset background color after explosion
  stdout.write("\x1B[0m"); // Reset to default background
}
