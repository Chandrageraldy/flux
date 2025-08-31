// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome back to Flux`
  String get loginScreenTitle {
    return Intl.message(
      'Welcome back to Flux',
      name: 'loginScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Smarter tracking for better results—log in and let AI help you stay on top of your diet!`
  String get loginScreenDesc {
    return Intl.message(
      'Smarter tracking for better results—log in and let AI help you stay on top of your diet!',
      name: 'loginScreenDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get Started with Flux`
  String get signUpScreenTitle {
    return Intl.message(
      'Get Started with Flux',
      name: 'signUpScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to start with Flux. Get meal plans, track nutrition, and evolve your pet!`
  String get signUpScreenDesc {
    return Intl.message(
      'Sign up to start with Flux. Get meal plans, track nutrition, and evolve your pet!',
      name: 'signUpScreenDesc',
      desc: '',
      args: [],
    );
  }

  /// `Your Smart Nutrition Assistant`
  String get onboardingTitle1 {
    return Intl.message(
      'Your Smart Nutrition Assistant',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Chat with our AI to create a meal plan that fits your goals.`
  String get onboardingDesc1 {
    return Intl.message(
      'Chat with our AI to create a meal plan that fits your goals.',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `AI Meal Scan: Track Smarter`
  String get onboardingTitle2 {
    return Intl.message(
      'AI Meal Scan: Track Smarter',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Use our advanced AI-powered meal scanner to effortlessly log your meals.`
  String get onboardingDesc2 {
    return Intl.message(
      'Use our advanced AI-powered meal scanner to effortlessly log your meals.',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Up. Friend Up. Level Up`
  String get onboardingTitle3 {
    return Intl.message(
      'Fuel Up. Friend Up. Level Up',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Fuel your progress, unlock new rewards, and watch your virtual pet thrive.`
  String get onboardingDesc3 {
    return Intl.message(
      'Fuel your progress, unlock new rewards, and watch your virtual pet thrive.',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get loginPrimarySpanText {
    return Intl.message(
      'Already have an account? ',
      name: 'loginPrimarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get loginSecondarySpanText {
    return Intl.message(
      'Log In',
      name: 'loginSecondarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account yet? `
  String get signUpPrimarySpanText {
    return Intl.message(
      'Don’t have an account yet? ',
      name: 'signUpPrimarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpSecondarySpanText {
    return Intl.message(
      'Sign Up',
      name: 'signUpSecondarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordLabel {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `How Should We Build Your Plan?`
  String get planSelectionTitle {
    return Intl.message(
      'How Should We Build Your Plan?',
      name: 'planSelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose to build your plan step-by-step or let AI design one based on your goals.`
  String get planSelectionDesc {
    return Intl.message(
      'Choose to build your plan step-by-step or let AI design one based on your goals.',
      name: 'planSelectionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStartedLabel {
    return Intl.message(
      'Get Started',
      name: 'getStartedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileLabel {
    return Intl.message(
      'Profile',
      name: 'profileLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editLabel {
    return Intl.message(
      'Edit',
      name: 'editLabel',
      desc: '',
      args: [],
    );
  }

  /// `Meal Ratio`
  String get mealRatioLabel {
    return Intl.message(
      'Meal Ratio',
      name: 'mealRatioLabel',
      desc: '',
      args: [],
    );
  }

  /// `Years`
  String get yearsLabel {
    return Intl.message(
      'Years',
      name: 'yearsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Manual Custom Plan`
  String get planSelectionButtonTitle1 {
    return Intl.message(
      'Manual Custom Plan',
      name: 'planSelectionButtonTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Answer questions and customize your own journey.`
  String get planSelectionButtonDesc1 {
    return Intl.message(
      'Answer questions and customize your own journey.',
      name: 'planSelectionButtonDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Smart Plan with AI`
  String get planSelectionButtonTitle2 {
    return Intl.message(
      'Smart Plan with AI',
      name: 'planSelectionButtonTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Describe your body and goals — let AI build your perfect plan.`
  String get planSelectionButtonDesc2 {
    return Intl.message(
      'Describe your body and goals — let AI build your perfect plan.',
      name: 'planSelectionButtonDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Log Food`
  String get loggingSelectionButtonTitle1 {
    return Intl.message(
      'Log Food',
      name: 'loggingSelectionButtonTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Search and select your food, then enter the portion.`
  String get loggingSelectionButtonDesc1 {
    return Intl.message(
      'Search and select your food, then enter the portion.',
      name: 'loggingSelectionButtonDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Meal Scan`
  String get loggingSelectionButtonTitle2 {
    return Intl.message(
      'Meal Scan',
      name: 'loggingSelectionButtonTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Snap a quick photo — we’ll handle the rest.`
  String get loggingSelectionButtonDesc2 {
    return Intl.message(
      'Snap a quick photo — we’ll handle the rest.',
      name: 'loggingSelectionButtonDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Scan Barcode`
  String get loggingSelectionButtonTitle3 {
    return Intl.message(
      'Scan Barcode',
      name: 'loggingSelectionButtonTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Scan a barcode to log packaged food instantly.`
  String get loggingSelectionButtonDesc3 {
    return Intl.message(
      'Scan a barcode to log packaged food instantly.',
      name: 'loggingSelectionButtonDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message(
      'Continue',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get okLabel {
    return Intl.message(
      'Ok',
      name: 'okLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get selectLabel {
    return Intl.message(
      'Select',
      name: 'selectLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get loginLabel {
    return Intl.message(
      'Log in',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpLabel {
    return Intl.message(
      'Sign Up',
      name: 'signUpLabel',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOutLabel {
    return Intl.message(
      'Log Out',
      name: 'logOutLabel',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get usernameLabel {
    return Intl.message(
      'Username',
      name: 'usernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tell Us About You`
  String get planQuestion1 {
    return Intl.message(
      'Tell Us About You',
      name: 'planQuestion1',
      desc: '',
      args: [],
    );
  }

  /// `Share your gender, weight, height, and birth date — so we can create your perfect plan.`
  String get planDescription1 {
    return Intl.message(
      'Share your gender, weight, height, and birth date — so we can create your perfect plan.',
      name: 'planDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Set Your Target Weight`
  String get planQuestion2 {
    return Intl.message(
      'Set Your Target Weight',
      name: 'planQuestion2',
      desc: '',
      args: [],
    );
  }

  /// `Tell us your goal weight so we can guide your progress and adjust your plan as you move toward it.`
  String get planDescription2 {
    return Intl.message(
      'Tell us your goal weight so we can guide your progress and adjust your plan as you move toward it.',
      name: 'planDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Weekly Weight Gain`
  String get planQuestion3 {
    return Intl.message(
      'Choose Your Weekly Weight Gain',
      name: 'planQuestion3',
      desc: '',
      args: [],
    );
  }

  /// `Set your preferred weight gain pace — from a slow and steady 0.1 kg to a more aggressive 1.0 kg per week.`
  String get planDescription3 {
    return Intl.message(
      'Set your preferred weight gain pace — from a slow and steady 0.1 kg to a more aggressive 1.0 kg per week.',
      name: 'planDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Describe Your Daily Activity`
  String get planQuestion4 {
    return Intl.message(
      'Describe Your Daily Activity',
      name: 'planQuestion4',
      desc: '',
      args: [],
    );
  }

  /// `Tell us how active you are throughout the day — this includes movement during work, school, or at home.`
  String get planDescription4 {
    return Intl.message(
      'Tell us how active you are throughout the day — this includes movement during work, school, or at home.',
      name: 'planDescription4',
      desc: '',
      args: [],
    );
  }

  /// `How Often Do You Exercise?`
  String get planQuestion5 {
    return Intl.message(
      'How Often Do You Exercise?',
      name: 'planQuestion5',
      desc: '',
      args: [],
    );
  }

  /// `Let us know your weekly workout habits so we can fine-tune your plan to match your training level.`
  String get planDescription5 {
    return Intl.message(
      'Let us know your weekly workout habits so we can fine-tune your plan to match your training level.',
      name: 'planDescription5',
      desc: '',
      args: [],
    );
  }

  /// `What’s Your Diet Preference?`
  String get planQuestion6 {
    return Intl.message(
      'What’s Your Diet Preference?',
      name: 'planQuestion6',
      desc: '',
      args: [],
    );
  }

  /// `Choose the diet type that best fits your lifestyle. We'll use this to tailor your calorie and macronutrient goals.`
  String get planDescription6 {
    return Intl.message(
      'Choose the diet type that best fits your lifestyle. We\'ll use this to tailor your calorie and macronutrient goals.',
      name: 'planDescription6',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderLabel {
    return Intl.message(
      'Gender',
      name: 'genderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Used to personalize your health and calorie estimates.`
  String get genderDesc {
    return Intl.message(
      'Used to personalize your health and calorie estimates.',
      name: 'genderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get maleLabel {
    return Intl.message(
      'Male',
      name: 'maleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get femaleLabel {
    return Intl.message(
      'Female',
      name: 'femaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get heightLabel {
    return Intl.message(
      'Height',
      name: 'heightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Helps calculate your body mass index (BMI).`
  String get heightDesc {
    return Intl.message(
      'Helps calculate your body mass index (BMI).',
      name: 'heightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weightLabel {
    return Intl.message(
      'Weight',
      name: 'weightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Used to determine your daily calorie needs.`
  String get weightDesc {
    return Intl.message(
      'Used to determine your daily calorie needs.',
      name: 'weightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirthLabel {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirthLabel',
      desc: '',
      args: [],
    );
  }

  /// `We use your age to estimate your metabolic rate.`
  String get dateOfBirthDesc {
    return Intl.message(
      'We use your age to estimate your metabolic rate.',
      name: 'dateOfBirthDesc',
      desc: '',
      args: [],
    );
  }

  /// `Target Weight`
  String get targetWeightLabel {
    return Intl.message(
      'Target Weight',
      name: 'targetWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Set your goal weight — if it’s higher, we’ll help you gain; if lower, lose; if the same, maintain.`
  String get targetWeightDesc {
    return Intl.message(
      'Set your goal weight — if it’s higher, we’ll help you gain; if lower, lose; if the same, maintain.',
      name: 'targetWeightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Target Weekly Change`
  String get targetWeightWeeklyLabel {
    return Intl.message(
      'Target Weekly Change',
      name: 'targetWeightWeeklyLabel',
      desc: '',
      args: [],
    );
  }

  /// `0.1–0.2 kg: slow change, minimal fat | 0.25–0.4 kg: balanced & recommended | 0.45–0.6 kg: fast change, more aggressive | 0.65–1.0 kg: very aggressive, higher fat risk`
  String get targetWeightWeeklyDesc {
    return Intl.message(
      '0.1–0.2 kg: slow change, minimal fat | 0.25–0.4 kg: balanced & recommended | 0.45–0.6 kg: fast change, more aggressive | 0.65–1.0 kg: very aggressive, higher fat risk',
      name: 'targetWeightWeeklyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Sedentary`
  String get sedentaryLabel {
    return Intl.message(
      'Sedentary',
      name: 'sedentaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Mostly sitting all day (e.g., desk job, little movement).`
  String get sedentaryDesc {
    return Intl.message(
      'Mostly sitting all day (e.g., desk job, little movement).',
      name: 'sedentaryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Lightly Active`
  String get lightlyActiveLabel {
    return Intl.message(
      'Lightly Active',
      name: 'lightlyActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Occasional walking or standing (e.g., teacher, short walks).`
  String get lightlyActiveDesc {
    return Intl.message(
      'Occasional walking or standing (e.g., teacher, short walks).',
      name: 'lightlyActiveDesc',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get activeLabel {
    return Intl.message(
      'Active',
      name: 'activeLabel',
      desc: '',
      args: [],
    );
  }

  /// `On your feet most of the day (e.g., retail, light labor).`
  String get activeDesc {
    return Intl.message(
      'On your feet most of the day (e.g., retail, light labor).',
      name: 'activeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Very Active`
  String get veryActiveLabel {
    return Intl.message(
      'Very Active',
      name: 'veryActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Physically demanding job or lots of daily movement.`
  String get veryActiveDesc {
    return Intl.message(
      'Physically demanding job or lots of daily movement.',
      name: 'veryActiveDesc',
      desc: '',
      args: [],
    );
  }

  /// `Never`
  String get neverLabel {
    return Intl.message(
      'Never',
      name: 'neverLabel',
      desc: '',
      args: [],
    );
  }

  /// `I don’t work out regularly.`
  String get neverDesc {
    return Intl.message(
      'I don’t work out regularly.',
      name: 'neverDesc',
      desc: '',
      args: [],
    );
  }

  /// `1–2 times/week`
  String get lightLabel {
    return Intl.message(
      '1–2 times/week',
      name: 'lightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Light or occasional workouts.`
  String get lightDesc {
    return Intl.message(
      'Light or occasional workouts.',
      name: 'lightDesc',
      desc: '',
      args: [],
    );
  }

  /// `3–4 times/week`
  String get moderateLabel {
    return Intl.message(
      '3–4 times/week',
      name: 'moderateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Consistent workouts on most weekdays.`
  String get moderateDesc {
    return Intl.message(
      'Consistent workouts on most weekdays.',
      name: 'moderateDesc',
      desc: '',
      args: [],
    );
  }

  /// `5+ times/week`
  String get frequentLabel {
    return Intl.message(
      '5+ times/week',
      name: 'frequentLabel',
      desc: '',
      args: [],
    );
  }

  /// `I work out almost every day.`
  String get frequentDesc {
    return Intl.message(
      'I work out almost every day.',
      name: 'frequentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Balanced`
  String get balancedLabel {
    return Intl.message(
      'Balanced',
      name: 'balancedLabel',
      desc: '',
      args: [],
    );
  }

  /// `A balanced diet with a variety of foods.`
  String get balancedDesc {
    return Intl.message(
      'A balanced diet with a variety of foods.',
      name: 'balancedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Keto`
  String get ketoLabel {
    return Intl.message(
      'Keto',
      name: 'ketoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Low-carb, high-fat diet for weight loss.`
  String get ketoDesc {
    return Intl.message(
      'Low-carb, high-fat diet for weight loss.',
      name: 'ketoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mediterranean`
  String get mediterraneanLabel {
    return Intl.message(
      'Mediterranean',
      name: 'mediterraneanLabel',
      desc: '',
      args: [],
    );
  }

  /// `Plant-rich healthy fats.`
  String get mediterraneanDesc {
    return Intl.message(
      'Plant-rich healthy fats.',
      name: 'mediterraneanDesc',
      desc: '',
      args: [],
    );
  }

  /// `Paleo`
  String get paleoLabel {
    return Intl.message(
      'Paleo',
      name: 'paleoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Based on foods eaten by early humans.`
  String get paleoDesc {
    return Intl.message(
      'Based on foods eaten by early humans.',
      name: 'paleoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Vegetarian`
  String get vegetarianLabel {
    return Intl.message(
      'Vegetarian',
      name: 'vegetarianLabel',
      desc: '',
      args: [],
    );
  }

  /// `A diet that excludes meat and fish.`
  String get vegetarianDesc {
    return Intl.message(
      'A diet that excludes meat and fish.',
      name: 'vegetarianDesc',
      desc: '',
      args: [],
    );
  }

  /// `Low Carbs`
  String get lowCarbsLabel {
    return Intl.message(
      'Low Carbs',
      name: 'lowCarbsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Low-carb, high-protein diet.`
  String get lowCarbsDesc {
    return Intl.message(
      'Low-carb, high-protein diet.',
      name: 'lowCarbsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get customLabel {
    return Intl.message(
      'Custom',
      name: 'customLabel',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progressLabel {
    return Intl.message(
      'Progress',
      name: 'progressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Diary`
  String get diaryLabel {
    return Intl.message(
      'Diary',
      name: 'diaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get foodLabel {
    return Intl.message(
      'Food',
      name: 'foodLabel',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get moreLabel {
    return Intl.message(
      'More',
      name: 'moreLabel',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get englishLabel {
    return Intl.message(
      'English',
      name: 'englishLabel',
      desc: '',
      args: [],
    );
  }

  /// `Simplified chinese`
  String get simplifiedChineseLabel {
    return Intl.message(
      'Simplified chinese',
      name: 'simplifiedChineseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Oops, something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Oops, something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `The password you entered is too weak. Please choose a stronger password.`
  String get weakPassword {
    return Intl.message(
      'The password you entered is too weak. Please choose a stronger password.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `This email address is already in use. Please use a different email.`
  String get usedEmail {
    return Intl.message(
      'This email address is already in use. Please use a different email.',
      name: 'usedEmail',
      desc: '',
      args: [],
    );
  }

  /// `The email or password you entered is incorrect. Please try again.`
  String get invalidCredential {
    return Intl.message(
      'The email or password you entered is incorrect. Please try again.',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `Session Expired or User is not Authenticated, Please Login Again.`
  String get permissionDenied {
    return Intl.message(
      'Session Expired or User is not Authenticated, Please Login Again.',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `There was an error with your request. Please try again later.`
  String get requestError {
    return Intl.message(
      'There was an error with your request. Please try again later.',
      name: 'requestError',
      desc: '',
      args: [],
    );
  }

  /// `We have blocked all requests from this device due to unusual activity. Try again later.`
  String get tooManyRequests {
    return Intl.message(
      'We have blocked all requests from this device due to unusual activity. Try again later.',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Search foods...`
  String get searchFoodPlaceholder {
    return Intl.message(
      'Search foods...',
      name: 'searchFoodPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get allLabel {
    return Intl.message(
      'All',
      name: 'allLabel',
      desc: '',
      args: [],
    );
  }

  /// `My Meals`
  String get myMealsLabel {
    return Intl.message(
      'My Meals',
      name: 'myMealsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get savedLabel {
    return Intl.message(
      'Saved',
      name: 'savedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Scan a barcode`
  String get scanABarcodeLabel {
    return Intl.message(
      'Scan a barcode',
      name: 'scanABarcodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Scan a meal`
  String get scanAMealLabel {
    return Intl.message(
      'Scan a meal',
      name: 'scanAMealLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe a meal`
  String get describeAMealLabel {
    return Intl.message(
      'Describe a meal',
      name: 'describeAMealLabel',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantityLabel {
    return Intl.message(
      'Quantity',
      name: 'quantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Serving Unit`
  String get servingUnitLabel {
    return Intl.message(
      'Serving Unit',
      name: 'servingUnitLabel',
      desc: '',
      args: [],
    );
  }

  /// `Meal Type`
  String get mealTypeLabel {
    return Intl.message(
      'Meal Type',
      name: 'mealTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast`
  String get breakfastLabel {
    return Intl.message(
      'Breakfast',
      name: 'breakfastLabel',
      desc: '',
      args: [],
    );
  }

  /// `Lunch`
  String get lunchLabel {
    return Intl.message(
      'Lunch',
      name: 'lunchLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dinner`
  String get dinnerLabel {
    return Intl.message(
      'Dinner',
      name: 'dinnerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Snack`
  String get snackLabel {
    return Intl.message(
      'Snack',
      name: 'snackLabel',
      desc: '',
      args: [],
    );
  }

  /// `kcal`
  String get calorieUnit {
    return Intl.message(
      'kcal',
      name: 'calorieUnit',
      desc: '',
      args: [],
    );
  }

  /// `Log Food`
  String get logFoodLabel {
    return Intl.message(
      'Log Food',
      name: 'logFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nutritional Information`
  String get nutritionalInformationLabel {
    return Intl.message(
      'Nutritional Information',
      name: 'nutritionalInformationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get goalLabel {
    return Intl.message(
      'Goal',
      name: 'goalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Logged`
  String get loggedLabel {
    return Intl.message(
      'Logged',
      name: 'loggedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Remaining = Goal - Logged`
  String get calorieFormula {
    return Intl.message(
      'Remaining = Goal - Logged',
      name: 'calorieFormula',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remainingLabel {
    return Intl.message(
      'Remaining',
      name: 'remainingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Macronutrients`
  String get macronutrientsLabel {
    return Intl.message(
      'Macronutrients',
      name: 'macronutrientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Targets`
  String get targetsLabel {
    return Intl.message(
      'Targets',
      name: 'targetsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Logged Meals`
  String get loggedMealsLabel {
    return Intl.message(
      'Logged Meals',
      name: 'loggedMealsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hang tight! We're crafting a personalized plan just for you.`
  String get personalizingYourPlanLoadingText {
    return Intl.message(
      'Hang tight! We\'re crafting a personalized plan just for you.',
      name: 'personalizingYourPlanLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `Hang tight! We're updating your personalized plan.`
  String get updateYourPlanLoadingText {
    return Intl.message(
      'Hang tight! We\'re updating your personalized plan.',
      name: 'updateYourPlanLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `Calorie`
  String get calorieLabel {
    return Intl.message(
      'Calorie',
      name: 'calorieLabel',
      desc: '',
      args: [],
    );
  }

  /// `Protein`
  String get proteinLabel {
    return Intl.message(
      'Protein',
      name: 'proteinLabel',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fatLabel {
    return Intl.message(
      'Fat',
      name: 'fatLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carbs`
  String get carbsLabel {
    return Intl.message(
      'Carbs',
      name: 'carbsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calcium`
  String get calciumLabel {
    return Intl.message(
      'Calcium',
      name: 'calciumLabel',
      desc: '',
      args: [],
    );
  }

  /// `Iron`
  String get ironLabel {
    return Intl.message(
      'Iron',
      name: 'ironLabel',
      desc: '',
      args: [],
    );
  }

  /// `Magnesium`
  String get magnesiumLabel {
    return Intl.message(
      'Magnesium',
      name: 'magnesiumLabel',
      desc: '',
      args: [],
    );
  }

  /// `Phosphorus`
  String get phosphorusLabel {
    return Intl.message(
      'Phosphorus',
      name: 'phosphorusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Potassium`
  String get potassiumLabel {
    return Intl.message(
      'Potassium',
      name: 'potassiumLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sodium`
  String get sodiumLabel {
    return Intl.message(
      'Sodium',
      name: 'sodiumLabel',
      desc: '',
      args: [],
    );
  }

  /// `Zinc`
  String get zincLabel {
    return Intl.message(
      'Zinc',
      name: 'zincLabel',
      desc: '',
      args: [],
    );
  }

  /// `Copper`
  String get copperLabel {
    return Intl.message(
      'Copper',
      name: 'copperLabel',
      desc: '',
      args: [],
    );
  }

  /// `Manganese`
  String get manganeseLabel {
    return Intl.message(
      'Manganese',
      name: 'manganeseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Selenium`
  String get seleniumLabel {
    return Intl.message(
      'Selenium',
      name: 'seleniumLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin A`
  String get vitaminALabel {
    return Intl.message(
      'Vitamin A',
      name: 'vitaminALabel',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin E`
  String get vitaminELabel {
    return Intl.message(
      'Vitamin E',
      name: 'vitaminELabel',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin D`
  String get vitaminDLabel {
    return Intl.message(
      'Vitamin D',
      name: 'vitaminDLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin C`
  String get vitaminCLabel {
    return Intl.message(
      'Vitamin C',
      name: 'vitaminCLabel',
      desc: '',
      args: [],
    );
  }

  /// `Thiamin`
  String get thiaminLabel {
    return Intl.message(
      'Thiamin',
      name: 'thiaminLabel',
      desc: '',
      args: [],
    );
  }

  /// `Riboflavin`
  String get riboflavinLabel {
    return Intl.message(
      'Riboflavin',
      name: 'riboflavinLabel',
      desc: '',
      args: [],
    );
  }

  /// `Niacin`
  String get niacinLabel {
    return Intl.message(
      'Niacin',
      name: 'niacinLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin B6`
  String get vitaminB6Label {
    return Intl.message(
      'Vitamin B6',
      name: 'vitaminB6Label',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin B12`
  String get vitaminB12Label {
    return Intl.message(
      'Vitamin B12',
      name: 'vitaminB12Label',
      desc: '',
      args: [],
    );
  }

  /// `Choline`
  String get cholineLabel {
    return Intl.message(
      'Choline',
      name: 'cholineLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin K`
  String get vitaminKLabel {
    return Intl.message(
      'Vitamin K',
      name: 'vitaminKLabel',
      desc: '',
      args: [],
    );
  }

  /// `Folate`
  String get folateLabel {
    return Intl.message(
      'Folate',
      name: 'folateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save Your Food`
  String get saveYourFoodLabel {
    return Intl.message(
      'Save Your Food',
      name: 'saveYourFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tap the bookmark icon on any food detail page to save your favorite foods here for easy access.`
  String get saveYourFoodDesc {
    return Intl.message(
      'Tap the bookmark icon on any food detail page to save your favorite foods here for easy access.',
      name: 'saveYourFoodDesc',
      desc: '',
      args: [],
    );
  }

  /// `Scan Your Meal`
  String get scanYourMealLabel {
    return Intl.message(
      'Scan Your Meal',
      name: 'scanYourMealLabel',
      desc: '',
      args: [],
    );
  }

  /// `Make sure your meal fits in the frame`
  String get scanYourMealDesc {
    return Intl.message(
      'Make sure your meal fits in the frame',
      name: 'scanYourMealDesc',
      desc: '',
      args: [],
    );
  }

  /// `Diet`
  String get dietLabel {
    return Intl.message(
      'Diet',
      name: 'dietLabel',
      desc: '',
      args: [],
    );
  }

  /// `Personal Details`
  String get personalDetailsLabel {
    return Intl.message(
      'Personal Details',
      name: 'personalDetailsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get accountLabel {
    return Intl.message(
      'Account',
      name: 'accountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hiLabel {
    return Intl.message(
      'Hi',
      name: 'hiLabel',
      desc: '',
      args: [],
    );
  }

  /// `Adjust Macronutrients Ratio`
  String get adjustMacroNutrientsLabel {
    return Intl.message(
      'Adjust Macronutrients Ratio',
      name: 'adjustMacroNutrientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carbs, fat, and protein`
  String get adjustMacroNutrientsDesc {
    return Intl.message(
      'Carbs, fat, and protein',
      name: 'adjustMacroNutrientsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Adjust Calorie Intake`
  String get adjustCalorieIntakeLabel {
    return Intl.message(
      'Adjust Calorie Intake',
      name: 'adjustCalorieIntakeLabel',
      desc: '',
      args: [],
    );
  }

  /// `kcal/day`
  String get adjustCalorieIntakeDesc {
    return Intl.message(
      'kcal/day',
      name: 'adjustCalorieIntakeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Diet Type`
  String get dietTypeLabel {
    return Intl.message(
      'Diet Type',
      name: 'dietTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Diet type will adjust the ratio of carbs, protein, and fat.`
  String get dietTypeDesc {
    return Intl.message(
      'Diet type will adjust the ratio of carbs, protein, and fat.',
      name: 'dietTypeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast, lunch, dinner, and snacks`
  String get mealRatioDesc {
    return Intl.message(
      'Breakfast, lunch, dinner, and snacks',
      name: 'mealRatioDesc',
      desc: '',
      args: [],
    );
  }

  /// `Modify the distribution of calories between breakfast, lunch, dinner, and snacks.`
  String get mealRatioDesc2 {
    return Intl.message(
      'Modify the distribution of calories between breakfast, lunch, dinner, and snacks.',
      name: 'mealRatioDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Want to start fresh?`
  String get wantToStartFreshLabel {
    return Intl.message(
      'Want to start fresh?',
      name: 'wantToStartFreshLabel',
      desc: '',
      args: [],
    );
  }

  /// `Generate a new personalized plan`
  String get wantToStartFreshDesc {
    return Intl.message(
      'Generate a new personalized plan',
      name: 'wantToStartFreshDesc',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get generateLabel {
    return Intl.message(
      'Generate',
      name: 'generateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfoLabel {
    return Intl.message(
      'Personal Info',
      name: 'personalInfoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Plan Customization`
  String get planCustomizationLabel {
    return Intl.message(
      'Plan Customization',
      name: 'planCustomizationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Locating Barcode`
  String get locatingBarcodeLabel {
    return Intl.message(
      'Locating Barcode',
      name: 'locatingBarcodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Align the barcode within the frame to scan`
  String get locatingBarcodeDesc {
    return Intl.message(
      'Align the barcode within the frame to scan',
      name: 'locatingBarcodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Barcode not recognized`
  String get barcodeNotRecognizedLabel {
    return Intl.message(
      'Barcode not recognized',
      name: 'barcodeNotRecognizedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we couldn’t find that barcode in our database. Please try another one :(`
  String get barcodeNotRecognizedDesc {
    return Intl.message(
      'Sorry, we couldn’t find that barcode in our database. Please try another one :(',
      name: 'barcodeNotRecognizedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgainLabel {
    return Intl.message(
      'Try Again',
      name: 'tryAgainLabel',
      desc: '',
      args: [],
    );
  }

  /// `Use AI Meal Scan`
  String get useAiMealScanLabel {
    return Intl.message(
      'Use AI Meal Scan',
      name: 'useAiMealScanLabel',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get ageLabel {
    return Intl.message(
      'Age',
      name: 'ageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Activity Level`
  String get activityLevelLabel {
    return Intl.message(
      'Activity Level',
      name: 'activityLevelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Level`
  String get exerciseLevelLabel {
    return Intl.message(
      'Exercise Level',
      name: 'exerciseLevelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Body Mass Index (BMI)`
  String get bmiLabel {
    return Intl.message(
      'Body Mass Index (BMI)',
      name: 'bmiLabel',
      desc: '',
      args: [],
    );
  }

  /// `Underweight`
  String get underweightLabel {
    return Intl.message(
      'Underweight',
      name: 'underweightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Normal weight`
  String get normalWeightLabel {
    return Intl.message(
      'Normal weight',
      name: 'normalWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Overweight`
  String get overweightLabel {
    return Intl.message(
      'Overweight',
      name: 'overweightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Obesity`
  String get obesityLabel {
    return Intl.message(
      'Obesity',
      name: 'obesityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmLabel {
    return Intl.message(
      'Confirm',
      name: 'confirmLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition Goals`
  String get nutritionGoalsLabel {
    return Intl.message(
      'Nutrition Goals',
      name: 'nutritionGoalsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Energy Target`
  String get energyTargetLabel {
    return Intl.message(
      'Energy Target',
      name: 'energyTargetLabel',
      desc: '',
      args: [],
    );
  }

  /// `This is your recommended daily energy intake to meet your goal.`
  String get energyTargetDesc {
    return Intl.message(
      'This is your recommended daily energy intake to meet your goal.',
      name: 'energyTargetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Basal Metabolic Rate (BMR)`
  String get basalMetabolicRateLabel {
    return Intl.message(
      'Basal Metabolic Rate (BMR)',
      name: 'basalMetabolicRateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Daily Energy Expenditure (TDEE)`
  String get totalDailyEnergyExpenditureLabel {
    return Intl.message(
      'Total Daily Energy Expenditure (TDEE)',
      name: 'totalDailyEnergyExpenditureLabel',
      desc: '',
      args: [],
    );
  }

  /// `Percent of Total Energy`
  String get percentTotalEnergyLabel {
    return Intl.message(
      'Percent of Total Energy',
      name: 'percentTotalEnergyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Baseline Activity`
  String get baselineActivityLabel {
    return Intl.message(
      'Baseline Activity',
      name: 'baselineActivityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Adjustment Based on Weight Goal`
  String get adjustmentBasedOnWeightGoalLabel {
    return Intl.message(
      'Adjustment Based on Weight Goal',
      name: 'adjustmentBasedOnWeightGoalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Macronutrients Target`
  String get macroNutrientsTargetLabel {
    return Intl.message(
      'Macronutrients Target',
      name: 'macroNutrientsTargetLabel',
      desc: '',
      args: [],
    );
  }

  /// `Percent of Total Meal Ratio`
  String get percentOfTotalMealRatioLabel {
    return Intl.message(
      'Percent of Total Meal Ratio',
      name: 'percentOfTotalMealRatioLabel',
      desc: '',
      args: [],
    );
  }

  /// `No results found.`
  String get noResultFoundLabel {
    return Intl.message(
      'No results found.',
      name: 'noResultFoundLabel',
      desc: '',
      args: [],
    );
  }

  /// `No recent items.`
  String get noRecentItemsLabel {
    return Intl.message(
      'No recent items.',
      name: 'noRecentItemsLabel',
      desc: '',
      args: [],
    );
  }

  /// `No results. Check the spelling and try again. Or create your own food listing.`
  String get noResultFoundMessage {
    return Intl.message(
      'No results. Check the spelling and try again. Or create your own food listing.',
      name: 'noResultFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `You haven’t viewed any food items yet. Start searching to add items here.`
  String get noRecentItemsMessage {
    return Intl.message(
      'You haven’t viewed any food items yet. Start searching to add items here.',
      name: 'noRecentItemsMessage',
      desc: '',
      args: [],
    );
  }

  /// `The total must equal 100%. Please adjust the values.`
  String get ratioErrorMessage {
    return Intl.message(
      'The total must equal 100%. Please adjust the values.',
      name: 'ratioErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Target Weekly Change`
  String get targetWeeklyChangeLabel {
    return Intl.message(
      'Target Weekly Change',
      name: 'targetWeeklyChangeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Weight Goal`
  String get weightGoalLabel {
    return Intl.message(
      'Weight Goal',
      name: 'weightGoalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Weekly change is enabled when current and target weights differ, indicating a goal to maintain, lose, or gain.`
  String get weightGoalDesc {
    return Intl.message(
      'Weekly change is enabled when current and target weights differ, indicating a goal to maintain, lose, or gain.',
      name: 'weightGoalDesc',
      desc: '',
      args: [],
    );
  }

  /// `Meal Scan`
  String get mealScanLabel {
    return Intl.message(
      'Meal Scan',
      name: 'mealScanLabel',
      desc: '',
      args: [],
    );
  }

  /// `Barcode`
  String get barcodeLabel {
    return Intl.message(
      'Barcode',
      name: 'barcodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enhance with AI`
  String get enhanceWithAILabel {
    return Intl.message(
      'Enhance with AI',
      name: 'enhanceWithAILabel',
      desc: '',
      args: [],
    );
  }

  /// `Let Flux AI add ingredients, adjust portions, and make thoughtful changes to improve your meals.`
  String get enhanceWithAIDesc {
    return Intl.message(
      'Let Flux AI add ingredients, adjust portions, and make thoughtful changes to improve your meals.',
      name: 'enhanceWithAIDesc',
      desc: '',
      args: [],
    );
  }

  /// `AI's Nutrition Score`
  String get nutritionScoreLabel {
    return Intl.message(
      'AI\'s Nutrition Score',
      name: 'nutritionScoreLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveLabel {
    return Intl.message(
      'Save',
      name: 'saveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredientsLabel {
    return Intl.message(
      'Ingredients',
      name: 'ingredientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Food`
  String get editFoodLabel {
    return Intl.message(
      'Edit Food',
      name: 'editFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Surplus`
  String get surplusLabel {
    return Intl.message(
      'Surplus',
      name: 'surplusLabel',
      desc: '',
      args: [],
    );
  }

  /// `No Meals Logged`
  String get noMealsLoggedLabel {
    return Intl.message(
      'No Meals Logged',
      name: 'noMealsLoggedLabel',
      desc: '',
      args: [],
    );
  }

  /// `You have not logged any meals yet. Start tracking your meals by pressing the + button.`
  String get noMealsLoggedDesc {
    return Intl.message(
      'You have not logged any meals yet. Start tracking your meals by pressing the + button.',
      name: 'noMealsLoggedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Highlighted Micro`
  String get highlightedMicroLabel {
    return Intl.message(
      'Highlighted Micro',
      name: 'highlightedMicroLabel',
      desc: '',
      args: [],
    );
  }

  /// `Full Report`
  String get fullReportLabel {
    return Intl.message(
      'Full Report',
      name: 'fullReportLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismissLabel {
    return Intl.message(
      'Dismiss',
      name: 'dismissLabel',
      desc: '',
      args: [],
    );
  }

  /// `Quantity must be greater than zero.`
  String get quantityErrorMessage {
    return Intl.message(
      'Quantity must be greater than zero.',
      name: 'quantityErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `No food detected`
  String get noFoodDetectedLabel {
    return Intl.message(
      'No food detected',
      name: 'noFoodDetectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find any food in the picture. Please try again with a clearer image.`
  String get noFoodDetectedMessage {
    return Intl.message(
      'We couldn\'t find any food in the picture. Please try again with a clearer image.',
      name: 'noFoodDetectedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Image taken from screen`
  String get imageTakenFromScreenLabel {
    return Intl.message(
      'Image taken from screen',
      name: 'imageTakenFromScreenLabel',
      desc: '',
      args: [],
    );
  }

  /// `It looks like this image was taken from a screen. Please upload an original photo of your meal.`
  String get imageTakenFromScreenMessage {
    return Intl.message(
      'It looks like this image was taken from a screen. Please upload an original photo of your meal.',
      name: 'imageTakenFromScreenMessage',
      desc: '',
      args: [],
    );
  }

  /// `Scan Again`
  String get scanAgainLabel {
    return Intl.message(
      'Scan Again',
      name: 'scanAgainLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enhance`
  String get enhanceLabel {
    return Intl.message(
      'Enhance',
      name: 'enhanceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Instructions unclear`
  String get instructionsUnclearLabel {
    return Intl.message(
      'Instructions unclear',
      name: 'instructionsUnclearLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please provide clear and detailed instructions so we can process your request accurately.`
  String get instructionsUnclearMessage {
    return Intl.message(
      'Please provide clear and detailed instructions so we can process your request accurately.',
      name: 'instructionsUnclearMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choose a username that identifies you in the app.`
  String get usernameDesc {
    return Intl.message(
      'Choose a username that identifies you in the app.',
      name: 'usernameDesc',
      desc: '',
      args: [],
    );
  }

  /// `Your registered email used for login and account recovery.`
  String get emailDesc {
    return Intl.message(
      'Your registered email used for login and account recovery.',
      name: 'emailDesc',
      desc: '',
      args: [],
    );
  }

  /// `Total ratio must equal to 100%`
  String get ratioError {
    return Intl.message(
      'Total ratio must equal to 100%',
      name: 'ratioError',
      desc: '',
      args: [],
    );
  }

  /// `Target weekly change must be set.`
  String get targetWeeklyChangeError {
    return Intl.message(
      'Target weekly change must be set.',
      name: 'targetWeeklyChangeError',
      desc: '',
      args: [],
    );
  }

  /// `Impact on Targets`
  String get impactOnTargetsLabel {
    return Intl.message(
      'Impact on Targets',
      name: 'impactOnTargetsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Daily Full Report`
  String get dailyFullReportLabel {
    return Intl.message(
      'Daily Full Report',
      name: 'dailyFullReportLabel',
      desc: '',
      args: [],
    );
  }

  /// `Macronutrients Progress`
  String get macronutrientsProgressLabel {
    return Intl.message(
      'Macronutrients Progress',
      name: 'macronutrientsProgressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Complete Nutrients`
  String get completeNutrientsLabel {
    return Intl.message(
      'Complete Nutrients',
      name: 'completeNutrientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Chia`
  String get chiaLabel {
    return Intl.message(
      'Chia',
      name: 'chiaLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gemini 2.5`
  String get gemini25Label {
    return Intl.message(
      'Gemini 2.5',
      name: 'gemini25Label',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition Specialist`
  String get nutritionSpecialistLabel {
    return Intl.message(
      'Nutrition Specialist',
      name: 'nutritionSpecialistLabel',
      desc: '',
      args: [],
    );
  }

  /// `Type to start chatting...`
  String get typeToStartChattingLabel {
    return Intl.message(
      'Type to start chatting...',
      name: 'typeToStartChattingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Experience Points`
  String get experiencePointsLabel {
    return Intl.message(
      'Experience Points',
      name: 'experiencePointsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Daily Goals`
  String get dailyGoalsLabel {
    return Intl.message(
      'Daily Goals',
      name: 'dailyGoalsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get searchResultLabel {
    return Intl.message(
      'Search Results',
      name: 'searchResultLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recently Viewed`
  String get recentlyViewedLabel {
    return Intl.message(
      'Recently Viewed',
      name: 'recentlyViewedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Saved Foods`
  String get savedFoodLabel {
    return Intl.message(
      'Saved Foods',
      name: 'savedFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `No Saved Items`
  String get noSavedItemsLabel {
    return Intl.message(
      'No Saved Items',
      name: 'noSavedItemsLabel',
      desc: '',
      args: [],
    );
  }

  /// `You haven’t saved any food items yet. Save foods to add items here.`
  String get noSavedItemsMessage {
    return Intl.message(
      'You haven’t saved any food items yet. Save foods to add items here.',
      name: 'noSavedItemsMessage',
      desc: '',
      args: [],
    );
  }

  /// `You don't have sufficient energy.`
  String get notEnoughEnergyMessage {
    return Intl.message(
      'You don\'t have sufficient energy.',
      name: 'notEnoughEnergyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Claim`
  String get claimLabel {
    return Intl.message(
      'Claim',
      name: 'claimLabel',
      desc: '',
      args: [],
    );
  }

  /// `Claimed`
  String get claimedLabel {
    return Intl.message(
      'Claimed',
      name: 'claimedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calorie target`
  String get calorieGoalDesc {
    return Intl.message(
      'Calorie target',
      name: 'calorieGoalDesc',
      desc: '',
      args: [],
    );
  }

  /// `Protein target`
  String get proteinGoalDesc {
    return Intl.message(
      'Protein target',
      name: 'proteinGoalDesc',
      desc: '',
      args: [],
    );
  }

  /// `Meal balance`
  String get mealsGoalDesc {
    return Intl.message(
      'Meal balance',
      name: 'mealsGoalDesc',
      desc: '',
      args: [],
    );
  }

  /// `XP`
  String get xpLabel {
    return Intl.message(
      'XP',
      name: 'xpLabel',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get maxLabel {
    return Intl.message(
      'Max',
      name: 'maxLabel',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get goLabel {
    return Intl.message(
      'Go',
      name: 'goLabel',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Companion`
  String get chooseYourCompanionLabel {
    return Intl.message(
      'Choose Your Companion',
      name: 'chooseYourCompanionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pick a pet to accompany you on your journey. You can buy, equip, or switch anytime!`
  String get chooseYourCompanionMessage {
    return Intl.message(
      'Pick a pet to accompany you on your journey. You can buy, equip, or switch anytime!',
      name: 'chooseYourCompanionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buyLabel {
    return Intl.message(
      'Buy',
      name: 'buyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Equip`
  String get equipLabel {
    return Intl.message(
      'Equip',
      name: 'equipLabel',
      desc: '',
      args: [],
    );
  }

  /// `Equipped`
  String get equippedLabel {
    return Intl.message(
      'Equipped',
      name: 'equippedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Not Enough Energy`
  String get notEnoughEnergyLabel {
    return Intl.message(
      'Not Enough Energy',
      name: 'notEnoughEnergyLabel',
      desc: '',
      args: [],
    );
  }

  /// `See progress over time`
  String get seeProgressOverTimeLabel {
    return Intl.message(
      'See progress over time',
      name: 'seeProgressOverTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile and Customize Plan`
  String get updateProfileAndCustomizePlanLabel {
    return Intl.message(
      'Update Profile and Customize Plan',
      name: 'updateProfileAndCustomizePlanLabel',
      desc: '',
      args: [],
    );
  }

  /// `Chat with Chia AI`
  String get chatWithChiaAILabel {
    return Intl.message(
      'Chat with Chia AI',
      name: 'chatWithChiaAILabel',
      desc: '',
      args: [],
    );
  }

  /// `Start Chat`
  String get startChatLabel {
    return Intl.message(
      'Start Chat',
      name: 'startChatLabel',
      desc: '',
      args: [],
    );
  }

  /// `One moment, Chia is gathering the facts...`
  String get chiaLoadingMessage {
    return Intl.message(
      'One moment, Chia is gathering the facts...',
      name: 'chiaLoadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Calorie Progress`
  String get weeklyCalorieProgressLabel {
    return Intl.message(
      'Weekly Calorie Progress',
      name: 'weeklyCalorieProgressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Weekly calorie intake overview`
  String get weeklyCalorieProgressDesc {
    return Intl.message(
      'Weekly calorie intake overview',
      name: 'weeklyCalorieProgressDesc',
      desc: '',
      args: [],
    );
  }

  /// `Average`
  String get averageLabel {
    return Intl.message(
      'Average',
      name: 'averageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Target Calorie`
  String get targetCalorieLabel {
    return Intl.message(
      'Target Calorie',
      name: 'targetCalorieLabel',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overviewLabel {
    return Intl.message(
      'Overview',
      name: 'overviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Virtual Pet`
  String get virtualPetLabel {
    return Intl.message(
      'Virtual Pet',
      name: 'virtualPetLabel',
      desc: '',
      args: [],
    );
  }

  /// `Weight Progress`
  String get weightProgressLabel {
    return Intl.message(
      'Weight Progress',
      name: 'weightProgressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Track your weight changes`
  String get weightProgressDesc {
    return Intl.message(
      'Track your weight changes',
      name: 'weightProgressDesc',
      desc: '',
      args: [],
    );
  }

  /// `+ Log Weight`
  String get logWeightLabel {
    return Intl.message(
      '+ Log Weight',
      name: 'logWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Track, Play, and Grow`
  String get trackPlayAndGrowLabel {
    return Intl.message(
      'Track, Play, and Grow',
      name: 'trackPlayAndGrowLabel',
      desc: '',
      args: [],
    );
  }

  /// `Your pet is getting out of bed and preparing to see you...`
  String get virtualPetLoadingMessage {
    return Intl.message(
      'Your pet is getting out of bed and preparing to see you...',
      name: 'virtualPetLoadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingLabel {
    return Intl.message(
      'Loading...',
      name: 'loadingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDateLabel {
    return Intl.message(
      'Start Date',
      name: 'startDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `The beginning date for the weekly calorie progress.`
  String get startDateDesc {
    return Intl.message(
      'The beginning date for the weekly calorie progress.',
      name: 'startDateDesc',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDateLabel {
    return Intl.message(
      'End Date',
      name: 'endDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `The ending date for the weekly calorie progress.`
  String get endDateDesc {
    return Intl.message(
      'The ending date for the weekly calorie progress.',
      name: 'endDateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Start date cannot be after end date`
  String get startEndDateErrorMessage1 {
    return Intl.message(
      'Start date cannot be after end date',
      name: 'startEndDateErrorMessage1',
      desc: '',
      args: [],
    );
  }

  /// `Date range cannot exceed 7 days`
  String get startEndDateErrorMessage2 {
    return Intl.message(
      'Date range cannot exceed 7 days',
      name: 'startEndDateErrorMessage2',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDateLabel {
    return Intl.message(
      'Select Date',
      name: 'selectDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Choose a date range (up to 7 days) to view your progress.`
  String get selectDateDesc {
    return Intl.message(
      'Choose a date range (up to 7 days) to view your progress.',
      name: 'selectDateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Weight Log`
  String get weightLogLabel {
    return Intl.message(
      'Weight Log',
      name: 'weightLogLabel',
      desc: '',
      args: [],
    );
  }

  /// `Browse through your previous weight records and monitor changes over time.`
  String get weightLogDesc {
    return Intl.message(
      'Browse through your previous weight records and monitor changes over time.',
      name: 'weightLogDesc',
      desc: '',
      args: [],
    );
  }

  /// `Oldest to Newest`
  String get oldestToNewestLabel {
    return Intl.message(
      'Oldest to Newest',
      name: 'oldestToNewestLabel',
      desc: '',
      args: [],
    );
  }

  /// `Newest to Oldest`
  String get newestToOldestLabel {
    return Intl.message(
      'Newest to Oldest',
      name: 'newestToOldestLabel',
      desc: '',
      args: [],
    );
  }

  /// `Report Summary`
  String get reportSummaryLabel {
    return Intl.message(
      'Report Summary',
      name: 'reportSummaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Monitor health stats`
  String get reportSummaryDesc {
    return Intl.message(
      'Monitor health stats',
      name: 'reportSummaryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Average Over The Week`
  String get averageOverTheWeekLabel {
    return Intl.message(
      'Average Over The Week',
      name: 'averageOverTheWeekLabel',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get todayLabel {
    return Intl.message(
      'Today',
      name: 'todayLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 1 Week`
  String get last1WeeksLabel {
    return Intl.message(
      'Last 1 Week',
      name: 'last1WeeksLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 2 Weeks`
  String get last2WeeksLabel {
    return Intl.message(
      'Last 2 Weeks',
      name: 'last2WeeksLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 3 Weeks`
  String get last3WeeksLabel {
    return Intl.message(
      'Last 3 Weeks',
      name: 'last3WeeksLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 4 Weeks`
  String get last4WeeksLabel {
    return Intl.message(
      'Last 4 Weeks',
      name: 'last4WeeksLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 3 Months`
  String get last3MonthsLabel {
    return Intl.message(
      'Last 3 Months',
      name: 'last3MonthsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 6 Months`
  String get last6MonthsLabel {
    return Intl.message(
      'Last 6 Months',
      name: 'last6MonthsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last Year`
  String get lastYearLabel {
    return Intl.message(
      'Last Year',
      name: 'lastYearLabel',
      desc: '',
      args: [],
    );
  }

  /// `All Time`
  String get allTimeLabel {
    return Intl.message(
      'All Time',
      name: 'allTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotYourPasswordLabel {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Token`
  String get sendResetTokenLabel {
    return Intl.message(
      'Send Reset Token',
      name: 'sendResetTokenLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your registered email address, and we will send you a link to reset your password.`
  String get sendResetTokenDesc {
    return Intl.message(
      'Please enter your registered email address, and we will send you a link to reset your password.',
      name: 'sendResetTokenDesc',
      desc: '',
      args: [],
    );
  }

  /// `You have exceeded the maximum number of password reset requests. Please try again later.`
  String get overEmailSendRateLimit {
    return Intl.message(
      'You have exceeded the maximum number of password reset requests. Please try again later.',
      name: 'overEmailSendRateLimit',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCodeLabel {
    return Intl.message(
      'Send Code',
      name: 'sendCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmailLabel {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `We have sent the code to`
  String get verifyEmailDesc {
    return Intl.message(
      'We have sent the code to',
      name: 'verifyEmailDesc',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verifyLabel {
    return Intl.message(
      'Verify',
      name: 'verifyLabel',
      desc: '',
      args: [],
    );
  }

  /// `OTP has expired or is invalid`
  String get invalidOtp {
    return Intl.message(
      'OTP has expired or is invalid',
      name: 'invalidOtp',
      desc: '',
      args: [],
    );
  }

  /// `Reset Your Password`
  String get resetYourPasswordLabel {
    return Intl.message(
      'Reset Your Password',
      name: 'resetYourPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordLabel {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password below to reset your account password.`
  String get resetPasswordDesc {
    return Intl.message(
      'Please enter your new password below to reset your account password.',
      name: 'resetPasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Leaving so soon?`
  String get leavingSoSoonLabel {
    return Intl.message(
      'Leaving so soon?',
      name: 'leavingSoSoonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get leavingSoSoonDesc {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'leavingSoSoonDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete Logged Food`
  String get deleteLoggedFoodLabel {
    return Intl.message(
      'Delete Logged Food',
      name: 'deleteLoggedFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this food entry? This action cannot be undone.`
  String get deleteLoggedFoodDesc {
    return Intl.message(
      'Are you sure you want to delete this food entry? This action cannot be undone.',
      name: 'deleteLoggedFoodDesc',
      desc: '',
      args: [],
    );
  }

  /// `Food logged for`
  String get foodLoggedForLabel {
    return Intl.message(
      'Food logged for',
      name: 'foodLoggedForLabel',
      desc: '',
      args: [],
    );
  }

  /// `Food has been added to your saved list`
  String get foodAddedToSavedMessage {
    return Intl.message(
      'Food has been added to your saved list',
      name: 'foodAddedToSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Food has been removed from your saved list`
  String get foodRemovedFromSavedMessage {
    return Intl.message(
      'Food has been removed from your saved list',
      name: 'foodRemovedFromSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Update`
  String get confirmUpdateLabel {
    return Intl.message(
      'Confirm Update',
      name: 'confirmUpdateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save these changes? Updating your details will adjust your personalized plan.`
  String get confirmUpdateDesc {
    return Intl.message(
      'Are you sure you want to save these changes? Updating your details will adjust your personalized plan.',
      name: 'confirmUpdateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to save these changes?`
  String get confirmAccountUpdateDesc {
    return Intl.message(
      'Are you sure you want to save these changes?',
      name: 'confirmAccountUpdateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Personalized plan updated`
  String get personalizedPlanUpdatedLabel {
    return Intl.message(
      'Personalized plan updated',
      name: 'personalizedPlanUpdatedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Account details updated`
  String get accountDetailsUpdatedLabel {
    return Intl.message(
      'Account details updated',
      name: 'accountDetailsUpdatedLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
