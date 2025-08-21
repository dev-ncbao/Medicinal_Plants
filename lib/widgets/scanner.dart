import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicinal_plants/local_packages/elevarm_ui-0.12.0/lib/elevarm_ui.dart'
    show
        ElevarmOutlineButton,
        ElevarmPrimaryButton,
        showElevarmSnackBar,
        ElevarmColors;
import 'package:medicinal_plants/widgets/result.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key, required BuildContext parentContext});

  @override
  State<StatefulWidget> createState() => _Scanner();
}

class _Scanner extends State<Scanner> {
  XFile? _imageOrPhoto;
  final ImagePicker _imagePicker = ImagePicker();
  AnimationController? _snackBarAnimationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: DottedBorder(
              options: RectDottedBorderOptions(
                color: Colors.black,
                strokeWidth: 2,
                dashPattern: [8, 10],
              ),
              child: SizedBox.expand(
                child: _imageOrPhoto == null
                    ? _ImagePlaceHolder()
                    : Image.file(File(_imageOrPhoto!.path)),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(width: double.infinity, child: _searchButton()),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _takePhotoButton()),
              SizedBox(width: 12),
              Expanded(child: _pickFromGalleryButton()),
            ],
          ),
        ],
      ),
    );
  }

  ElevarmPrimaryButton _searchButton() {
    return ElevarmPrimaryButton.icon(
      text: 'Tra cứu',
      onPressed: _imageOrPhoto != null
          ? () {
              true
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Result(parentContext: context),
                      ),
                    )
                  : showElevarmSnackBar(
                      context: context,
                      iconAssetName: HugeIcons.strokeRoundedAlert01,
                      alignment: Alignment.topRight,
                      iconColor: ElevarmColors.danger,
                      title: 'Không tìm thấy dữ liệu cây thuốc nam',
                      subtitle:
                          'Cây thuốc nam không được tìm thấy trong cơ sở dữ liệu hoặc chưa nhận dạng được. '
                          'Bạn vui lòng điều chỉnh hình ảnh nhé!',
                      duration: Duration(milliseconds: 100),
                      dismissDuration: Duration(milliseconds: 100),
                      reverseDuration: Duration(milliseconds: 100),
                      onCloseButton: (animationController) {
                        animationController?.reverse();
                      },
                      onAnimationControllerInit: (animationController) {
                        // animationController.duration = Duration(milliseconds: 500);
                        _snackBarAnimationController = animationController;
                        _snackBarAnimationController?.duration =
                            _snackBarAnimationController?.reverseDuration =
                                Duration(milliseconds: 400);
                      },
                    );
            }
          : null,
      // height: 36,
      leadingIconAssetName: HugeIcons.strokeRoundedSearch01,
      trailingIconAssetName: null,
    );
  }

  ElevarmOutlineButton _takePhotoButton() {
    return ElevarmOutlineButton.icon(
      text: 'Chụp ảnh',
      onPressed: () async {
        _imageOrPhoto = await _imagePicker.pickImage(
          source: ImageSource.camera,
        );

        if (_imageOrPhoto != null) {
          setState(() {
            _imageOrPhoto;
          });
        }
      },
      // height: 36,
      leadingIconAssetName: HugeIcons.strokeRoundedCamera01,
      trailingIconAssetName: null,
    );
  }

  ElevarmOutlineButton _pickFromGalleryButton() {
    return ElevarmOutlineButton.icon(
      text: 'Thư viện',
      onPressed: () async {
        _imageOrPhoto = await _imagePicker.pickImage(
          source: ImageSource.gallery,
        );

        if (_imageOrPhoto != null) {
          setState(() {
            _imageOrPhoto;
          });
        }
      },
      // height: 36,
      leadingIconAssetName: HugeIcons.strokeRoundedImage02,
      trailingIconAssetName: null,
    );
  }
}

class _ImagePlaceHolder extends StatelessWidget {
  const _ImagePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/ai-scan-stroke-rounded.svg',
          width: 128,
          height: 128,
        ),
        SizedBox(height: 8),
        Text(
          'Ấn vào các nút bên dưới để chụp ảnh'
          '\nhoặc tải ảnh lên từ thư viện ảnh của bạn.'
          '\n'
          '\nSau khi chọn được ảnh, '
          '\nhãy ấn nút \'Tra cứu\' để thực hiện tìm kiếm.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
