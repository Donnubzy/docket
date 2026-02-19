
import 'package:docket/presentation/screens/settings.dart';
import 'package:docket/presentation/widgets/drawer_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(Icons.note)
          ),
         //const SizedBox(height: 20),
         DrawerTile(
             title: "Notes",
             leading: const Icon(Icons.home),
             onTap: () => Navigator.pop(context)
         ),
          DrawerTile(
              title: "Settings",
              leading: const Icon(Icons.settings),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              }
          ),
        ],
      ),
    );
  }
}
