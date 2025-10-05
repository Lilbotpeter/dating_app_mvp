import 'package:dating_china_app_mvp/core/extensions/dialog_context.dart';
import 'package:dating_china_app_mvp/core/theme/app_theme.dart';
import 'package:dating_china_app_mvp/core/widgets/loading_overlay.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_event.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final name = TextEditingController();
  final age = TextEditingController(text: '25');
  String gender = 'other';
  List<String> langs = ['th'];
  final genderItems = const [
    ('male', 'Male'),
    ('female', 'Female'),
    ('other', 'Other'),
  ];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context, listen: false).add(const ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('My Profile', style: Theme.of(context).textTheme.titleMedium),actions: [
        IconButton(
          onPressed: () => bloc.add(const ProfileRefreshed()),
          icon: const Icon(Icons.refresh),
           ),
        IconButton(
          onPressed: () => bloc.add(ProfileCleared()), 
          icon: const Icon(Icons.delete_outline))
      ],),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          if(state is ProfileError){
            await context.showErrorDialog(state.message);
          }
          if(state is ProfileLoaded){
            name.text = state.profile.displayName;
            age.text = state.profile.age.toString();
            gender = state.profile.gender;
            langs = List.of(state.profile.langs);
          }
          if(state is ProfileEmpty){
            name.text = '';
            age.text = '23';
            gender = 'other';
            langs = ['th'];
          }
        },
        builder: (context, state){
          final showOverlay = state is ProfileLoading;
          Widget content;
          if(state is ProfileError){
            content = Center(child: Text('Error: ${state.message}'),);
          }
          else{
            content = _form(context);
          }
          return LoadingOverlayWrapper(
            show: showOverlay,
            message: 'LOADING..',
            child: content,
            );
        }
        ),
    );
  }

  Widget _form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Display name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: gender,
            items: genderItems.map((i) {
              return DropdownMenuItem(
                value: i.$1,
                child: Text(
                  i.$2,
                ));
            }).toList(),
            onChanged: (v) => setState(() => gender = v ?? 'other'),
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['th', 'en', 'jp', 'cn'].map((l) {
              final selected = langs.contains(l);
              return FilterChip(
                label: Text(l.toUpperCase()),
                selected: selected,
                onSelected: (v) => setState(() {
                  if (v) langs.add(l); else langs.remove(l);
                }),
                selectedColor: AppPalette.primary,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () async {
              final success = await context.showConfirmDialog(
              title: 'ต้องการบันทึกข้อมูลใช่ไหม ?', 
              message: 'กดปุ่ม "ตกลง" เพื่อบันทึกข้อมูล');
            if(success == true) {
              await _save();
              Modular.to.navigate('/shell/profile');
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final profile = Profile(
      id: 'me',
      displayName: name.text.trim().isEmpty ? 'No Name' : name.text.trim(),
      age: int.tryParse(age.text.trim()) ?? 25,
      gender: gender,
      langs: List.of(langs),
      // avatarUrl: null,
      avatarUrl: 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg', //mock
      lat: null,
      lng: null,
      verified: false,
    );
      BlocProvider.of<ProfileBloc>(context, listen: false).add(ProfileSaved(profile));
  }
}