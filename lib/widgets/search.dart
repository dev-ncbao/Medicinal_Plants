import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medicinal_plants/local_packages/elevarm_icons-1.3.0/lib/elevarm_icons.dart'
    show ElevarmIconsOutline;
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
      // var result = await _searchHistoryServiceService.getAll();

      setState(() async {
        _searchHistories.addAll(await _searchHistoryService.getAll());
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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
            WidgetPadding(
              child: ElevarmDivider(
                height: 80,
                thickness: 1,
                color: ElevarmColors.neutral100,
                child: Text(
                  'Lịch sử tìm kiếm',
                  style: ElevarmFontFamilies.poppins(
                    fontSize: ElevarmFontSizes.xs,
                    fontWeight: ElevarmFontWeights.regular,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
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
                                  Text(
                                    _searchHistories[index].keyword,
                                    textAlign: TextAlign.left,
                                    style: ElevarmFontFamilies.poppins(
                                      fontSize: ElevarmFontSizes.sm,
                                      fontWeight: ElevarmFontWeights.regular,
                                    ),
                                  ),
                                  const Spacer(),
                                  ElevarmLinkNeutralButton.iconOnly(
                                    iconAssetName:
                                        HugeIcons.strokeRoundedCancel01,
                                    onPressed: () {},
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
