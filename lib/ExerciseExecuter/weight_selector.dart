import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/my_colors.dart';
import 'package:provider/provider.dart';

const intervals5 = [30, 35, 40, 45];
class WeightSelectorScreen extends StatefulWidget {
  const WeightSelectorScreen({super.key, required this.index});
  final int index;

  @override
  State<WeightSelectorScreen> createState() => _WeightSelectorScreenState();
}

class _WeightSelectorScreenState extends State<WeightSelectorScreen> {
   
  final selectedIntervals = intervals5;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void newWeight(double newWeight) {
      Provider.of<SetInfo>(context, listen: false).changeWeight(newWeight, widget.index);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            children: [

              // TODO time interval-selector

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextFormField(
                    controller: controller,
                  //  keyboardType: TextInputType.phone,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: MyColors.primary),
                    decoration: const InputDecoration(
                        labelText: 'Special Value',
                        labelStyle: TextStyle(
                          color: MyColors.primary,
                        )),
                  ),
                  ElevatedButton(onPressed: (){
                    
                    // TODO: Save specially selected value
                    newWeight(double.parse(controller.text.replaceAll(',', '.')));
                      Navigator.pop(context);

                  }, child: const Text('Save'))
                ],
              )),

              Row(
                children: [
                  ElevatedButton(onPressed: (){}, child: const Text('1,25kg')),
                  ElevatedButton(onPressed: (){}, child: const Text('2,5kg')),
                  ElevatedButton(onPressed: (){}, child: const Text('5kg')),
                  ElevatedButton(onPressed: (){}, child: const Text('2,5kg')),
                ],
                
              ),

              ...selectedIntervals
                .map((e) => ElevatedButton(
                    onPressed: () {
                      newWeight(e.toDouble());
                      Navigator.pop(context, e);
                    },
                    child: Text(e.toString())))
                .toList()]
                ),
      ),
    );
  }
}
