import 'package:flutter/material.dart';
import 'package:medicinal_plants/local_packages/elevarm_ui-0.12.0/lib/elevarm_ui.dart';

class Result extends StatefulWidget {
  const Result({super.key, required BuildContext parentContext});

  @override
  State<StatefulWidget> createState() => _Result();
}

class _Result extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kết quả tìm kiếm',
          style: ElevarmFontFamilies.inter(
            fontSize: ElevarmFontSizes.lg,
            fontWeight: ElevarmFontWeights.semibold,
          ),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.asset('assets/images/leaf-1.jpg'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 24, bottom: 16),
                  child: Text(
                    'Tên cây',
                    style: ElevarmFontFamilies.inter(
                      fontSize: ElevarmFontSizes.xl2,
                      fontWeight: ElevarmFontWeights.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  lorem,
                  style: ElevarmFontFamilies.inter(
                    fontSize: ElevarmFontSizes.sm,
                    fontWeight: ElevarmFontWeights.regular,
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

final String lorem = '''
Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Aenean commodo ligula eget dolor.

Aenean massa.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.

Nulla consequat massa quis enim.

Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.

In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.

Nullam dictum felis eu pede mollis pretium.

Integer tincidunt. Cras dapibus.

Vivamus elementum semper nisi.

Aenean vulputate eleifend tellus.

Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.

Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus.

Phasellus viverra nulla ut metus varius laoreet.

Quisque rutrum. Aenean imperdiet.

Etiam ultricies nisi vel augue.

Curabitur ullamcorper ultricies nisi.

Nam eget dui. Etiam rhoncus.

Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum.

Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem.

Maecenas nec odio et ante tincidunt tempus.

Donec vitae sapien ut libero venenatis faucibus.

Nullam quis ante.

Etiam sit amet orci eget eros faucibus tincidunt.

Duis leo.

Sed fringilla mauris sit amet nibh.

Donec sodales sagittis magna.

Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,
''';
