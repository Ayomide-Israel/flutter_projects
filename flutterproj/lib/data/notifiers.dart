//ValueNotifiers: holds the data
//ValueListableBuilder: Listens to the data without setState (if the data changes, it changes)

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(true);
