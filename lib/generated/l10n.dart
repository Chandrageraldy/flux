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

  /// `Help us understand your body by sharing your gender, weight, height, and birth date — so we can create the perfect plan for you.`
  String get planDescription1 {
    return Intl.message(
      'Help us understand your body by sharing your gender, weight, height, and birth date — so we can create the perfect plan for you.',
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

  /// `Target Weekly Gain`
  String get targetWeightWeeklyLabel {
    return Intl.message(
      'Target Weekly Gain',
      name: 'targetWeightWeeklyLabel',
      desc: '',
      args: [],
    );
  }

  /// `0.1–0.2 kg: slow gain, minimal fat | 0.25–0.4 kg: balanced & recommended | 0.45–0.6 kg: fast gain, more aggressive | 0.65–1.0 kg: very aggressive, higher fat risk`
  String get targetWeightWeeklyDesc {
    return Intl.message(
      '0.1–0.2 kg: slow gain, minimal fat | 0.25–0.4 kg: balanced & recommended | 0.45–0.6 kg: fast gain, more aggressive | 0.65–1.0 kg: very aggressive, higher fat risk',
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

  /// `Fats`
  String get fatLabel {
    return Intl.message(
      'Fats',
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

  /// `Saved Your Food`
  String get savedYourFoodLabel {
    return Intl.message(
      'Saved Your Food',
      name: 'savedYourFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tap the bookmark icon on any food detail page to save your favorite foods here for easy access.`
  String get savedYourFoodDesc {
    return Intl.message(
      'Tap the bookmark icon on any food detail page to save your favorite foods here for easy access.',
      name: 'savedYourFoodDesc',
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
