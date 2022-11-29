import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:epicmobile/models/contact.dart';
import 'package:epicmobile/models/contact_address_entry.dart';
import 'package:epicmobile/pages/address_book_views/subviews/new_contact_address_entry_form.dart';
import 'package:epicmobile/providers/global/address_book_service_provider.dart';
import 'package:epicmobile/providers/ui/address_book_providers/address_entry_data_provider.dart';
import 'package:epicmobile/providers/ui/address_book_providers/contact_name_is_not_empty_state_provider.dart';
import 'package:epicmobile/providers/ui/address_book_providers/valid_contact_state_provider.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/barcode_scanner_interface.dart';
import 'package:epicmobile/utilities/clipboard_interface.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/custom_buttons/blue_text_button.dart';
import 'package:epicmobile/widgets/emoji_select_sheet.dart';
import 'package:epicmobile/widgets/icon_widgets/x_icon.dart';
import 'package:epicmobile/widgets/stack_text_field.dart';
import 'package:epicmobile/widgets/textfield_icon_buttondressBookEntryView extends ConsumerStatefulWidget {
  const AddAddressBookEntryView({
    Key? key,
    this.barcodeScanner = const BarcodeScannerWrapper(),
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/addAddressBookEntry";

  final BarcodeScannerInterface barcodeScanner;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<AddAddressBookEntryView> createState() =>
      _AddAddressBookEntryViewState();
}

class _AddAddressBookEntryViewState
    extends ConsumerState<AddAddressBookEntryView> {
  late final TextEditingController nameController;
  late final FocusNode nameFocusNode;
  late final ScrollController scrollController;

  late final BarcodeScannerInterface scanner;
  late final ClipboardInterface clipboard;

  Emoji? _selectedEmoji;
  bool _isFavorite = false;

  @override
  initState() {
    ref.refresh(addressEntryDataProviderFamilyRefresher);
    scanner = widget.barcodeScanner;
    clipboard = widget.clipboard;

    nameController = TextEditingController();
    nameFocusNode = FocusNode();
    scrollController = ScrollController();

    _addForm();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  List<NewContactAddressEntryForm> forms = [];
  final Set<int> _formIds = {};

  void _removeForm(int id) {
    forms.retainWhere((e) => e.id != id);
    _formIds.remove(id);
    ref.refresh(addressEntryDataProvider(id));
    setState(() {});
  }

  void _addForm() {
    int id = 0;
    // ensure unique form id while allowing reuse of removed form ids
    while (_formIds.contains(id)) {
      id++;
    }
    _formIds.add(id);

    forms.add(
      NewContactAddressEntryForm(
        key: Key("contactAddressEntryForm_$id"),
        id: ref.read(addressEntryDataProvider(id)).id,
        clipboard: clipboard,
        barcodeScanner: scanner,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    return Scaffold(
      backgroundColor: Theme.of(context).extension<StackColors>()!.background,
      appBar: AppBar(
        leading: AppBarBackButton(
          onPressed: () async {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
              await Future<void>.delayed(const Duration(milliseconds: 75));
            }
            if (mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          "New contact",
          style: STextStyles.navBarTitle(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: AppBarIconButton(
                key: const Key("addAddressBookEntryFavoriteButtonKey"),
                size: 36,
                shadows: const [],
                color: Theme.of(context).extension<StackColors>()!.background,
                icon: SvgPicture.asset(
                  Assets.svg.star,
                  color: _isFavorite
                      ? Theme.of(context)
                          .extension<StackColors>()!
                          .favoriteStarActive
                      : Theme.of(context)
                          .extension<StackColors>()!
                          .favoriteStarInactive,
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.only(
                // top: 8,
                left: 4,
                right: 4,
                bottom: 16,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // subtract top and bottom padding set in parent
                  minHeight: constraint.maxHeight - 16, // - 8,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_selectedEmoji != null) {
                            setState(() {
                              _selectedEmoji = null;
                            });
                            return;
                          }
                          showModalBottomSheet<dynamic>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (_) => const EmojiSelectSheet(),
                          ).then((value) {
                            if (value is Emoji) {
                              setState(() {
                                _selectedEmoji = value;
                              });
                            }
                          });
                        },
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: Stack(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .textFieldActiveBG,
                                ),
                                child: Center(
                                  child: _selectedEmoji == null
                                      ? SvgPicture.asset(
                                          Assets.svg.user,
                                          height: 24,
                                          width: 24,
                                        )
                                      : Text(
                                          _selectedEmoji!.char,
                                          style:
                                              STextStyles.pageTitleH1(context),
                                        ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 14,
                                  width: 14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .accentColorDark),
                                  child: Center(
                                    child: _selectedEmoji == null
                                        ? SvgPicture.asset(
                                            Assets.svg.plus,
                                            color: Theme.of(context)
                                                .extension<StackColors>()!
                                                .textWhite,
                                            width: 12,
                                            height: 12,
                                          )
                                        : SvgPicture.asset(
                                            Assets.svg.thickX,
                                            color: Theme.of(context)
                                                .extension<StackColors>()!
                                                .textWhite,
                                            width: 8,
                                            height: 8,
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Constants.size.circularBorderRadius,
                        ),
                        child: TextField(
                          autocorrect: Util.isDesktop ? false : true,
                          enableSuggestions: Util.isDesktop ? false : true,
                          controller: nameController,
                          focusNode: nameFocusNode,
                          style: STextStyles.field(context),
                          decoration: standardInputDecoration(
                            "Enter contact name",
                            nameFocusNode,
                            context,
                          ).copyWith(
                            suffixIcon: ref
                                    .read(contactNameIsNotEmptyStateProvider
                                        .state)
                                    .state
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: UnconstrainedBox(
                                      child: Row(
                                        children: [
                                          TextFieldIconButton(
                                            child: const XIcon(),
                                            onTap: () async {
                                              setState(() {
                                                nameController.text = "";
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          onChanged: (newValue) {
                            ref
                                .read(contactNameIsNotEmptyStateProvider.state)
                                .state = newValue.isNotEmpty;
                          },
                        ),
                      ),
                      if (forms.length <= 1)
                        const SizedBox(
                          height: 8,
                        ),
                      if (forms.length <= 1) forms[0],
                      if (forms.length > 1)
                        for (int i = 0; i < forms.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Address ${i + 1}",
                                    style: STextStyles.smallMed12(context),
                                  ),
                                  BlueTextButton(
                                    onTap: () {
                                      _removeForm(forms[i].id);
                                    },
                                    text: "Remove",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              forms[i],
                            ],
                          ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlueTextButton(
                        onTap: () {
                          _addForm();
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent + 500,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: "+ Add another address",
                      ),
                      // GestureDetector(
                      //
                      //   child: Text(
                      //     "+ Add another address",
                      //     style: STextStyles.largeMedium14(context),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: Theme.of(context)
                                  .extension<StackColors>()!
                                  .getSecondaryEnabledButtonColor(context),
                              child: Text(
                                "Cancel",
                                style: STextStyles.button(context).copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .accentColorDark),
                              ),
                              onPressed: () async {
                                if (FocusScope.of(context).hasFocus) {
                                  FocusScope.of(context).unfocus();
                                  await Future<void>.delayed(
                                      const Duration(milliseconds: 75));
                                }
                                if (mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                bool nameExists = ref
                                    .watch(contactNameIsNotEmptyStateProvider
                                        .state)
                                    .state;

                                bool validForms = ref.watch(
                                    validContactStateProvider(forms
                                        .map((e) => e.id)
                                        .toList(growable: false)));

                                bool shouldEnableSave =
                                    validForms && nameExists;

                                return TextButton(
                                  style: shouldEnableSave
                                      ? Theme.of(context)
                                          .extension<StackColors>()!
                                          .getPrimaryEnabledButtonColor(context)
                                      : Theme.of(context)
                                          .extension<StackColors>()!
                                          .getPrimaryDisabledButtonColor(
                                              context),
                                  onPressed: shouldEnableSave
                                      ? () async {
                                          if (FocusScope.of(context).hasFocus) {
                                            FocusScope.of(context).unfocus();
                                            await Future<void>.delayed(
                                              const Duration(milliseconds: 75),
                                            );
                                          }
                                          List<ContactAddressEntry> entries =
                                              [];
                                          for (int i = 0;
                                              i < forms.length;
                                              i++) {
                                            entries.add(ref
                                                .read(addressEntryDataProvider(
                                                    forms[i].id))
                                                .buildAddressEntry());
                                          }
                                          Contact contact = Contact(
                                            emojiChar: _selectedEmoji?.char,
                                            name: nameController.text,
                                            addresses: entries,
                                            isFavorite: _isFavorite,
                                          );

                                          if (await ref
                                              .read(addressBookServiceProvider)
                                              .addContact(contact)) {
                                            if (mounted) {
                                              Navigator.of(context).pop();
                                            }
                                            // TODO show success notification
                                          } else {
                                            // TODO show error notification
                                          }
                                        }
                                      : null,
                                  child: Text(
                                    "Save",
                                    style: STextStyles.button(context).copyWith(
                                      color: shouldEnableSave
                                          ? Theme.of(context)
                                              .extension<StackColors>()!
                                              .buttonTextPrimary
                                          : Theme.of(context)
                                              .extension<StackColors>()!
                                              .buttonTextPrimaryDisabled,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
