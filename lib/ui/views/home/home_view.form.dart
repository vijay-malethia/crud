// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String TitleValueKey = 'title';
const String DescriptionsValueKey = 'descriptions';

final Map<String, TextEditingController> _HomeViewTextEditingControllers = {};

final Map<String, FocusNode> _HomeViewFocusNodes = {};

final Map<String, String? Function(String?)?> _HomeViewTextValidations = {
  TitleValueKey: null,
  DescriptionsValueKey: null,
};

mixin $HomeView {
  TextEditingController get titleController =>
      _getFormTextEditingController(TitleValueKey);
  TextEditingController get descriptionsController =>
      _getFormTextEditingController(DescriptionsValueKey);

  FocusNode get titleFocusNode => _getFormFocusNode(TitleValueKey);
  FocusNode get descriptionsFocusNode =>
      _getFormFocusNode(DescriptionsValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_HomeViewTextEditingControllers.containsKey(key)) {
      return _HomeViewTextEditingControllers[key]!;
    }

    _HomeViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _HomeViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_HomeViewFocusNodes.containsKey(key)) {
      return _HomeViewFocusNodes[key]!;
    }
    _HomeViewFocusNodes[key] = FocusNode();
    return _HomeViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    titleController.addListener(() => _updateFormData(model));
    descriptionsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    titleController.addListener(() => _updateFormData(model));
    descriptionsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TitleValueKey: titleController.text,
          DescriptionsValueKey: descriptionsController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _HomeViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _HomeViewFocusNodes.values) {
      focusNode.dispose();
    }

    _HomeViewTextEditingControllers.clear();
    _HomeViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get titleValue => this.formValueMap[TitleValueKey] as String?;
  String? get descriptionsValue =>
      this.formValueMap[DescriptionsValueKey] as String?;

  set titleValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TitleValueKey: value}),
    );

    if (_HomeViewTextEditingControllers.containsKey(TitleValueKey)) {
      _HomeViewTextEditingControllers[TitleValueKey]?.text = value ?? '';
    }
  }

  set descriptionsValue(String? value) {
    this.setData(
      this.formValueMap..addAll({DescriptionsValueKey: value}),
    );

    if (_HomeViewTextEditingControllers.containsKey(DescriptionsValueKey)) {
      _HomeViewTextEditingControllers[DescriptionsValueKey]?.text = value ?? '';
    }
  }

  bool get hasTitle =>
      this.formValueMap.containsKey(TitleValueKey) &&
      (titleValue?.isNotEmpty ?? false);
  bool get hasDescriptions =>
      this.formValueMap.containsKey(DescriptionsValueKey) &&
      (descriptionsValue?.isNotEmpty ?? false);

  bool get hasTitleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey]?.isNotEmpty ?? false;
  bool get hasDescriptionsValidationMessage =>
      this.fieldsValidationMessages[DescriptionsValueKey]?.isNotEmpty ?? false;

  String? get titleValidationMessage =>
      this.fieldsValidationMessages[TitleValueKey];
  String? get descriptionsValidationMessage =>
      this.fieldsValidationMessages[DescriptionsValueKey];
}

extension Methods on FormStateHelper {
  setTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TitleValueKey] = validationMessage;
  setDescriptionsValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionsValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    titleValue = '';
    descriptionsValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TitleValueKey: getValidationMessage(TitleValueKey),
      DescriptionsValueKey: getValidationMessage(DescriptionsValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _HomeViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _HomeViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TitleValueKey: getValidationMessage(TitleValueKey),
      DescriptionsValueKey: getValidationMessage(DescriptionsValueKey),
    });
