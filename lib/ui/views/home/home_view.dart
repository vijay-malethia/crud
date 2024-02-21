import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/ui/common/image.dart';
import 'package:crud/ui/views/home/home_view.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

///
import 'home_viewmodel.dart';
import 'package:crud/ui/common/app_colors.dart';
import 'package:crud/ui/widgets/slidable.dart';

@FormView(fields: [
  FormTextField(name: 'title'),
  FormTextField(name: 'descriptions'),
])
class HomeView extends StackedView<HomeViewModel> with $HomeView {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingButton(viewModel),
      body: SafeArea(
        child: renderItems(viewModel),
      ),
    );
  }

  renderItems(viewModel) {
    return StreamBuilder(
        stream: viewModel.itemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return renderItem(index, viewModel,
                        title: ds['title'],
                        description: ds['description'],
                        id: ds['id'],
                        imageurl: ds['image_url'] ?? '');
                  })
              : const SizedBox();
        });
  }

  Container renderItem(int index, viewModel,
      {title, description, id, imageurl}) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              color: Colors.grey.shade500,
              blurRadius: 6.0,
            ),
          ],
          color: const Color(0XFFFF5E5E),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: renderSlidable(index, viewModel,
          title: title, description: description, id: id, imageurl: imageurl),
    );
  }

  SlidableTile renderSlidable(int index, viewModel,
      {title, description, id, imageurl}) {
    return SlidableTile(
        valueKey: index,
        action: [
          InkWell(
            onTap: () => viewModel.deleteItem(id),
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          )
        ],
        motion: const BehindMotion(),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                child: Image.asset(
                  Images().noImage,
                  fit: BoxFit.fitWidth,
                ),
              )),
              Expanded(
                flex: 3,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                      color: Color(0XFFFFFAFF),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(description ?? ''),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          titleController.text = title;
                          descriptionsController.text = description;
                          viewModel.addEditItem(
                              title: 'Edit Item', id: id, imageurl: imageurl);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0XFFEBDDFE)),
                          child: const Icon(Icons.edit, size: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  FloatingActionButton floatingButton(viewModel) {
    return FloatingActionButton(
      onPressed: () => viewModel.addEditItem(title: 'Add Item'),
      child: const Icon(Icons.add),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('ITEMS'),
      backgroundColor: bgLight,
      centerTitle: true,
      elevation: 7,
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
