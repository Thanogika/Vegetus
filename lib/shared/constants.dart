import 'package:flutter/material.dart';

const TextInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(70))),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(70))));
