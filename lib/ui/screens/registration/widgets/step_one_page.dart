import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/ui/common/components/auth_page_template.dart';
import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:cubik_club/ui/screens/registration/widgets/back_button.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/cyrillic_only_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class StepOnePage extends StatelessWidget {
  const StepOnePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AuthPageTemplate(
            image: CCImages.accountCreateStep1,
            title: CCTexts.accountCreateStep1Title,
            subtitle: CCTexts.accountCreateStep1SubTitle,
            mainAction: _ContinueButton(),
            optionalAction: RegistrationBackButton(),
            body: [
              _NameTextField(),
              SizedBox(height: 20),
              _SurnameTextField(),
              SizedBox(height: 20),
              _GenderSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return ElevatedButton(
      onPressed: () => viewModel.onContinueButtonPressed(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text("Далее", textAlign: TextAlign.center),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return TextField(
      controller: viewModel.nameController,
      onChanged: (name) => viewModel.updateState(name: name),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
        CyrillicOnlyInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Имя',
      ),
    );
  }
}

class _SurnameTextField extends StatelessWidget {
  const _SurnameTextField();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return TextField(
      controller: viewModel.surnameController,
      onChanged: (surname) => viewModel.updateState(surname: surname),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
        CyrillicOnlyInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Фамилия',
      ),
    );
  }
}

class _GenderSwitch extends StatefulWidget {
  const _GenderSwitch();

  @override
  State<_GenderSwitch> createState() => _GenderSwitchState();
}

class _GenderSwitchState extends State<_GenderSwitch>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    final gender = context.read<RegistrationViewModel>().state.gender;
    final int tabIndex;

    switch (gender) {
      case Genders.male:
        tabIndex = 0;
        break;
      case Genders.female:
        tabIndex = 1;
        break;
      default:
        tabIndex = 2;
        break;
    }

    _tabController =
        TabController(length: 3, vsync: this, initialIndex: tabIndex);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TabBar(
            onTap: viewModel.onGenderTabChanged,
            controller: _tabController,
            dividerHeight: 0,
            labelPadding: EdgeInsets.zero,
            // overlayColor: MaterialStateProperty.all(Colors.transparent),
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: CCAppColors.primary,
            ),
            indicatorWeight: 1,
            // indicator: BoxDecoration(
            //   border: Border.all(
            //     color: CCAppColors.lightHighlightBackground,
            //     width: 1,
            //   ),
            //   borderRadius: const BorderRadius.all(Radius.circular(20)),
            // ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Мужчина'),
              Tab(text: 'Девушка'),
              Tab(text: 'Не важно'),
            ],
          ),
        ),
      ],
    );
  }
}
