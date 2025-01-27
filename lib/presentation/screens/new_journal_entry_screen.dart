import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for Firestore
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/screens/entries_screen.dart';
import 'package:serenita/presentation/widgets/common/app_bar_custom.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/presentation/widgets/common/text_field_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class NewJournalEntryScreen extends StatefulWidget {
  const NewJournalEntryScreen({super.key});

  @override
  State<NewJournalEntryScreen> createState() => _NewJournalEntryScreenState();
}

class _NewJournalEntryScreenState extends State<NewJournalEntryScreen> {
  // Add controllers to capture text inputs
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Function to write data to Firestore
  Future<void> _createJournalEntry() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      // Write to Firestore with default values for mood, iconPath, and createdAt
      await FirebaseFirestore.instance.collection('Journals').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'mood': 'ANGRY', // Default mood
        'iconPath': 'assets/images/sad.png', // Default icon path
        'color': '#FF5722', // Default color
        'createdAt': FieldValue.serverTimestamp(), // Current timestamp
      });

      // Navigate to Entries Screen on success
      // ignore: use_build_context_synchronously
      context.push(const EntriesScreen());
    } catch (e) {
      // Show an error message if something goes wrong
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating journal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrownColor,
      appBar: AppBarCustom(
        title: 'New Journal Entry',
        titleColor: brownColor,
        backgroundColor: lightBrownColor,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: brownColor,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox12(),
          Padding(
            padding: spacing16,
            child: TextFieldCustom(
              controller: _titleController, // Attach the controller
              labelText: 'Journal Title',
              labelColor: brownColor,
              labelFontSize: 20.0,
              labelFontWeight: FontWeight.w800,
              showInputTitle: true,
              inputFillColor: whiteColor,
              borderRadius: 100.0,
              prefixIcon: const Icon(
                Icons.description_outlined,
                size: 20.0,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hasBorder: false,
            ),
          ),
          const SizedBox24(),
          _buildEmotionsField(),
          const SizedBox24(),
          _buildEntryField(), // Now included in the corrected version
          const SizedBox24(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ButtonCustom(
              borderRadius: 100.0,
              bgColor: brownColor,
              title: 'Create Journal',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              height: 60.0,
              iconData: Icons.check,
              iconColor: whiteColor,
              iconSize: 25.0,
              showLeftIcon: true,
              onPressed: _createJournalEntry, // Call the function to write data
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionsField() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'Select Your Emotion',
            style: size14weight700,
          ),
          const SizedBox6(),
          Image.asset('assets/images/emotions.png'),
        ],
      ),
    );
  }

  Widget _buildEntryField() {
    return Padding(
      padding: spacing16,
      child: TextFieldCustom(
        controller: _descriptionController, // Attach the controller
        labelText: 'Write your entry',
        placeholder: 'I had a bad day today, at school... It is fine I guess...',
        labelColor: brownColor,
        labelFontSize: 20.0,
        labelFontWeight: FontWeight.w800,
        showInputTitle: true,
        inputFillColor: whiteColor,
        borderRadius: 24.0,
        textFieldMaxLines: 10,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        borderColor: brownColor,
      ),
    );
  }
}
