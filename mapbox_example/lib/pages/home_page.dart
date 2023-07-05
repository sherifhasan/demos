import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../app_constants.dart';
import '../application/features/map/map_cubit.dart';
import '../gen/assets.gen.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxZoom = 20.0;
    final mapboxCubit = ref.watch(mapDataCubitProvider.bloc);
    final state = ref.watch(mapDataCubitProvider);
    final selectedIndex = useState(0);
    final currentLocation = useState(AppConstants.startLocation);
    late final MapController mapController;
    final pageController = usePageController();
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );
    useEffect(() {
      mapController = MapController();
      mapboxCubit.init();
      return null;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox sample'),
      ),
      body: state.when(
        initial: () => const SizedBox(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (results) => Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                minZoom: 5,
                maxZoom: maxZoom,
                zoom: 16,
                center: AppConstants.startLocation,
              ),
              children: [
                TileLayer(
                  urlTemplate: AppConstants.mapBoxUrlTemplate,
                  additionalOptions: const {
                    'mapStyleId': AppConstants.mapBoxStyleId,
                    'accessToken': AppConstants.mapBoxAccessToken,
                  },
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size: const Size(40, 40),
                      anchor: AnchorPos.align(AnchorAlign.center),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                        maxZoom: maxZoom,
                      ),
                      markers: [
                        for (int i = 0; i < results.length; i++)
                          Marker(
                            height: 40,
                            width: 40,
                            point: LatLng(results[i].geometry.location.lat,
                                results[i].geometry.location.lng),
                            builder: (_) {
                              return GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(
                                    i,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                  selectedIndex.value = i;
                                  currentLocation.value = LatLng(
                                      results[i].geometry.location.lat,
                                      results[i].geometry.location.lng);
                                  _animatedMapMove(currentLocation.value,
                                      mapController, animationController);
                                },
                                child: AnimatedScale(
                                  duration: const Duration(milliseconds: 500),
                                  scale: selectedIndex.value == i ? 1 : 0.7,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity:
                                          selectedIndex.value == i ? 1 : 0.5,
                                      child: Image.asset(
                                        Assets.restaurant.path,
                                        width: 56,
                                        height: 56,
                                      )),
                                ),
                              );
                            },
                          ),
                      ],
                      builder: (BuildContext context, List<Marker> markers) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 2,
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  selectedIndex.value = value;
                  currentLocation.value = LatLng(
                      results[value].geometry.location.lat,
                      results[value].geometry.location.lng);
                  _animatedMapMove(currentLocation.value, mapController,
                      animationController);
                },
                itemCount: results.length,
                itemBuilder: (_, index) {
                  final item = results[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color.fromARGB(255, 30, 29, 29),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: item.rating.toInt(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.icon,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _animatedMapMove(LatLng destLocation, MapController mapController,
      AnimationController animationController) {
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: 11.5);

    Animation<double> animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animationController.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animationController.dispose();
      } else {
        animationController.forward();
      }
    });
  }
}
