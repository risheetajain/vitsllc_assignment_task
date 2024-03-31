import 'package:flutter/material.dart';


InputDecoration inputdecoration(context) => InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      counterStyle: Theme.of(context).textTheme.bodySmall,
      labelStyle: Theme.of(context).textTheme.bodySmall,
    );
