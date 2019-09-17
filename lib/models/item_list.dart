import 'package:flutter/material.dart';

class ProudctItem {
  final String path;
  final String name;
  final double price;
  final bool isLike;
  final List<String> features;
  final Color bgColor;

  ProudctItem({
    this.path,
    this.features,
    this.isLike,
    this.name,
    this.price,
    this.bgColor
  });
}

List<ProudctItem> itemList = [
  ProudctItem(
    name: 'Bose Noise Cancelling Headphones 700',
    price: 399.95,
    path: '',
    features: [
      "Bose Noise Cancelling Headphones 700",
      "Audio-only cable (2.5 mm to 3.5 mm)",
      "USB-C to USB-A charging cable (20 in./50.8 cm)",
      "Owner's manual",
      "Protective hard case",
    ],
    isLike: false,
    bgColor: Colors.white,
  ),
  ProudctItem(
    name: 'Beats Studio3 Wireless Over‑Ear Headphones - Blue',
    price: 349.95,
    path: '',
    features: [
      "Beats Studio3 Wireless headphones",
      "Carrying case",
      "3.5mm RemoteTalk cable",
      "Universal USB charging cable (USB-A to USB Micro-B)",
      "Quick Start Guide ",
    ],
    isLike: true,
    bgColor: Colors.red,
  ),
  ProudctItem(
    name: 'Beats Studio3 Wireless Headphones - NBA Collection - Lakers Purple',
    price: 349.95,
    path: '',
    features: [
      "Form Factor: Over ear",
      "Connections: Bluetooth, Wireless",
      "Bluetooth Compatibility: Bluetooth 4.0",
      "Power Source: Battery power",
      "Batteries: Rechargeable Lithium Ion",
    ],
    isLike: false,
    bgColor: Colors.purple,
  ),
  ProudctItem(
    name: 'Bose Noise Cancelling Headphones 700',
    price: 399.95,
    path: '',
    features: [
      "Bose Noise Cancelling Headphones 700",
      "Audio-only cable (2.5 mm to 3.5 mm)",
      "USB-C to USB-A charging cable (20 in./50.8 cm)",
      "Owner's manual",
      "Protective hard case",
    ],
    isLike: false,
    bgColor: Colors.white,
  ),
  ProudctItem(
    name: 'Beats Studio3 Wireless Over‑Ear Headphones - Blue',
    price: 349.95,
    path: '',
    features: [
      "Beats Studio3 Wireless headphones",
      "Carrying case",
      "3.5mm RemoteTalk cable",
      "Universal USB charging cable (USB-A to USB Micro-B)",
      "Quick Start Guide ",
    ],
    isLike: true,
    bgColor: Colors.red,
  ),
  ProudctItem(
    name: 'Beats Studio3 Wireless Headphones - NBA Collection - Lakers Purple',
    price: 349.95,
    path: '',
    features: [
      "Form Factor: Over ear",
      "Connections: Bluetooth, Wireless",
      "Bluetooth Compatibility: Bluetooth 4.0",
      "Power Source: Battery power",
      "Batteries: Rechargeable Lithium Ion",
    ],
    isLike: false,
    bgColor: Colors.purple,
  ),
];
