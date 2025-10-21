import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return popMenuButton();
  }

  Widget popMenuButton() {
    return PopupMenuButton<SampleItem>(
      position: PopupMenuPosition.over,
      color: Colors.white,
      initialValue: selectedItem,
      onSelected: (SampleItem item) {
        setState(() {
          selectedItem = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Item 1'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text('Item 2'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: Text('Item 3'),
        ),
      ],
    );
  }
}
