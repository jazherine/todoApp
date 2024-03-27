import 'package:flutter/material.dart';
import 'package:todoapp/core/api_service.dart';
import 'package:todoapp/core/model/companies/companies.dart';
import 'package:todoapp/ui/shared/widgets/custom_card.dart';
import 'package:todoapp/ui/view/add_companies_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService apiService = ApiService.getInstance();
  List<Companies> companies = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hardware Android App'),
      ),
      floatingActionButton: _fabButton(),
      body: FutureBuilder<List<Companies>>(
        future: apiService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            if (snapshot.hasData) {
              return _listView(snapshot.data!);
            }
            return const Center(child: Text("No Data"));
          }
        },
      ),
    );
  }

  ListView _listView(List<Companies> dataList) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Container(
          height: 10,
          color: Colors.red,
        );
      },
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return dismiss(
            CustomCard(
              title: dataList[index].productName,
              subtitle: "${dataList[index].money}",
              imageURL: dataList[index].imageUrl,
            ),
            dataList[index].key!);
      },
    );
  }

  Widget dismiss(Widget child, String key) {
    return Dismissible(
      key: UniqueKey(),
      secondaryBackground: const Center(
        child: Text("Hello"),
      ),
      onDismissed: (direction) async {
        await apiService.removeProducts(key);
      },
      background: Container(
        color: Colors.red,
      ),
      child: child,
    );
  }

  FloatingActionButton _fabButton() {
    void fabOnPressed() {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          context: context,
          builder: (context) => _bottomsheet);
    }

    return FloatingActionButton(
      onPressed: fabOnPressed,
      child: const Icon(Icons.add),
    );
  }

  Widget get _bottomsheet => SizedBox(
        height: 100,
        child: Column(
          children: [
            const Divider(
              thickness: 4,
              indent: 150,
              endIndent: 150,
              color: Colors.grey,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => const AddProductView(),
                ))
                    .then((value) {
                  if (value != null) {
                    apiService.getProducts();
                  }
                });
              },
              icon: const Icon(Icons.shopify_sharp),
              label: const Text("Add Product"),
            ),
          ],
        ),
      );
}
