import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_event.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'),actions: [
        IconButton(
          onPressed: () => context.read<ProfileBloc>().add(const ProfileRefreshed()),
          icon: const Icon(Icons.refresh),
           ),
        IconButton(
          onPressed: () => context.read<ProfileBloc>().add(ProfileCleared()), 
          icon: const Icon(Icons.delete_outline))
      ]),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state){
          if(state is ProfileError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
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
          if(state is ProfileLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is ProfileEmpty || state is ProfileLoaded){
            return _form(context);
          }
          if(state is ProfileError){
            return Center(child: Text('Error: ${state.message}'),);
          }
          return const SizedBox.shrink();
        },),
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
            items: const [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
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
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _save() {
    final profile = Profile(
      id: 'me',
      displayName: name.text.trim().isEmpty ? 'No Name' : name.text.trim(),
      age: int.tryParse(age.text.trim()) ?? 25,
      gender: gender,
      langs: List.of(langs),
      avatarUrl: null,
      lat: null,
      lng: null,
      verified: false,
    );
    context.read<ProfileBloc>().add(ProfileSaved(profile));
  }
}