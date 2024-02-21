import 'dart:io';

import 'package:crud/ui/common/image.dart';
import 'package:crud/ui/views/home/home_view.form.dart';
import 'package:flutter/material.dart';
import 'package:crud/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_edit_item_sheet_model.dart';

class AddEditItemSheet extends StackedView<AddEditItemSheetModel>
    with $HomeView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AddEditItemSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddEditItemSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? '',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceSmall,
          InkWell(
            onTap: viewModel.pickImageFromCamera,
            child: SizedBox(
              height: 110,
              width: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: viewModel.imagePath == null
                    ? request.description != null &&
                            request.description!.isNotEmpty
                        ? Image.network(
                            request.description!,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )
                        : Stack(
                            children: [
                              Image.asset(Images().noImage),
                              Positioned(
                                  bottom: 5,
                                  left: 35,
                                  child: Text(request.title == 'Add Item'
                                      ? 'Pick'
                                      : 'Change'))
                            ],
                          )
                    : Image.file(
                        File(viewModel.imagePath!.path),
                        fit: BoxFit.fitWidth,
                      ),
              ),
            ),
          ),
          verticalSpaceMedium,
          renderTextField('Title', titleController),
          verticalSpaceMedium,
          renderTextField('Description', descriptionsController),
          verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF674EA4))),
                    onPressed: () {
                      if (!viewModel.isBusy) {
                        request.title == 'Add Item'
                            ? viewModel.addItem(context)
                            : viewModel.editItem(context, request.data);
                      }
                    },
                    child: Text(
                      request.title == 'Add Item' ? 'Save' : 'Update',
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextFormField renderTextField(title, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        counterText: '',
        labelText: title,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  AddEditItemSheetModel viewModelBuilder(BuildContext context) =>
      AddEditItemSheetModel();

  @override
  void onDispose(AddEditItemSheetModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
