import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medicinal_plants/local_packages/elevarm_ui-0.12.0/lib/elevarm_ui.dart';
import 'package:medicinal_plants/widgets/custom_padding.dart';

import '../databases/model/search_history.model.dart';
import '../databases/services/search_history.service.dart';

class Search extends StatefulWidget {
  const Search({super.key, required BuildContext parentContext});

  @override
  State<StatefulWidget> createState() => _Search();
}

class _Search extends State<Search> {
  final _searchHistoryService = SearchHistoryService();

  final TextEditingController _searchInputController = TextEditingController();
  final List<SearchHistory> _searchHistories = [];

  @override
  void initState() {
    () async {
      final searchHistories = await _searchHistoryService.getAll();

      setState(() {
        _searchHistories.addAll(searchHistories);
      });
    }.call();

    super.initState();
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PagePadding(
        child: Column(
          children: [
            WidgetPadding(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 8, bottom: 16),
                child: Text(
                  'Tìm kiếm',
                  style: ElevarmFontFamilies.inter(
                    fontSize: ElevarmFontSizes.xl2,
                    fontWeight: ElevarmFontWeights.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            WidgetPadding(
              child: ElevarmTextInputField(
                prefixIconAssetName: HugeIcons.strokeRoundedSearch01,
                hintText: 'Bách bộ, Bạc hà, Bạch đồng nữ, ...',
                suffixIconAssetName: _searchInputController.text.isNotEmpty
                    ? HugeIcons.strokeRoundedCancel01
                    : null,
                controller: _searchInputController,
                onTapSuffix: _searchInputController.text.isNotEmpty
                    ? () {
                        setState(() {
                          _searchInputController.clear();
                        });
                      }
                    : null,
                errorText: null,
                enabled: true,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 12),
            WidgetPadding(
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevarmPrimaryButton.icon(
                  height: 48,
                  text: 'Tìm kiếm',
                  leadingIconAssetName: HugeIcons.strokeRoundedSearch01,
                  trailingIconAssetName: null,
                  onPressed: _searchInputController.text.isNotEmpty
                      ? () {
                          () async {
                            final result = await _searchHistoryService.insert(
                              SearchHistory(
                                keyword: _searchInputController.text,
                                createdDate: DateTime.now(),
                              ),
                            );

                            if (result != 0) {
                              final insertedSearchHistory =
                                  await _searchHistoryService.search(
                                    _searchInputController.text,
                                  );

                              if (insertedSearchHistory.isNotEmpty) {
                                setState(() {
                                  _searchHistories.insert(
                                    0,
                                    insertedSearchHistory.elementAt(0),
                                  );
                                });
                              }
                            }
                          }.call();
                        }
                      : null,
                ),
              ),
            ),
            _searchHistoriesWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _searchHistoriesWidget(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          WidgetPadding(
            child: ElevarmDivider(
              height: 80,
              thickness: 1,
              color: ElevarmColors.neutral100,
              child: Text(
                'Lịch sử tìm kiếm',
                style: ElevarmFontFamilies.inter(
                  fontSize: ElevarmFontSizes.xs,
                  fontWeight: ElevarmFontWeights.regular,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchHistories.isNotEmpty
                ? Scrollbar(
                    thumbVisibility: true,
                    child: WidgetPadding(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchInputController.text =
                                      _searchHistories[index].keyword;
                                });
                              },
                              child: ElevarmOutlinedCard(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _searchHistories[index].keyword,
                                              textAlign: TextAlign.left,
                                              style: ElevarmFontFamilies.inter(
                                                fontSize: ElevarmFontSizes.md,
                                                fontWeight:
                                                    ElevarmFontWeights.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              _searchHistories[index]
                                                  .createdDate
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              style: ElevarmFontFamilies.inter(
                                                fontSize: ElevarmFontSizes.sm,
                                                fontWeight:
                                                    ElevarmFontWeights.regular,
                                                color: ElevarmColors.neutral300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: ElevarmLinkNeutralButton.iconOnly(
                                            iconAssetName:
                                                HugeIcons.strokeRoundedCancel01,
                                            onPressed: () {
                                              () async {
                                                final result =
                                                    await _searchHistoryService
                                                        .delete(
                                                          _searchHistories[index]
                                                                  .id ??
                                                              0,
                                                        );

                                                if (result != 0) {
                                                  setState(() {
                                                    _searchHistories.removeAt(
                                                      index,
                                                    );
                                                  });
                                                }
                                              }.call();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 12),
                        itemCount: _searchHistories.length,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Không có lịch sử tìm kiếm',
                      style: ElevarmFontFamilies.inter(
                        fontSize: ElevarmFontSizes.md,
                        fontWeight: ElevarmFontWeights.bold,
                      ),
                    ),
                  ),
          ),
          if (_searchHistories.isNotEmpty)
            WidgetPadding(
              child: Padding(
                padding: const EdgeInsetsGeometry.directional(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevarmPrimaryButton.icon(
                    text: 'Xóa lịch sử tìm kiếm',
                    leadingIconAssetName: HugeIcons.strokeRoundedDelete01,
                    trailingIconAssetName: null,
                    height: 48,
                    onPressed: () {
                      () async {
                        final result = await _searchHistoryService.clearAll();

                        if (result != 0) {
                          setState(() {
                            _searchHistories.clear();
                          });
                        }
                      }.call();
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
