import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> listOfItems = [
    "Junior",
    "Senior",
    "Playgroup",
    "COMMON AREAS",
  ];
  String? selectedValue;
  int currentPageIndex=0;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Home"),
          NavigationDestination(icon: Icon(Icons.account_circle), label: "Home"),
        ],
        onDestinationSelected: (int index){

          setState(() {

            currentPageIndex =index;

          });

        },
      ),
        body: Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          const CustomTextWidget(
            text: Constants.previews,
            color: ConstantColors.blackColor,
            size: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 25,
          ),
          DropdownButtonHideUnderline(

            child: DropdownButton2<String>(

              isExpanded: true,
              isDense: true,


              hint: const Row(
                children: [

                  Expanded(
                    child: Text(
                      'Class',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: listOfItems
                  .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                height: 50,
                width: 200,
                padding: EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                 // borderRadius: BorderRadius.circular(5),
                  color: ConstantColors.buttonColor,
                ),
                elevation: 2,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                ),
                iconSize: 22,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                // maxHeight: 200,
                // width: 200,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(5),
                  color: ConstantColors.buttonColor,
                ),
                //offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  //radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all<double>(6),
                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,

                //padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),

          ),
          const SizedBox(height: 25,),

           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.buttonColor
                ),
                child:const Text(Constants.month),
              ),
              const SizedBox(width: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.buttonColor,
                ),
                onPressed: () {},
                child: const Text(Constants.date),
              ),



            ],
          ),


        ],
      ),

    ));
  }
}

