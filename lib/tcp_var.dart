import 'dart:io';

import 'package:flutter/foundation.dart';

Socket? socket;
ValueNotifier<String> connected = ValueNotifier<String>("connecting");
