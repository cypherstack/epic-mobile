import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/icon_widgets/x_icon.dart';
import 'package:epicpay/widgets/textfield_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListSelectionDialog<T> extends StatefulWidget {
  const ListSelectionDialog({
    super.key,
    required this.title,
    required this.list,
    required this.displayName,
    this.predicate,
  });

  final String title;
  final List<T> list;
  final String Function(T) displayName;
  final bool Function(T value, String term)? predicate;

  @override
  State<ListSelectionDialog<T>> createState() => _ListSelectionDialogState();
}

class _ListSelectionDialogState<T> extends State<ListSelectionDialog<T>> {
  String _searchTerm = "";

  List<T> filter(String term) => widget.list
      .where((e) => widget.predicate!(e, term))
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final data = widget.predicate == null ? widget.list : filter(_searchTerm);

    return Material(
      color: Colors.red,
      child: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppBarIconButton(
                      key: const Key("guardarianInfoButtonKey"),
                      size: 36,
                      shadows: const [],
                      color: const Color(0xFF222227),
                      icon: SvgPicture.asset(
                        Assets.svg.x,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .topNavIconPrimary,
                        width: 20,
                        height: 20,
                      ),
                      onPressed: Navigator.of(context).pop,
                    ),
                  ],
                ),
                Text(
                  widget.title,
                  style: STextStyles.titleH4(context),
                ),
                const SizedBox(height: 20),
                if (widget.predicate != null)
                  _SearchField(onChanged: (value) {
                    setState(() {
                      _searchTerm = value;
                    });
                  }),
                if (widget.predicate != null) const SizedBox(height: 32),
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (_, __) => Container(
                      height: 1.5,
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .buttonBackPrimaryDisabled,
                    ),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      final displayName = widget.displayName(item);

                      return GestureDetector(
                        key: Key("${displayName}_${item.hashCode}"),
                        onTap: () => Navigator.of(context).pop(item),
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            displayName,
                            style: STextStyles.w400_16(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textMedium,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    super.key,
    required this.onChanged,
  });

  final void Function(String) onChanged;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      autofocus: true,
      controller: controller,
      onChanged: widget.onChanged,
      style: STextStyles.body(context),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        focusColor: Colors.transparent,
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),
        // labelStyle: STextStyles.fieldLabel(context),
        // hintStyle: STextStyles.fieldLabel(context),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).extension<StackColors>()!.textGold,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).extension<StackColors>()!.textGold,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).extension<StackColors>()!.textGold,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).extension<StackColors>()!.textGold,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).extension<StackColors>()!.textGold,
          ),
        ),
        // border: InputBorder.none,
        isCollapsed: true,
        hintText: "Search...",
        hintStyle: STextStyles.body(context).copyWith(
          color: Theme.of(context).extension<StackColors>()!.textDark,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        prefixIcon: SizedBox(
          width: 32,
          height: 40,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: SvgPicture.asset(
                Assets.svg.search,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        suffixIcon: controller.text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 0),
                child: UnconstrainedBox(
                  child: Row(
                    children: [
                      TextFieldIconButton(
                        child: const XIcon(),
                        onTap: () async {
                          setState(() {
                            controller.text = "";
                            widget.onChanged("");
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
