import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test1/bloc/main/main_cubit.dart';
import 'package:test1/local/shared_pref/cach_helper.dart';
import 'package:test1/screen/login_screen.dart';

import '../component/component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit , MainState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(Icons.light_mode , color: Colors.white,);
            }
            return const Icon(Icons.dark_mode);
          },
        );
        return Column(
          children: [
            SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: Theme.of(context).colorScheme.background
              ),
              darkTheme:  SettingsThemeData(
                  settingsListBackground: Theme.of(context).colorScheme.background
              ),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              sections: [
                SettingsSection(
                  title: Text("Settings",style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 25)),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.language ,color: Theme.of(context).colorScheme.primary,),
                      title: Text('Language' ,style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 20)),
                      value: Text('English'),
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        cubit.changeTheme();
                      },
                      initialValue: cubit.isDark,
                      leading: Icon(Icons.format_paint,color: Theme.of(context).colorScheme.primary,),
                      title: Text('Enable custom theme',style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 20)),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.person ,color: Theme.of(context).colorScheme.primary,),
                      title: Text('Add a new employee' ,style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 20)),
                      value: Text('Add User'),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.logout ,color: Theme.of(context).colorScheme.primary,),
                      title: Text('Logout' ,style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 20)),
                      trailing: Icon(Icons.arrow_forward_outlined ,color: Theme.of(context).colorScheme.primary,),
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:Text("LogOut",style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary )),
                              actions: [
                                Row(
                                  children: [
                                    Text("Are you sure to log out?",style:GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 20))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(onPressed:(){
                                      CacheHepler.removeData(key: "uId");
                                      cubit.currentIndex = 1 ;
                                      NavegatAndFinish(context , LoginScreen());
                                    }, child: Text("Yes")),
                                    ElevatedButton(onPressed:(){
                                      Navigator.pop(context);
                                    }, child: Text("No")),
                                  ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                )
                              ],
                            ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
