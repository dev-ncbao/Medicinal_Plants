import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:medicinal_plants/local_packages/elevarm_ui-0.12.0/lib/elevarm_ui.dart';
import 'package:medicinal_plants/widgets/custom_padding.dart';
import 'package:medicinal_plants/widgets/result.dart';

import '../databases/model/search_history.model.dart';
import '../databases/model/search_result.model.dart';
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
  final List<SearchResult> _searchResults = [
    SearchResult(
      id: 1,
      plantName: 'Bitterleaf',
      descriptions: 'Used in traditional detox remedies.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 2,
      plantName: 'Golden Fern',
      descriptions: 'Thrives in shade, known for calming teas.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 3,
      plantName: 'Dragon Mint',
      descriptions: 'Spicy mint variant with digestive benefits.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 4,
      plantName: 'Cloudberry Vine',
      descriptions: 'Rare vine with antioxidant-rich berries.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 5,
      plantName: 'Jade Basil',
      descriptions: 'Bright green basil with citrus aroma.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 6,
      plantName: 'Moonleaf',
      descriptions: 'Glows faintly under moonlight, folklore favorite.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 7,
      plantName: 'Crimson Root',
      descriptions: 'Used in blood circulation tonics.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 8,
      plantName: 'Whispering Grass',
      descriptions: 'Sways with the wind, believed to ward off spirits.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 9,
      plantName: 'Tiger Balm Shrub',
      descriptions: 'Leaves used in muscle relief oils.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 10,
      plantName: 'Sapphire Aloe',
      descriptions: 'Blue-tinted aloe with skin healing properties.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 11,
      plantName: 'Lemongrass',
      descriptions: 'Classic for teas and mosquito repellent.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 12,
      plantName: 'Wild Ginger',
      descriptions: 'Spicy rhizome used in warming tonics.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 13,
      plantName: 'Star Anise Leaf',
      descriptions: 'Fragrant leaves used in soups and broths.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 14,
      plantName: 'Velvet Moss',
      descriptions: 'Soft moss used in poultices.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 15,
      plantName: 'Fireleaf',
      descriptions: 'Bright red leaves, used in fever remedies.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 16,
      plantName: 'Rain Orchid',
      descriptions: 'Blooms after storms, symbol of renewal.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 17,
      plantName: 'Cinnamon Vine',
      descriptions: 'Sweet aroma, used in warming teas.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 18,
      plantName: 'Ghost Pepper Leaf',
      descriptions: 'Mildly spicy leaves, used in folk medicine.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 19,
      plantName: 'Lotus Sprout',
      descriptions: 'Symbol of purity, used in meditation rituals.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 20,
      plantName: 'Amber Sage',
      descriptions: 'Golden leaves with memory-enhancing effects.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 21,
      plantName: 'Cactus Bloom',
      descriptions: 'Desert flower with hydrating gel.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 22,
      plantName: 'Pepperleaf',
      descriptions: 'Sharp taste, used in energizing tonics.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 23,
      plantName: 'Blueberry Thorn',
      descriptions: 'Thorny bush with edible berries.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 24,
      plantName: 'Sunroot',
      descriptions: 'Tubers used in digestive health.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 25,
      plantName: 'Lavender Mint',
      descriptions: 'Soothing scent, great for sleep teas.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 26,
      plantName: 'Frost Fern',
      descriptions: 'Thrives in cold, used in skin tonics.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 27,
      plantName: 'Coriander Bloom',
      descriptions: 'Fragrant flowers used in spice blends.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 28,
      plantName: 'Bamboo Sprig',
      descriptions: 'Symbol of strength, used in decoctions.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 29,
      plantName: 'Mintberry',
      descriptions: 'Hybrid leaf with cooling and sweet notes.',
      image: 'leaf-1.jpg',
    ),
    SearchResult(
      id: 30,
      plantName: 'Thunderleaf',
      descriptions: 'Said to absorb storm energy, mythical use.',
      image: 'leaf-1.jpg',
    ),
  ];

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
    return KeyboardDismisser(
      child: Container(
        child: PagePadding(
          child: Column(
            children: [
              // WidgetPadding(
              //   child: Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.only(top: 8, bottom: 16),
              //     child: Text(
              //       'Tìm kiếm',
              //       style: ElevarmFontFamilies.inter(
              //         fontSize: ElevarmFontSizes.xl2,
              //         fontWeight: ElevarmFontWeights.bold,
              //       ),
              //       textAlign: TextAlign.left,
              //     ),
              //   ),
              // ),
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
              _searchResultsWidget(context),
              // _searchHistoriesWidget(context),
            ],
          ),
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
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    'Lịch sử tìm kiếm',
                    style: ElevarmFontFamilies.inter(
                      fontSize: ElevarmFontSizes.xs,
                      fontWeight: ElevarmFontWeights.regular,
                    ),
                  ),
                  if (_searchHistories.isNotEmpty)
                    Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ElevarmColors.danger400,
                        borderRadius: BorderRadius.circular(
                          ElevarmBorderRadius.xl2,
                        ),
                      ),
                      child: Text(
                        _searchHistories.length.toString(),
                        style: ElevarmFontFamilies.inter(
                          fontSize: ElevarmFontSizes.xs,
                          fontWeight: ElevarmFontWeights.semibold,
                          color: ElevarmColors.white,
                        ),
                      ),
                    ),
                ],
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

  Widget _searchResultsWidget(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          WidgetPadding(
            child: ElevarmDivider(
              height: 80,
              thickness: 1,
              color: ElevarmColors.neutral100,
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    'Kết quả tìm kiếm',
                    style: ElevarmFontFamilies.inter(
                      fontSize: ElevarmFontSizes.xs,
                      fontWeight: ElevarmFontWeights.regular,
                    ),
                  ),
                  if (_searchResults.isNotEmpty)
                    Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ElevarmColors.danger400,
                        borderRadius: BorderRadius.circular(
                          ElevarmBorderRadius.xl2,
                        ),
                      ),
                      child: Text(
                        _searchResults.length.toString(),
                        style: ElevarmFontFamilies.inter(
                          fontSize: ElevarmFontSizes.xs,
                          fontWeight: ElevarmFontWeights.semibold,
                          color: ElevarmColors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isNotEmpty
                ? Scrollbar(
                    thumbVisibility: true,
                    child: WidgetPadding(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Result(parentContext: context),
                                  ),
                                );
                              },
                              child: ElevarmOutlinedCard(
                                child: Row(
                                  spacing: 12,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          ElevarmBorderRadius.sm,
                                        ),
                                        child: Image.asset(
                                          'assets/images/leaf-1.jpg',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _searchResults[index].plantName,
                                            textAlign: TextAlign.left,
                                            style: ElevarmFontFamilies.inter(
                                              fontSize: ElevarmFontSizes.md,
                                              fontWeight:
                                                  ElevarmFontWeights.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            _searchResults[index].descriptions +
                                                _searchResults[index]
                                                    .descriptions +
                                                _searchResults[index]
                                                    .descriptions +
                                                _searchResults[index]
                                                    .descriptions,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: ElevarmFontFamilies.inter(
                                              fontSize: ElevarmFontSizes.sm,
                                              fontWeight:
                                                  ElevarmFontWeights.regular,
                                              color: ElevarmColors.neutral300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 12),
                        itemCount: _searchResults.length,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Không được tìm thấy trong cơ sở dữ liệu',
                      style: ElevarmFontFamilies.inter(
                        fontSize: ElevarmFontSizes.md,
                        fontWeight: ElevarmFontWeights.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
