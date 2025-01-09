import 'package:auto_size_text/auto_size_text.dart';
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
          const Padding(
            padding: spacing16,
            child: TextFieldCustom(
              labelText: 'Journal Title',
              labelColor: brownColor,
              labelFontSize: 14.0,
              labelFontWeight: FontWeight.w800,
              showInputTitle: true,
              inputFillColor: whiteColor,
              borderRadius: 100.0,
              prefixIcon: Icon(
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
          _buildEntryField(),
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
              onPressed: () => context.push(const EntriesScreen()),
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
    return const Padding(
      padding: spacing16,
      child: TextFieldCustom(
        labelText: 'Write your entry',
        placeholder: '',
        labelColor: brownColor,
        labelFontSize: 14.0,
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
