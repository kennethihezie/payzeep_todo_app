import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';
import 'package:todo_app/common/theme/scheme/input_scheme.dart';
import 'package:todo_app/common/theme/size_config.dart';
import 'package:todo_app/common/theme/typography/text_styles.dart';
import 'package:todo_app/widgets/form/app_form.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      required this.formField,
      this.controller,
      this.focusNode,
      this.initialValue,
      this.onClick,
      this.onChanged,
      this.leading,
      this.padding,
      this.onEditingComplete,
      this.onSubmitted,
      this.onFocusChanged,
      this.onFocusLost,
      this.onFocusGained,
      this.obscureText = false,
      this.readOnly = false,
      this.enabled,
      this.autocorrect = false,
      this.showCursor = true,
      bool? enableInteractiveSelection,
      bool? showError,
      this.validateAfterFocusLost = false,
      this.onlyShowCounterOnFocus = true,
      this.maxLines,
      this.maxLength,
      this.maxLengthEnforcement,
      this.hintText,
      this.style,
      this.borderRadius = 8,
      this.inputFormatters,
      this.suffix,
      this.suffixConstraints,
      this.prefix,
      this.prefixConstraints,
      this.restorationId,
      this.mouseCursor,
      this.keyboardAppearance,
      this.textInputAction,
      this.keyboardType,
      this.inputScheme,
      this.contextMenuBuilder,
      this.counterStyle})
      : enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText),
        showError = showError ?? true;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final AppFormField formField;

  final Widget? leading;

  final EdgeInsets? padding;

  final GestureTapCallback? onClick;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFocusChanged;
  final VoidCallback? onFocusLost;
  final VoidCallback? onFocusGained;

  final String? initialValue;

  final bool validateAfterFocusLost;
  final bool onlyShowCounterOnFocus;

  final bool obscureText;
  final bool readOnly;
  final bool? enabled;
  final bool autocorrect;
  final bool showCursor;
  final bool enableInteractiveSelection;
  final bool showError;

  final int? maxLines;
  final int? maxLength;

  final String? hintText;

  final TextStyle? style;

  final double borderRadius;

  final List<TextInputFormatter>? inputFormatters;

  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final String? restorationId;

  final MouseCursor? mouseCursor;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final Brightness? keyboardAppearance;

  final TextStyle? counterStyle;

  final EditableTextContextMenuBuilder? contextMenuBuilder;

  final AppInputScheme? inputScheme;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with RestorationMixin {
  RestorableTextEditingController? _controller;

  AppFormField get effectiveFormField => widget.formField;

  TextEditingController get effectiveController =>
      widget.controller ?? _controller!.value;

  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  // ColorProvider get colorProvider => ColorProvider.of(context);

  AppInputScheme get inputScheme =>
      widget.inputScheme ?? AppInputScheme.light();

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
          Theme.of(context).platform);

  bool get _isEnabled => widget.enabled ?? true;

  int get _currentLength => effectiveController.value.text.characters.length;

  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      effectiveController.value.text.characters.length > widget.maxLength!;

  bool get _hasError =>
      widget.formField.validationError != null || _hasIntrinsicError;

  bool get _needsCounter => widget.maxLength != null;

  bool get _hasHint {
    if (widget.hintText == null) {
      return false;
    }

    return widget.hintText!.isNotEmpty;
  }

  bool get _isTextField {
    final maxLines = widget.maxLines;
    if (maxLines == null) {
      return false;
    }

    return maxLines > 1;
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return _isEnabled;
      case NavigationMode.directional:
        return true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    }
    effectiveFocusNode.canRequestFocus = _isEnabled;
    effectiveFocusNode.addListener(_handleFocusChanged);
    effectiveFormField.addListener(_handleFormFieldChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void dispose() {
    effectiveFocusNode.removeListener(_handleFocusChanged);
    effectiveFormField.removeListener(_handleFormFieldChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void onChangedHandler(String value) {
    effectiveFormField.setValueFromString(value);
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  void _handleFocusChanged() {
    widget.onFocusChanged?.call();

    effectiveFocusNode.hasFocus
        ? widget.onFocusGained?.call()
        : widget.onFocusLost?.call();

    if (effectiveFormField.validateOnFocusLost &&
        !effectiveFocusNode.hasFocus) {
      effectiveFormField.isValid();
    }
    setState(() {
      // Rebuild the widget on focus changed
    });
  }

  void _handleFormFieldChanged() {
    String value = effectiveFormField.getValueAsString();

    if (value != effectiveController.text) {
      effectiveController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
  }

  Decoration _getEffectiveDecoration() {
    final hasFocus = effectiveFocusNode.hasFocus;

    final filledColor = _isEnabled
        ? hasFocus
            ? inputScheme.focusBackgroundColor
            : inputScheme.backgroundColor
        : inputScheme.focusBackgroundColor;

    final border = hasFocus
        ? Border.all(width: 1, color: inputScheme.focusBorderColor)
        : Border.all(width: 1, color: inputScheme.inactiveBorderColor);

    final errorBorder = Border.all(width: 1, color: inputScheme.errorColor);

    final effectiveDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: filledColor,
      border: _hasError ? errorBorder : border,
      boxShadow: hasFocus
          ? [
              BoxShadow(
                color: _hasError
                    ? inputScheme.errorColor.withOpacity(0.22)
                    : inputScheme.focusBorderColor.withOpacity(0.22),
                spreadRadius: 1,
                blurRadius: 2,
                blurStyle: BlurStyle.solid,
              )
            ]
          : [
              BoxShadow(
                color: inputScheme.shadowInactiveColor.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 2,
                blurStyle: BlurStyle.solid,
              )
            ],
    );

    return effectiveDecoration;
  }

  Widget _getEffectiveError() {
    final errorText = widget.formField.validationError ?? '';

    if (errorText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      errorText,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.body.smallRegular.copyWith(
        color: inputScheme.errorColor,
      ),
    );
  }

  Widget get _getEffectiveCounter {
    String counterText = '$_currentLength';

    if (widget.maxLength! > 0) {
      counterText += '/${widget.maxLength}';
    }
    return Text(
      counterText,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.body.smallRegular.copyWith(
        color: inputScheme.counterColor,
      ),
    );
  }

  Widget _getErrorCounter() {
    final topGap = 0.verticalGap;

    Widget? error;
    Widget? counter;

    if (!_hasError && !_needsCounter) {
      return const SizedBox.shrink();
    }

    if (_hasError) {
      error = _getEffectiveError();
    }

    if ((_needsCounter && !widget.onlyShowCounterOnFocus) ||
        (_needsCounter &&
            widget.onlyShowCounterOnFocus &&
            effectiveFocusNode.hasFocus)) {
      counter = _getEffectiveCounter;
    }

    final needsGap = (widget.formField.validationError ?? '').isNotEmpty ||
        (_needsCounter && !widget.onlyShowCounterOnFocus) ||
        (_needsCounter &&
            widget.onlyShowCounterOnFocus &&
            effectiveFocusNode.hasFocus);

    return Column(
      children: [
        if (needsGap) topGap,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (error != null && widget.showError)
              Expanded(child: error)
            else
              const Expanded(child: SizedBox.shrink()),
            if (counter != null) counter,
          ],
        ),
      ],
    );
  }

  Widget _buildTextField() {
    final focusNode = effectiveFocusNode;
    final controller = effectiveController;
    final formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    EdgeInsets contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16);

    bool prioritiesHint = _isTextField || !_hasHint || widget.leading != null;

    final hintText = prioritiesHint ? widget.hintText : null;

    if (prioritiesHint) {
      contentPadding = const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      );
    }

    final effectiveTextStyle = _getEffectiveTextStyle();
    final effectiveHintStyle = _getEffectiveHintTextStyle();

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        constraints: BoxConstraints(
          minHeight: SizeConfig.pxToHeight(50),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.start,
            obscureText: widget.obscureText,
            showCursor: widget.showCursor,
            mouseCursor: widget.mouseCursor,
            cursorColor: AppColors.textColor,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            autocorrect: _isTextField ? true : widget.autocorrect,
            maxLines: widget.maxLines,
            onTap: widget.onClick,
            onChanged: onChangedHandler,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            inputFormatters: formatters,
            keyboardAppearance: widget.keyboardAppearance,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            style: widget.style ?? effectiveTextStyle,
            contextMenuBuilder:
                widget.contextMenuBuilder ?? _defaultContextMenuBuilder,
            decoration: InputDecoration(
              enabled: _isEnabled,
              contentPadding: widget.padding ?? contentPadding,
              border: InputBorder.none,
              alignLabelWithHint: _isTextField,
              hintText: widget.hintText,
              hintStyle: effectiveHintStyle,
              labelStyle: effectiveHintStyle,
              prefixIcon: _isTextField ? null : widget.prefix,
              prefixIconConstraints: widget.prefixConstraints,
              suffixIcon: _isTextField ? null : widget.suffix,
              suffixIconConstraints: widget.suffixConstraints,
              suffixIconColor: _isEnabled
                  ? inputScheme.iconColor
                  : inputScheme.disabledIconColor,
              prefixIconColor: _isEnabled
                  ? inputScheme.iconColor
                  : inputScheme.disabledIconColor,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              filled: true,
              fillColor: _isEnabled
                  ? effectiveFocusNode.hasFocus
                      ? inputScheme.focusBackgroundColor
                      : inputScheme.backgroundColor
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAffixWidget() {
    final focused = effectiveFocusNode.hasFocus;
    return IconTheme(
      data: IconThemeData(
        color: focused
            ? inputScheme.affixIconColor
            : inputScheme.disabledAffixIconColor,
      ),
      child: widget.leading!,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));

    final focusNode = effectiveFocusNode;
    final controller = effectiveController;

    final listenable = Listenable.merge([
      focusNode,
      controller,
      widget.formField,
    ]);
    final hasFocus = effectiveFocusNode.hasFocus;
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListenableBuilder(
            listenable: listenable,
            builder: (context, child) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(hasFocus ? widget.borderRadius : 0),
                child: Container(
                  decoration: _getEffectiveDecoration(),
                  margin: EdgeInsets.symmetric(
                      horizontal: hasFocus ? 3 : 0, vertical: 3),
                  child: widget.leading == null
                      ? _buildTextField()
                      : IntrinsicHeight(
                          child: Row(
                            children: [
                              _buildAffixWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: VerticalDivider(
                                  thickness: 1,
                                  width: 1,
                                  color:
                                      inputScheme.dividerColor.withOpacity(0.2),
                                ),
                              ),
                              Expanded(child: _buildTextField()),
                            ],
                          ),
                        ),
                ),
              );
            }),
        ListenableBuilder(
            listenable: listenable,
            builder: (context, child) {
              return _getErrorCounter();
            }),
      ],
    );

    return child;
  }

  TextStyle _getEffectiveTextStyle() {
    return AppTextStyle.body.mediumRegular.copyWith(
      color: _isEnabled ? inputScheme.textColor : inputScheme.disabledIconColor,
    );
  }

  TextStyle _getEffectiveHintTextStyle() {
    final hasFocus = effectiveFocusNode.hasFocus;
    return AppTextStyle.body.mediumRegular.copyWith(
      color: _isEnabled
          ? inputScheme.textColor.withOpacity(hasFocus ? 0.30 : 0.40)
          : inputScheme.disabledIconColor,
    );
  }

  Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }
}
