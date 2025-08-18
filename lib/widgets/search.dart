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
                onTapSuffix: null,
                errorText: null,
                enabled: true,
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
                            ElevarmOutlinedCard(
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
                                            _searchHistories[index].createdDate
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
                                        child:
                                            ElevarmLinkNeutralButton.iconOnly(
                                              iconAssetName: HugeIcons
                                                  .strokeRoundedCancel01,
                                              onPressed: () {
                                                setState(() {
                                                  _searchHistories.removeAt(
                                                    index,
                                                  );
                                                });
                                              },
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
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
