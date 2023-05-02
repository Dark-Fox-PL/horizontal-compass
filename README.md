# Horizontal Compass
At first - it's not a regular compass, but because I wasn't able to think of better name...
Well, this plugin creates something like horizontal ruler, but idea behind was to use it as a tool for navigation in the app I had to make.

## How does it looks like?
<img src="https://raw.githubusercontent.com/Dark-Fox-PL/horizontal-compass/main/images/1.png" width="300">

## Getting Started
It's a simple widget, so no permissions are required. Just type in the terminal:
```bash
flutter pub add horizontal_compass
```
and enjoy the happiness.

## Example
Full example you can see in the Example tab, but that's a shorthand:
```dart
HorizontalCompass(
  value: 10,
  segments: {
    'segmentA': 30,
    'segmentB': 50,
    'segmentC': 120,
    'segmentD': 160,
  },
  colors: [
    Colors.blueAccent,
    Colors.deepPurpleAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
  ],
);
```

Widget requires 3 variables to be set:
* value - which represents current value
* segments - a `Map<String, double>` which tells widget how large are segments, in a Map, `String` is for a name for segment, `double` for its length, so in given example it means: `segment a` should covers value 0 to 30, `segment b` values 30 to 80, etc.
* colors - is a `List<Color>` for created segments, so in given example `segment a` is blue, `segment b` purple, etc.

## Customization
Widget allows you to customize its look and behavior.

| Field         |              Default value              | Description                                                                                                                              |
|:--------------|:---------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------|
| spacing       |                 `15.0`                  |  Defines space between the ruler lines.                                                                                                  |
| width         |                 `null`                  |  Allows to determine widget width, if null it'll cover all possible space.                                                               |
| height        |                 `30.0`                  |  Widget height.                                                                                                                          |
| start         |                  `0.0`                  |  Initial value.                                                                                                                          |
| end           |                 `360.0`                 |  Last value.                                                                                                                             |
| type          |     `HorizontalCompassType.finite`      |  Determines main behavior of the widget. Type `finite` presents widget from start to the end value, while type `infinite` makes it loop. |
| rulerPosition | `HorizontalCompassRulerPosition.center` |  Determines how ruler lines are positioned to each other.                                                                                |
| cursorColor   |          `Colors.transparent`           |  Color of the central point of a widget.                                                                                                 |
| cursorWidth   |                  `5.0`                  |  Width of the central point of a widget.                                                                                                 |
| lineWidth     |                  `2.0`                  |  Set width for a single line.                                                                                                            |
| markPosition  |                   `5`                   |  Determines which line should have increased height.                                                                                     |
| value         |                                         |  *required* Current value of the widget.                                                                                                 |
| segments      |                                         |  *required* Map with segments values.                                                                                                    |
| colors        |                                         |  *required* List of colors to be set for each segment.                                                                                   |