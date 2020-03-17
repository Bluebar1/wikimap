import 'package:flutter/material.dart';


class AnimatedSummary extends StatefulWidget {
  AnimatedSummary(this.text);
  final String text;
  bool isExpanded = false;

  @override
  _AnimatedSummary createState() => new _AnimatedSummary();
}

class _AnimatedSummary extends State<AnimatedSummary> with TickerProviderStateMixin<AnimatedSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 200),
          child: new ConstrainedBox(
              constraints: widget.isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 73.0),
              child: new Text(
                  widget.text,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.subhead))),
      widget.isExpanded
          ? Align(
        alignment: Alignment.topRight,
        child: FlatButton(
            child: Text(
                'Less',
                style: Theme.of(context).textTheme.subtitle
            ),
            onPressed: () => setState(() => widget.isExpanded = false)),
      )//new ConstrainedBox(constraints: new BoxConstraints())
          : (widget.text.length > 300)
          ? Align(
        alignment: Alignment.topRight,
        child: FlatButton(
            child: Text(
                'View More',
                style: Theme.of(context).textTheme.subtitle
            ),
            onPressed: () => setState(() => widget.isExpanded = true)),
      )
          : Container()
    ]);
  }
}

/*
                                    Column(
                                      children: <Widget>[
                                        AnimatedSize(
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.linear,
                                          vsync: this,
                                          //vsync: this,

                                          child: ConstrainedBox(
                                            constraints: wikiArticleProvider.isSummaryExpanded ? BoxConstraints() : BoxConstraints(maxHeight:95.0),
                                            child: Text(
                                                wikiArticleProvider.summaryList[index],
                                                style: Theme.of(context).textTheme.subhead,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ))),
                                        wikiArticleProvider.isSummaryExpanded
                                          ? ConstrainedBox(constraints: BoxConstraints())
                                            : FlatButton(
                                          child: Text("Expande Summary"),
                                          onPressed: () {
                                            wikiArticleProvider.setSummaryTrue();
                                          },
                                        )
                                      ],
                                    )
 */