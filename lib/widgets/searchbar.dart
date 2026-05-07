import 'package:flutter/material.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:gifza/providers/searchProvider.dart';
import 'package:gifza/services/embeddingService.dart';
import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/services/tokenizerService.dart';
import 'package:gifza/widgets/alerts/errorAlert.dart';
import 'package:gifza/widgets/alerts/loadingAlert.dart';
import 'package:provider/provider.dart';

class GifzaSearchBar extends StatefulWidget {
  GifzaSearchBar({super.key});

  @override
  State<GifzaSearchBar> createState() => _GifzaSearchBarState();
}

class _GifzaSearchBarState extends State<GifzaSearchBar> {
  String queryText = "";
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final searchProvider = Provider.of<SearchProvider>(context);
    final screenProvider = Provider.of<ScreenProvider>(context);
    final objectBox = context.read<ObjectBoxService>();
    final embeddings = context.read<EmbeddingService>();
    final tokenizer = context.read<ClipTokenizerService>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 250),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Color(0xFF141f38), borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 10),
          child: Row(
            spacing: 3,
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                onChanged: (text) {
                  setState(() {
                    queryText = text;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search my library ...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
              )),
              GestureDetector(
                onTap: (queryText.isEmpty)
                    ? () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ErrorAlert(
                                  errorTitle: 'Enter a search query');
                            });
                      }
                    : () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return LoadingAlert();
                            });
                        final queryTokens = tokenizer.tokenize(queryText);
                        final queryEmbedding =
                            await embeddings.generateEmbeddings(
                                assetType: AssetType.text, tokens: queryTokens);
                        final results = objectBox.findNClosestAssets(
                            N: 5, queryEmbedding: queryEmbedding!);
                        searchProvider.updateSearchResults(results: results!);
                        Navigator.pop(context);
                        screenProvider.routeToScreen(
                            screen: AppScreen.searchResults);
                      },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: BorderRadius.circular(48)),
                  child: Center(
                    child: Text('Search', style: textTheme.bodyMedium),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
