import 'package:flutter/material.dart';

abstract class BaseModel {
  const BaseModel({
    Key key,
  });

  Map<String, dynamic> toJson();

}
