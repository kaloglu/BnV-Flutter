import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BaseModel extends Equatable {
  const BaseModel({
    Key key,
  });

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap();
}
