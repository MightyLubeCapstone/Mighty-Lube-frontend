import 'package:flutter/material.dart';
import 'package:mighty_lube/LoginPage/API/apicalls.dart';

class FormAPI {
  String? conveyorLengthUnit;
  String? conveyorSpeedUnit;
  Map<String, dynamic> formData = {};
  
  final Map<String, TextEditingController> controllers = {
    'conveyorName': TextEditingController(),
    'conveyorChainSize': TextEditingController(),
    'chainManufacturer': TextEditingController(),
    'wheelManufacturer': TextEditingController(),
    'chainPinType': TextEditingController(),
    'conveyorLength': TextEditingController(),
    'conveyorLengthUnit': TextEditingController(),
    'conveyorSpeed': TextEditingController(),
    'conveyorSpeedUnit': TextEditingController(),
    'indexing': TextEditingController(),
    'directionOfTravel': TextEditingController(),
    'metalType': TextEditingController(),
    'conveyorStyle': TextEditingController(),
    'trolleyColor': TextEditingController(),
    'trolleyType': TextEditingController(),
    'applicationEnvironment': TextEditingController(),
    'temperature': TextEditingController(),
    'loaded': TextEditingController(),
    'swing': TextEditingController(),
    'plantLayout': TextEditingController(),
    'chainPictures': TextEditingController(),
  };

  void getFglm() async {
    final fglmData = await ApiState().getFglm();

    if (fglmData != null) {
      print(fglmData);
    } else {
      print('Failed to get FGLM data');
    }
  }

  fglmForm() async {
    final fglmData = {
      'conveyorName': controllers['conveyorName']?.text,
      'conveyorChainSize': controllers['conveyorChainSize']?.text,
      'chainManufacturer': controllers['chainManufacturer']?.text,
      'wheelManufacturer': controllers['wheelManufacturer']?.text,
      'chainPinType': controllers['chainPinType']?.text,
      'conveyorLength': controllers['conveyorLength']?.text,
      'conveyorLengthUnit': conveyorLengthUnit,
      'conveyorSpeed': controllers['conveyorSpeed']?.text,
      'conveyorSpeedUnit': conveyorSpeedUnit,
      'indexing': controllers['indexing']?.text,
      'directionOfTravel': controllers['directionOfTravel']?.text,
      'metalType': controllers['metalType']?.text,
      'conveyorStyle': controllers['conveyorStyle']?.text,
      'trolleyColor': controllers['trolleyColor']?.text,
      'trolleyType': controllers['trolleyType']?.text,
      'applicationEnvironment': controllers['applicationEnvironment']?.text,
      'temperature': controllers['temperature']?.text,
      'loaded': controllers['loaded']?.text,
      'swing': controllers['swing']?.text,
      'plantLayout': controllers['plantLayout']?.text,
      'chainPictures': controllers['chainPictures']?.text,
    };
    final success = await ApiState().addFglm(fglmData);

    return success;
  }
}