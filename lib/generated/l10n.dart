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

  /// `欢迎回来，Flux用户`
  String get loginScreenTitle {
    return Intl.message(
      '欢迎回来，Flux用户',
      name: 'loginScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `更智能的追踪，获得更好的成果 —— 登录并让AI助你饮食无忧！`
  String get loginScreenDesc {
    return Intl.message(
      '更智能的追踪，获得更好的成果 —— 登录并让AI助你饮食无忧！',
      name: 'loginScreenDesc',
      desc: '',
      args: [],
    );
  }

  /// `开始使用 Flux`
  String get signUpScreenTitle {
    return Intl.message(
      '开始使用 Flux',
      name: 'signUpScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `注册即可使用Flux，获取饮食计划、追踪营养，并养成你的宠物！`
  String get signUpScreenDesc {
    return Intl.message(
      '注册即可使用Flux，获取饮食计划、追踪营养，并养成你的宠物！',
      name: 'signUpScreenDesc',
      desc: '',
      args: [],
    );
  }

  /// `你的智能营养助手`
  String get onboardingTitle1 {
    return Intl.message(
      '你的智能营养助手',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `与AI聊天，为你量身定制饮食计划。`
  String get onboardingDesc1 {
    return Intl.message(
      '与AI聊天，为你量身定制饮食计划。',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `AI识餐：更聪明地追踪`
  String get onboardingTitle2 {
    return Intl.message(
      'AI识餐：更聪明地追踪',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `使用AI驱动的先进识餐功能，轻松记录每一餐。`
  String get onboardingDesc2 {
    return Intl.message(
      '使用AI驱动的先进识餐功能，轻松记录每一餐。',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `补能，交友，升级！`
  String get onboardingTitle3 {
    return Intl.message(
      '补能，交友，升级！',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `补充营养，解锁奖励，见证你的虚拟宠物茁壮成长。`
  String get onboardingDesc3 {
    return Intl.message(
      '补充营养，解锁奖励，见证你的虚拟宠物茁壮成长。',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `已有账号？`
  String get loginPrimarySpanText {
    return Intl.message(
      '已有账号？',
      name: 'loginPrimarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get loginSecondarySpanText {
    return Intl.message(
      '登录',
      name: 'loginSecondarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `还没有账号？`
  String get signUpPrimarySpanText {
    return Intl.message(
      '还没有账号？',
      name: 'signUpPrimarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `注册`
  String get signUpSecondarySpanText {
    return Intl.message(
      '注册',
      name: 'signUpSecondarySpanText',
      desc: '',
      args: [],
    );
  }

  /// `忘记密码？`
  String get forgotPasswordLabel {
    return Intl.message(
      '忘记密码？',
      name: 'forgotPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `我们该如何为你制定计划？`
  String get planSelectionTitle {
    return Intl.message(
      '我们该如何为你制定计划？',
      name: 'planSelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `选择逐步构建计划或让AI根据你的目标自动生成。`
  String get planSelectionDesc {
    return Intl.message(
      '选择逐步构建计划或让AI根据你的目标自动生成。',
      name: 'planSelectionDesc',
      desc: '',
      args: [],
    );
  }

  /// `开始`
  String get getStartedLabel {
    return Intl.message(
      '开始',
      name: 'getStartedLabel',
      desc: '',
      args: [],
    );
  }

  /// `个人资料`
  String get profileLabel {
    return Intl.message(
      '个人资料',
      name: 'profileLabel',
      desc: '',
      args: [],
    );
  }

  /// `编辑`
  String get editLabel {
    return Intl.message(
      '编辑',
      name: 'editLabel',
      desc: '',
      args: [],
    );
  }

  /// `餐食比例`
  String get mealRatioLabel {
    return Intl.message(
      '餐食比例',
      name: 'mealRatioLabel',
      desc: '',
      args: [],
    );
  }

  /// `岁`
  String get yearsLabel {
    return Intl.message(
      '岁',
      name: 'yearsLabel',
      desc: '',
      args: [],
    );
  }

  /// `手动定制计划`
  String get planSelectionButtonTitle1 {
    return Intl.message(
      '手动定制计划',
      name: 'planSelectionButtonTitle1',
      desc: '',
      args: [],
    );
  }

  /// `回答问题，自定义你的饮食旅程。`
  String get planSelectionButtonDesc1 {
    return Intl.message(
      '回答问题，自定义你的饮食旅程。',
      name: 'planSelectionButtonDesc1',
      desc: '',
      args: [],
    );
  }

  /// `AI智能计划`
  String get planSelectionButtonTitle2 {
    return Intl.message(
      'AI智能计划',
      name: 'planSelectionButtonTitle2',
      desc: '',
      args: [],
    );
  }

  /// `描述你的身体和目标——让AI帮你打造完美计划。`
  String get planSelectionButtonDesc2 {
    return Intl.message(
      '描述你的身体和目标——让AI帮你打造完美计划。',
      name: 'planSelectionButtonDesc2',
      desc: '',
      args: [],
    );
  }

  /// `记录食物`
  String get loggingSelectionButtonTitle1 {
    return Intl.message(
      '记录食物',
      name: 'loggingSelectionButtonTitle1',
      desc: '',
      args: [],
    );
  }

  /// `搜索并选择食物，然后输入分量。`
  String get loggingSelectionButtonDesc1 {
    return Intl.message(
      '搜索并选择食物，然后输入分量。',
      name: 'loggingSelectionButtonDesc1',
      desc: '',
      args: [],
    );
  }

  /// `扫描餐食`
  String get loggingSelectionButtonTitle2 {
    return Intl.message(
      '扫描餐食',
      name: 'loggingSelectionButtonTitle2',
      desc: '',
      args: [],
    );
  }

  /// `快速拍照——我们将自动识别。`
  String get loggingSelectionButtonDesc2 {
    return Intl.message(
      '快速拍照——我们将自动识别。',
      name: 'loggingSelectionButtonDesc2',
      desc: '',
      args: [],
    );
  }

  /// `扫描条码`
  String get loggingSelectionButtonTitle3 {
    return Intl.message(
      '扫描条码',
      name: 'loggingSelectionButtonTitle3',
      desc: '',
      args: [],
    );
  }

  /// `扫描包装食品条码，快速记录。`
  String get loggingSelectionButtonDesc3 {
    return Intl.message(
      '扫描包装食品条码，快速记录。',
      name: 'loggingSelectionButtonDesc3',
      desc: '',
      args: [],
    );
  }

  /// `继续`
  String get continueLabel {
    return Intl.message(
      '继续',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `好的`
  String get okLabel {
    return Intl.message(
      '好的',
      name: 'okLabel',
      desc: '',
      args: [],
    );
  }

  /// `选择`
  String get selectLabel {
    return Intl.message(
      '选择',
      name: 'selectLabel',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancelLabel {
    return Intl.message(
      '取消',
      name: 'cancelLabel',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get loginLabel {
    return Intl.message(
      '登录',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `注册`
  String get signUpLabel {
    return Intl.message(
      '注册',
      name: 'signUpLabel',
      desc: '',
      args: [],
    );
  }

  /// `登出`
  String get logOutLabel {
    return Intl.message(
      '登出',
      name: 'logOutLabel',
      desc: '',
      args: [],
    );
  }

  /// `用户名`
  String get usernameLabel {
    return Intl.message(
      '用户名',
      name: 'usernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `邮箱`
  String get emailLabel {
    return Intl.message(
      '邮箱',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `密码`
  String get passwordLabel {
    return Intl.message(
      '密码',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `告诉我们你的信息`
  String get planQuestion1 {
    return Intl.message(
      '告诉我们你的信息',
      name: 'planQuestion1',
      desc: '',
      args: [],
    );
  }

  /// `分享你的性别、体重、身高和生日，帮助我们为你制定专属计划。`
  String get planDescription1 {
    return Intl.message(
      '分享你的性别、体重、身高和生日，帮助我们为你制定专属计划。',
      name: 'planDescription1',
      desc: '',
      args: [],
    );
  }

  /// `设定目标体重`
  String get planQuestion2 {
    return Intl.message(
      '设定目标体重',
      name: 'planQuestion2',
      desc: '',
      args: [],
    );
  }

  /// `告诉我们你的目标体重，我们会帮你规划前进路线。`
  String get planDescription2 {
    return Intl.message(
      '告诉我们你的目标体重，我们会帮你规划前进路线。',
      name: 'planDescription2',
      desc: '',
      args: [],
    );
  }

  /// `选择每周增重目标`
  String get planQuestion3 {
    return Intl.message(
      '选择每周增重目标',
      name: 'planQuestion3',
      desc: '',
      args: [],
    );
  }

  /// `设定每周期望增重速度——从0.1公斤到1.0公斤。`
  String get planDescription3 {
    return Intl.message(
      '设定每周期望增重速度——从0.1公斤到1.0公斤。',
      name: 'planDescription3',
      desc: '',
      args: [],
    );
  }

  /// `描述你的日常活动`
  String get planQuestion4 {
    return Intl.message(
      '描述你的日常活动',
      name: 'planQuestion4',
      desc: '',
      args: [],
    );
  }

  /// `告诉我们你一天的活动量，包括工作、学习或家庭事务中的移动。`
  String get planDescription4 {
    return Intl.message(
      '告诉我们你一天的活动量，包括工作、学习或家庭事务中的移动。',
      name: 'planDescription4',
      desc: '',
      args: [],
    );
  }

  /// `你每周锻炼几次？`
  String get planQuestion5 {
    return Intl.message(
      '你每周锻炼几次？',
      name: 'planQuestion5',
      desc: '',
      args: [],
    );
  }

  /// `告诉我们你的锻炼频率，以便更精准地匹配你的训练水平。`
  String get planDescription5 {
    return Intl.message(
      '告诉我们你的锻炼频率，以便更精准地匹配你的训练水平。',
      name: 'planDescription5',
      desc: '',
      args: [],
    );
  }

  /// `你的饮食偏好是什么？`
  String get planQuestion6 {
    return Intl.message(
      '你的饮食偏好是什么？',
      name: 'planQuestion6',
      desc: '',
      args: [],
    );
  }

  /// `选择最适合你的饮食方式，我们将据此定制热量与营养目标。`
  String get planDescription6 {
    return Intl.message(
      '选择最适合你的饮食方式，我们将据此定制热量与营养目标。',
      name: 'planDescription6',
      desc: '',
      args: [],
    );
  }

  /// `性别`
  String get genderLabel {
    return Intl.message(
      '性别',
      name: 'genderLabel',
      desc: '',
      args: [],
    );
  }

  /// `用于个性化健康与热量估算。`
  String get genderDesc {
    return Intl.message(
      '用于个性化健康与热量估算。',
      name: 'genderDesc',
      desc: '',
      args: [],
    );
  }

  /// `男性`
  String get maleLabel {
    return Intl.message(
      '男性',
      name: 'maleLabel',
      desc: '',
      args: [],
    );
  }

  /// `女性`
  String get femaleLabel {
    return Intl.message(
      '女性',
      name: 'femaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `身高`
  String get heightLabel {
    return Intl.message(
      '身高',
      name: 'heightLabel',
      desc: '',
      args: [],
    );
  }

  /// `有助于计算身体质量指数（BMI）。`
  String get heightDesc {
    return Intl.message(
      '有助于计算身体质量指数（BMI）。',
      name: 'heightDesc',
      desc: '',
      args: [],
    );
  }

  /// `体重`
  String get weightLabel {
    return Intl.message(
      '体重',
      name: 'weightLabel',
      desc: '',
      args: [],
    );
  }

  /// `用于确定每日热量需求。`
  String get weightDesc {
    return Intl.message(
      '用于确定每日热量需求。',
      name: 'weightDesc',
      desc: '',
      args: [],
    );
  }

  /// `出生日期`
  String get dateOfBirthLabel {
    return Intl.message(
      '出生日期',
      name: 'dateOfBirthLabel',
      desc: '',
      args: [],
    );
  }

  /// `我们将根据你的年龄估算基础代谢率。`
  String get dateOfBirthDesc {
    return Intl.message(
      '我们将根据你的年龄估算基础代谢率。',
      name: 'dateOfBirthDesc',
      desc: '',
      args: [],
    );
  }

  /// `目标体重`
  String get targetWeightLabel {
    return Intl.message(
      '目标体重',
      name: 'targetWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `设置目标体重——高于现值则增重，低于现值则减重，相同则维持。`
  String get targetWeightDesc {
    return Intl.message(
      '设置目标体重——高于现值则增重，低于现值则减重，相同则维持。',
      name: 'targetWeightDesc',
      desc: '',
      args: [],
    );
  }

  /// `每周目标增重`
  String get targetWeightWeeklyLabel {
    return Intl.message(
      '每周目标增重',
      name: 'targetWeightWeeklyLabel',
      desc: '',
      args: [],
    );
  }

  /// `0.1–0.2公斤：缓慢增长 | 0.25–0.4公斤：均衡推荐 | 0.45–0.6公斤：快速增长 | 0.65–1.0公斤：非常激进，脂肪增长风险较高`
  String get targetWeightWeeklyDesc {
    return Intl.message(
      '0.1–0.2公斤：缓慢增长 | 0.25–0.4公斤：均衡推荐 | 0.45–0.6公斤：快速增长 | 0.65–1.0公斤：非常激进，脂肪增长风险较高',
      name: 'targetWeightWeeklyDesc',
      desc: '',
      args: [],
    );
  }

  /// `久坐不动`
  String get sedentaryLabel {
    return Intl.message(
      '久坐不动',
      name: 'sedentaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `大部分时间坐着（如办公室工作）。`
  String get sedentaryDesc {
    return Intl.message(
      '大部分时间坐着（如办公室工作）。',
      name: 'sedentaryDesc',
      desc: '',
      args: [],
    );
  }

  /// `轻度活动`
  String get lightlyActiveLabel {
    return Intl.message(
      '轻度活动',
      name: 'lightlyActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `偶尔走动或站立（如教师、短时步行）。`
  String get lightlyActiveDesc {
    return Intl.message(
      '偶尔走动或站立（如教师、短时步行）。',
      name: 'lightlyActiveDesc',
      desc: '',
      args: [],
    );
  }

  /// `活跃`
  String get activeLabel {
    return Intl.message(
      '活跃',
      name: 'activeLabel',
      desc: '',
      args: [],
    );
  }

  /// `大部分时间站立或活动（如零售工作、轻体力劳动）。`
  String get activeDesc {
    return Intl.message(
      '大部分时间站立或活动（如零售工作、轻体力劳动）。',
      name: 'activeDesc',
      desc: '',
      args: [],
    );
  }

  /// `非常活跃`
  String get veryActiveLabel {
    return Intl.message(
      '非常活跃',
      name: 'veryActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `体力劳动多，日常活动量大。`
  String get veryActiveDesc {
    return Intl.message(
      '体力劳动多，日常活动量大。',
      name: 'veryActiveDesc',
      desc: '',
      args: [],
    );
  }

  /// `从不锻炼`
  String get neverLabel {
    return Intl.message(
      '从不锻炼',
      name: 'neverLabel',
      desc: '',
      args: [],
    );
  }

  /// `我不定期进行锻炼。`
  String get neverDesc {
    return Intl.message(
      '我不定期进行锻炼。',
      name: 'neverDesc',
      desc: '',
      args: [],
    );
  }

  /// `每周1–2次`
  String get lightLabel {
    return Intl.message(
      '每周1–2次',
      name: 'lightLabel',
      desc: '',
      args: [],
    );
  }

  /// `轻度或偶尔锻炼。`
  String get lightDesc {
    return Intl.message(
      '轻度或偶尔锻炼。',
      name: 'lightDesc',
      desc: '',
      args: [],
    );
  }

  /// `每周3–4次`
  String get moderateLabel {
    return Intl.message(
      '每周3–4次',
      name: 'moderateLabel',
      desc: '',
      args: [],
    );
  }

  /// `一周多数天都有锻炼。`
  String get moderateDesc {
    return Intl.message(
      '一周多数天都有锻炼。',
      name: 'moderateDesc',
      desc: '',
      args: [],
    );
  }

  /// `每周5次以上`
  String get frequentLabel {
    return Intl.message(
      '每周5次以上',
      name: 'frequentLabel',
      desc: '',
      args: [],
    );
  }

  /// `我几乎每天锻炼。`
  String get frequentDesc {
    return Intl.message(
      '我几乎每天锻炼。',
      name: 'frequentDesc',
      desc: '',
      args: [],
    );
  }

  /// `均衡`
  String get balancedLabel {
    return Intl.message(
      '均衡',
      name: 'balancedLabel',
      desc: '',
      args: [],
    );
  }

  /// `多样化的均衡饮食。`
  String get balancedDesc {
    return Intl.message(
      '多样化的均衡饮食。',
      name: 'balancedDesc',
      desc: '',
      args: [],
    );
  }

  /// `生酮饮食`
  String get ketoLabel {
    return Intl.message(
      '生酮饮食',
      name: 'ketoLabel',
      desc: '',
      args: [],
    );
  }

  /// `低碳水、高脂肪饮食。`
  String get ketoDesc {
    return Intl.message(
      '低碳水、高脂肪饮食。',
      name: 'ketoDesc',
      desc: '',
      args: [],
    );
  }

  /// `地中海饮食`
  String get mediterraneanLabel {
    return Intl.message(
      '地中海饮食',
      name: 'mediterraneanLabel',
      desc: '',
      args: [],
    );
  }

  /// `富含植物成分和健康脂肪。`
  String get mediterraneanDesc {
    return Intl.message(
      '富含植物成分和健康脂肪。',
      name: 'mediterraneanDesc',
      desc: '',
      args: [],
    );
  }

  /// `古饮食`
  String get paleoLabel {
    return Intl.message(
      '古饮食',
      name: 'paleoLabel',
      desc: '',
      args: [],
    );
  }

  /// `模仿古代人类的饮食方式。`
  String get paleoDesc {
    return Intl.message(
      '模仿古代人类的饮食方式。',
      name: 'paleoDesc',
      desc: '',
      args: [],
    );
  }

  /// `素食`
  String get vegetarianLabel {
    return Intl.message(
      '素食',
      name: 'vegetarianLabel',
      desc: '',
      args: [],
    );
  }

  /// `不含肉类和鱼类的饮食。`
  String get vegetarianDesc {
    return Intl.message(
      '不含肉类和鱼类的饮食。',
      name: 'vegetarianDesc',
      desc: '',
      args: [],
    );
  }

  /// `低碳水`
  String get lowCarbsLabel {
    return Intl.message(
      '低碳水',
      name: 'lowCarbsLabel',
      desc: '',
      args: [],
    );
  }

  /// `低碳水、高蛋白饮食。`
  String get lowCarbsDesc {
    return Intl.message(
      '低碳水、高蛋白饮食。',
      name: 'lowCarbsDesc',
      desc: '',
      args: [],
    );
  }

  /// `进度`
  String get progressLabel {
    return Intl.message(
      '进度',
      name: 'progressLabel',
      desc: '',
      args: [],
    );
  }

  /// `日记`
  String get diaryLabel {
    return Intl.message(
      '日记',
      name: 'diaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `食物`
  String get foodLabel {
    return Intl.message(
      '食物',
      name: 'foodLabel',
      desc: '',
      args: [],
    );
  }

  /// `更多`
  String get moreLabel {
    return Intl.message(
      '更多',
      name: 'moreLabel',
      desc: '',
      args: [],
    );
  }

  /// `英语`
  String get englishLabel {
    return Intl.message(
      '英语',
      name: 'englishLabel',
      desc: '',
      args: [],
    );
  }

  /// `简体中文`
  String get simplifiedChineseLabel {
    return Intl.message(
      '简体中文',
      name: 'simplifiedChineseLabel',
      desc: '',
      args: [],
    );
  }

  /// `哎呀，出错了`
  String get somethingWentWrong {
    return Intl.message(
      '哎呀，出错了',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `密码太弱，请选择更强的密码。`
  String get weakPassword {
    return Intl.message(
      '密码太弱，请选择更强的密码。',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `此邮箱已被注册，请更换邮箱。`
  String get usedEmail {
    return Intl.message(
      '此邮箱已被注册，请更换邮箱。',
      name: 'usedEmail',
      desc: '',
      args: [],
    );
  }

  /// `邮箱或密码错误，请重试。`
  String get invalidCredential {
    return Intl.message(
      '邮箱或密码错误，请重试。',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `会话已过期或用户未认证，请重新登录。`
  String get permissionDenied {
    return Intl.message(
      '会话已过期或用户未认证，请重新登录。',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `请求出错，请稍后再试。`
  String get requestError {
    return Intl.message(
      '请求出错，请稍后再试。',
      name: 'requestError',
      desc: '',
      args: [],
    );
  }

  /// `由于异常活动，我们已屏蔽此设备的请求。请稍后再试。`
  String get tooManyRequests {
    return Intl.message(
      '由于异常活动，我们已屏蔽此设备的请求。请稍后再试。',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `搜索食物...`
  String get searchFoodPlaceholder {
    return Intl.message(
      '搜索食物...',
      name: 'searchFoodPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `全部`
  String get allLabel {
    return Intl.message(
      '全部',
      name: 'allLabel',
      desc: '',
      args: [],
    );
  }

  /// `我的餐食`
  String get myMealsLabel {
    return Intl.message(
      '我的餐食',
      name: 'myMealsLabel',
      desc: '',
      args: [],
    );
  }

  /// `已保存`
  String get savedLabel {
    return Intl.message(
      '已保存',
      name: 'savedLabel',
      desc: '',
      args: [],
    );
  }

  /// `扫描条码`
  String get scanABarcodeLabel {
    return Intl.message(
      '扫描条码',
      name: 'scanABarcodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `扫描餐食`
  String get scanAMealLabel {
    return Intl.message(
      '扫描餐食',
      name: 'scanAMealLabel',
      desc: '',
      args: [],
    );
  }

  /// `描述餐食`
  String get describeAMealLabel {
    return Intl.message(
      '描述餐食',
      name: 'describeAMealLabel',
      desc: '',
      args: [],
    );
  }

  /// `数量`
  String get quantityLabel {
    return Intl.message(
      '数量',
      name: 'quantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `单位`
  String get servingUnitLabel {
    return Intl.message(
      '单位',
      name: 'servingUnitLabel',
      desc: '',
      args: [],
    );
  }

  /// `餐别`
  String get mealTypeLabel {
    return Intl.message(
      '餐别',
      name: 'mealTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `早餐`
  String get breakfastLabel {
    return Intl.message(
      '早餐',
      name: 'breakfastLabel',
      desc: '',
      args: [],
    );
  }

  /// `午餐`
  String get lunchLabel {
    return Intl.message(
      '午餐',
      name: 'lunchLabel',
      desc: '',
      args: [],
    );
  }

  /// `晚餐`
  String get dinnerLabel {
    return Intl.message(
      '晚餐',
      name: 'dinnerLabel',
      desc: '',
      args: [],
    );
  }

  /// `加餐`
  String get snackLabel {
    return Intl.message(
      '加餐',
      name: 'snackLabel',
      desc: '',
      args: [],
    );
  }

  /// `千卡`
  String get calorieUnit {
    return Intl.message(
      '千卡',
      name: 'calorieUnit',
      desc: '',
      args: [],
    );
  }

  /// `记录食物`
  String get logFoodLabel {
    return Intl.message(
      '记录食物',
      name: 'logFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `营养信息`
  String get nutritionalInformationLabel {
    return Intl.message(
      '营养信息',
      name: 'nutritionalInformationLabel',
      desc: '',
      args: [],
    );
  }

  /// `目标`
  String get goalLabel {
    return Intl.message(
      '目标',
      name: 'goalLabel',
      desc: '',
      args: [],
    );
  }

  /// `已记录`
  String get loggedLabel {
    return Intl.message(
      '已记录',
      name: 'loggedLabel',
      desc: '',
      args: [],
    );
  }

  /// `剩余 = 目标 - 已记录`
  String get calorieFormula {
    return Intl.message(
      '剩余 = 目标 - 已记录',
      name: 'calorieFormula',
      desc: '',
      args: [],
    );
  }

  /// `剩余`
  String get remainingLabel {
    return Intl.message(
      '剩余',
      name: 'remainingLabel',
      desc: '',
      args: [],
    );
  }

  /// `宏量营养素`
  String get macronutrientsLabel {
    return Intl.message(
      '宏量营养素',
      name: 'macronutrientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `目标值`
  String get targetsLabel {
    return Intl.message(
      '目标值',
      name: 'targetsLabel',
      desc: '',
      args: [],
    );
  }

  /// `已记录的餐食`
  String get loggedMealsLabel {
    return Intl.message(
      '已记录的餐食',
      name: 'loggedMealsLabel',
      desc: '',
      args: [],
    );
  }

  /// `请稍候，我们正在为你定制专属计划。`
  String get personalizingYourPlanLoadingText {
    return Intl.message(
      '请稍候，我们正在为你定制专属计划。',
      name: 'personalizingYourPlanLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `热量`
  String get calorieLabel {
    return Intl.message(
      '热量',
      name: 'calorieLabel',
      desc: '',
      args: [],
    );
  }

  /// `蛋白质`
  String get proteinLabel {
    return Intl.message(
      '蛋白质',
      name: 'proteinLabel',
      desc: '',
      args: [],
    );
  }

  /// `脂肪`
  String get fatLabel {
    return Intl.message(
      '脂肪',
      name: 'fatLabel',
      desc: '',
      args: [],
    );
  }

  /// `碳水化合物`
  String get carbsLabel {
    return Intl.message(
      '碳水化合物',
      name: 'carbsLabel',
      desc: '',
      args: [],
    );
  }

  /// `钙`
  String get calciumLabel {
    return Intl.message(
      '钙',
      name: 'calciumLabel',
      desc: '',
      args: [],
    );
  }

  /// `铁`
  String get ironLabel {
    return Intl.message(
      '铁',
      name: 'ironLabel',
      desc: '',
      args: [],
    );
  }

  /// `镁`
  String get magnesiumLabel {
    return Intl.message(
      '镁',
      name: 'magnesiumLabel',
      desc: '',
      args: [],
    );
  }

  /// `磷`
  String get phosphorusLabel {
    return Intl.message(
      '磷',
      name: 'phosphorusLabel',
      desc: '',
      args: [],
    );
  }

  /// `钾`
  String get potassiumLabel {
    return Intl.message(
      '钾',
      name: 'potassiumLabel',
      desc: '',
      args: [],
    );
  }

  /// `钠`
  String get sodiumLabel {
    return Intl.message(
      '钠',
      name: 'sodiumLabel',
      desc: '',
      args: [],
    );
  }

  /// `锌`
  String get zincLabel {
    return Intl.message(
      '锌',
      name: 'zincLabel',
      desc: '',
      args: [],
    );
  }

  /// `铜`
  String get copperLabel {
    return Intl.message(
      '铜',
      name: 'copperLabel',
      desc: '',
      args: [],
    );
  }

  /// `锰`
  String get manganeseLabel {
    return Intl.message(
      '锰',
      name: 'manganeseLabel',
      desc: '',
      args: [],
    );
  }

  /// `硒`
  String get seleniumLabel {
    return Intl.message(
      '硒',
      name: 'seleniumLabel',
      desc: '',
      args: [],
    );
  }

  /// `维生素A`
  String get vitaminALabel {
    return Intl.message(
      '维生素A',
      name: 'vitaminALabel',
      desc: '',
      args: [],
    );
  }

  /// `维生素E`
  String get vitaminELabel {
    return Intl.message(
      '维生素E',
      name: 'vitaminELabel',
      desc: '',
      args: [],
    );
  }

  /// `维生素D`
  String get vitaminDLabel {
    return Intl.message(
      '维生素D',
      name: 'vitaminDLabel',
      desc: '',
      args: [],
    );
  }

  /// `维生素C`
  String get vitaminCLabel {
    return Intl.message(
      '维生素C',
      name: 'vitaminCLabel',
      desc: '',
      args: [],
    );
  }

  /// `硫胺素`
  String get thiaminLabel {
    return Intl.message(
      '硫胺素',
      name: 'thiaminLabel',
      desc: '',
      args: [],
    );
  }

  /// `核黄素`
  String get riboflavinLabel {
    return Intl.message(
      '核黄素',
      name: 'riboflavinLabel',
      desc: '',
      args: [],
    );
  }

  /// `烟酸`
  String get niacinLabel {
    return Intl.message(
      '烟酸',
      name: 'niacinLabel',
      desc: '',
      args: [],
    );
  }

  /// `维生素B6`
  String get vitaminB6Label {
    return Intl.message(
      '维生素B6',
      name: 'vitaminB6Label',
      desc: '',
      args: [],
    );
  }

  /// `维生素B12`
  String get vitaminB12Label {
    return Intl.message(
      '维生素B12',
      name: 'vitaminB12Label',
      desc: '',
      args: [],
    );
  }

  /// `胆碱`
  String get cholineLabel {
    return Intl.message(
      '胆碱',
      name: 'cholineLabel',
      desc: '',
      args: [],
    );
  }

  /// `维生素K`
  String get vitaminKLabel {
    return Intl.message(
      '维生素K',
      name: 'vitaminKLabel',
      desc: '',
      args: [],
    );
  }

  /// `叶酸`
  String get folateLabel {
    return Intl.message(
      '叶酸',
      name: 'folateLabel',
      desc: '',
      args: [],
    );
  }

  /// `保存你的食物`
  String get saveYourFoodLabel {
    return Intl.message(
      '保存你的食物',
      name: 'saveYourFoodLabel',
      desc: '',
      args: [],
    );
  }

  /// `在食物详情页点击书签图标，即可保存你喜欢的食物，方便下次使用。`
  String get saveYourFoodDesc {
    return Intl.message(
      '在食物详情页点击书签图标，即可保存你喜欢的食物，方便下次使用。',
      name: 'saveYourFoodDesc',
      desc: '',
      args: [],
    );
  }

  /// `扫描你的餐食`
  String get scanYourMealLabel {
    return Intl.message(
      '扫描你的餐食',
      name: 'scanYourMealLabel',
      desc: '',
      args: [],
    );
  }

  /// `点击相机图标，用AI扫描餐食，立即获取营养信息。`
  String get scanYourMealDesc {
    return Intl.message(
      '点击相机图标，用AI扫描餐食，立即获取营养信息。',
      name: 'scanYourMealDesc',
      desc: '',
      args: [],
    );
  }

  /// `饮食`
  String get dietLabel {
    return Intl.message(
      '饮食',
      name: 'dietLabel',
      desc: '',
      args: [],
    );
  }

  /// `个人信息`
  String get personalDetailsLabel {
    return Intl.message(
      '个人信息',
      name: 'personalDetailsLabel',
      desc: '',
      args: [],
    );
  }

  /// `账号`
  String get accountLabel {
    return Intl.message(
      '账号',
      name: 'accountLabel',
      desc: '',
      args: [],
    );
  }

  /// `你好`
  String get hiLabel {
    return Intl.message(
      '你好',
      name: 'hiLabel',
      desc: '',
      args: [],
    );
  }

  /// `调整宏量营养比例`
  String get adjustMacroNutrientsLabel {
    return Intl.message(
      '调整宏量营养比例',
      name: 'adjustMacroNutrientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `碳水、脂肪和蛋白质`
  String get adjustMacroNutrientsDesc {
    return Intl.message(
      '碳水、脂肪和蛋白质',
      name: 'adjustMacroNutrientsDesc',
      desc: '',
      args: [],
    );
  }

  /// `调整热量摄入`
  String get adjustCalorieIntakeLabel {
    return Intl.message(
      '调整热量摄入',
      name: 'adjustCalorieIntakeLabel',
      desc: '',
      args: [],
    );
  }

  /// `千卡/天`
  String get adjustCalorieIntakeDesc {
    return Intl.message(
      '千卡/天',
      name: 'adjustCalorieIntakeDesc',
      desc: '',
      args: [],
    );
  }

  /// `饮食类型`
  String get dietTypeLabel {
    return Intl.message(
      '饮食类型',
      name: 'dietTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `早餐、午餐、晚餐与加餐`
  String get mealRatioDesc {
    return Intl.message(
      '早餐、午餐、晚餐与加餐',
      name: 'mealRatioDesc',
      desc: '',
      args: [],
    );
  }

  /// `想重新开始？`
  String get wantToStartFreshLabel {
    return Intl.message(
      '想重新开始？',
      name: 'wantToStartFreshLabel',
      desc: '',
      args: [],
    );
  }

  /// `生成一个全新的个性化计划`
  String get wantToStartFreshDesc {
    return Intl.message(
      '生成一个全新的个性化计划',
      name: 'wantToStartFreshDesc',
      desc: '',
      args: [],
    );
  }

  /// `生成`
  String get generateLabel {
    return Intl.message(
      '生成',
      name: 'generateLabel',
      desc: '',
      args: [],
    );
  }

  /// `个人信息`
  String get personalInfoLabel {
    return Intl.message(
      '个人信息',
      name: 'personalInfoLabel',
      desc: '',
      args: [],
    );
  }

  /// `计划自定义`
  String get planCustomizationLabel {
    return Intl.message(
      '计划自定义',
      name: 'planCustomizationLabel',
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
