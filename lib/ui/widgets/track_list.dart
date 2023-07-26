import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quran/features/quran/data/models/quran_model.dart';

import '../../config/locale/app_localizations.dart';

class TrackList extends StatefulWidget {
  final List<QuranModel> tracks;
  final List<String> sura;
  final int currentIndex;
  final void Function(int index) onClickTrack;

  const TrackList(
      {super.key,
      required this.tracks,
      required this.sura,
      this.currentIndex = 0,
      required this.onClickTrack});

  @override
  State<TrackList> createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  bool addToFav = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        //  color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(widget.tracks.length, (index) {
                    return trackItem(
                        track: widget.tracks[index],
                        isCurrent: widget.currentIndex == index,
                        context: context,
                        index: index == 114 ? 113 : index);
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget trackItem(
      {required QuranModel track,
      bool isCurrent = false,
      required BuildContext context,
      required int index}) {
    return InkWell(
      onTap: () {
        widget.onClickTrack(index);
        return;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.8, color: Theme.of(context).colorScheme.outline))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  _smallCover(),
                  _titleAndArtistName(
                      artistName:
                          AppLocalizations.of(context)?.translate('sheikh') ??
                              "sheikh",
                      title: widget.sura[index],
                      isCurrent: isCurrent,
                      context: context),
                ],
              ),
            ),
            isCurrent
                ? const SizedBox(
                    height: 44,
                    child: Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.purple,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _smallCover() {
    return CachedNetworkImage(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHpWMDBAp4yJ5Z4IFI7eO66-cYdNA39ZALR8r4wYIdbFcAyuLzNAtEqJ7U-EeeoFoHB3s&usqp=CAU',
      placeholder: (context, url) {
        return _imageBuilder();
      },
      errorWidget: (context, url, error) {
        return _imageBuilder();
      },
      imageBuilder: (context, imageProvider) {
        return _imageBuilder(placeholderImageProvider: imageProvider);
      },
    );
  }

  Widget _imageBuilder({
    ImageProvider placeholderImageProvider =
        const AssetImage("assets/images/quran.png"),
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 16),
      height: 44,
      width: 44,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: placeholderImageProvider, fit: BoxFit.cover)),
    );
  }

  Widget _titleAndArtistName(
      {required String artistName,
      required String title,
      bool isCurrent = false,
      required BuildContext context}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isCurrent ? Colors.purple : null,
                ),
          ),
          Text(
            artistName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isCurrent ? Colors.purple : null,
                ),
          )
        ],
      ),
    );
  }
}
