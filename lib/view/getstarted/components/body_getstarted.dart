import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../home/screens/home_layout.dart';
import '../cubit/getstarted_cubit.dart';
import 'custom_text_field.dart';

class BodyStarted extends StatefulWidget {
  const BodyStarted({
    super.key,
  });

  @override
  State<BodyStarted> createState() => _BodyStartedState();
}

class _BodyStartedState extends State<BodyStarted> {
  @override
  Widget build(BuildContext context) {
    GetstartedCubit cubit = GetstartedCubit.get(context);
    return BlocListener<GetstartedCubit, GetstartedState>(
      listener: (context, state) {
        if (state is UploadFailure) {
          showErrorMessage(context, state).show();
        } else if (state is UploadLoading) {
          SmartDialog.showLoading();
        } else if (state is UploadSucess) {
          cubit.resetValues();
          SmartDialog.dismiss();
          Navigator.pushReplacementNamed(
            context,
            HomeLayoutScreen.routeName,
          );
        }
      },
      child: SafeArea(
        child: Form(
          key: cubit.key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                SvgPicture.asset(
                  'assets/icons/account.svg',
                  width: 20.w,
                  height: 20.h,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Tell us more about you',
                  style: TextStyle(fontSize: 24.sp),
                ),
                CustomTextField(
                  cn: cubit.userName,
                  title: 'UserName',
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  fieldFor: FieldFor.name,
                ),
                CustomTextField(
                  cn: cubit.age,
                  title: 'Age',
                  icon: Icons.person_2_outlined,
                  inputType: TextInputType.number,
                  fieldFor: FieldFor.age,
                ),
                CustomTextField(
                  cn: cubit.height,
                  title: 'Height',
                  icon: Icons.height,
                  inputType: TextInputType.number,
                  fieldFor: FieldFor.height,
                ),
                CustomTextField(
                  cn: cubit.weight,
                  title: 'Weight',
                  icon: Icons.line_weight,
                  inputType: TextInputType.number,
                  fieldFor: FieldFor.weight,
                ),
                dropDownButton(cubit),
                SizedBox(height: 3.h),
                buttonsSection(context, cubit)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AwesomeDialog showErrorMessage(BuildContext context, UploadFailure state) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: state.message,
      btnCancelOnPress: () {},
    );
  }

  Row buttonsSection(BuildContext context, GetstartedCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            showBottomSheetLocation(context, cubit);
          },
          child: const Text('Bring address'),
        ),
        ElevatedButton(
          onPressed: () async {
            await cubit.uploadData();
          },
          child: const Text('Done'),
        )
      ],
    );
  }

  PersistentBottomSheetController<void> showBottomSheetLocation(
      BuildContext context, GetstartedCubit cubit) {
    return showBottomSheet<void>(
        context: context,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
              height: 30.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.black26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${cubit.address.name}, ${cubit.address.country}, ${cubit.address.locality}, ${cubit.address.postalCode},'),
                  ElevatedButton.icon(
                    onPressed: () async {
                      var temp = await cubit.getCurrentLocation();
                      setState(() {
                        cubit.address = temp;
                      });
                    },
                    label: const Text('Locate Current Location'),
                    icon: const Icon(Icons.my_location),
                  )
                ],
              ),
            ),
          );
        });
  }

  Row dropDownButton(GetstartedCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton<String>(
          value: cubit.genderSelected,
          items: ['male', 'female'].map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              cubit.genderSelected = value!;
            });
          },
        ),
        DropdownButton<String>(
          value: cubit.levelSelected,
          items: ['beginner', 'intermediate', 'advanced']
              .map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              cubit.levelSelected = value!;
            });
          },
        ),
      ],
    );
  }
}
