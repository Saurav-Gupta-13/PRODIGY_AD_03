import 'package:flutter/material.dart';
import 'dart:async';

class ElapsedTime {
  final int minutes;
  final int seconds;
  final int milliseconds;

  ElapsedTime({
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final Stopwatch stopwatch = Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerPage extends StatefulWidget {
  TimerPage({Key? key}) : super(key: key);

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = Dependencies();
  bool isDarkTheme = false;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    // Start the timer immediately when the page loads
    dependencies.stopwatch.start();
  }

  void leftButtonPressed() {
    setState(() {
      dependencies.stopwatch.reset();
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
      isRunning = !isRunning;
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: IconButton(
        icon: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        onPressed: callback,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white, // Set background color based on theme
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Switch(
                      value: isDarkTheme,
                      onChanged: (value) {
                        toggleTheme();
                      },
                      activeColor: Colors.blue,
                    ),
                    Text(
                      'Dark Theme',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TimerText(dependencies: dependencies, isDarkTheme: isDarkTheme), // Pass isDarkTheme to TimerText
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildFloatingButton(
                            "Reset", // Always show "Reset"
                            leftButtonPressed,
                          ),
                          buildFloatingButton(
                            isRunning ? "Stop" : "Start",
                            rightButtonPressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({required this.dependencies, required this.isDarkTheme});
  final Dependencies dependencies;
  final bool isDarkTheme; // Pass isDarkTheme as a parameter

  @override
  TimerTextState createState() => TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({required this.dependencies});
  final Dependencies dependencies;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void callback(Timer timer) {
    final int milliseconds = dependencies.stopwatch.elapsedMilliseconds;
    final int seconds = (milliseconds / 1000).truncate();
    final int minutes = (seconds / 60).truncate();

    final ElapsedTime elapsedTime = ElapsedTime(
      minutes: minutes,
      seconds: seconds % 60,
      milliseconds: milliseconds % 1000,
    );

    for (final listener in dependencies.timerListeners) {
      listener(elapsedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        children: <Widget>[
          Text(
            'Timer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.isDarkTheme ? Colors.white : Colors.black),
          ),
          SizedBox(height: 10),
          MinutesSecondsMilliseconds(dependencies: dependencies, isDarkTheme: widget.isDarkTheme), // Pass isDarkTheme to MinutesSecondsMilliseconds
        ],
      ),
    );
  }
}

class MinutesSecondsMilliseconds extends StatefulWidget {
  MinutesSecondsMilliseconds({required this.dependencies, required this.isDarkTheme});
  final Dependencies dependencies;
  final bool isDarkTheme; // Receive isDarkTheme as a parameter

  @override
  MinutesSecondsMillisecondsState createState() =>
      MinutesSecondsMillisecondsState(dependencies: dependencies);
}

class MinutesSecondsMillisecondsState extends State<MinutesSecondsMilliseconds> {
  MinutesSecondsMillisecondsState({required this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes ||
        elapsed.seconds != seconds ||
        elapsed.milliseconds != milliseconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
        milliseconds = elapsed.milliseconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String millisecondsStr = (milliseconds % 1000 ~/ 10).toString().padLeft(2, '0'); // Format milliseconds to two digits
    return Text(
      '$minutesStr:$secondsStr.$millisecondsStr',
      style: TextStyle(
        fontSize: 90.0,
        fontFamily: "Bebas Neue",
        color: widget.isDarkTheme ? Colors.white : Colors.black,
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that binding is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerPage();
  }
}
