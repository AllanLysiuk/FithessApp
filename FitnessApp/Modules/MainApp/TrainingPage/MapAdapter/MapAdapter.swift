//
//  MapAdapter.swift
//  FitnessApp
//
//  Created by Allan on 10.07.23.
//

import Foundation
import MapKit
import CoreLocation

protocol MapAdapterDelegate: AnyObject {
    func returnCurrentLocation(latitude: [Double], longitude: [Double])
}

final class MapAdapter: NSObject {
    
    private weak var mapView: MKMapView?
    private weak var delegate: MapAdapterDelegate?
    private var locationManager: CLLocationManager?
    private var pathCoordinates:[CLLocationCoordinate2D] = []

    
    private func setUpMapView() {
        mapView?.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.requestAlwaysAuthorization()
    }

    
    private func convertToTwoArrays(coordinates: [CLLocationCoordinate2D]) -> ([Double], [Double]) {
        var latitudeArr: [Double] = []
        var lonitudeArr: [Double] = []
        if coordinates.count > 1 {
            coordinates.forEach { elem in
                latitudeArr.append(elem.latitude)
                lonitudeArr.append(elem.longitude)
            }
        }
        return (latitudeArr, lonitudeArr)
    }
}

//MARK: Adapter Protocol
extension MapAdapter: MapAdapterProtocol {
    func setUpMapView(_ mapView: MKMapView) {
        self.mapView = mapView
        setUpMapView()
    }
    
    func setUpItems(_ items: [CLLocationCoordinate2D]) {
        pathCoordinates = items
        if pathCoordinates.count == 0 {
            mapView?.removeAnnotations(mapView?.annotations ?? [])
            mapView?.removeOverlays(mapView?.overlays ?? [])
        }
        updateLocation()
    }
    
    func updateLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager?.startUpdatingLocation()
            }
        }
    }
    
    func setUpDelegate(_ delegate: MapAdapterDelegate) {
        self.delegate = delegate
    }
}

//MARK: MapView Delegate
extension MapAdapter: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.strokeColor = .blue
            testlineRenderer.lineWidth = 2.0
            return testlineRenderer
        }
        return MKPolylineRenderer()
    }
}

//MARK: CLLocationManager Delegate
extension MapAdapter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // adding map region
        print("delegate method call")
        if let userLocation = locations.last {
            let currentLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            pathCoordinates.append(currentLocation)
            print(pathCoordinates)
            let separatedCoordArr = convertToTwoArrays(coordinates: pathCoordinates)
            delegate?.returnCurrentLocation(latitude: separatedCoordArr.0, longitude: separatedCoordArr.1)
            
            let testline = MKPolyline(coordinates: pathCoordinates, count: pathCoordinates.count)
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            // adding annotation at particular point
            for each in 0..<pathCoordinates.count{
                let anno = MKPointAnnotation()
                anno.coordinate = pathCoordinates[each]
                mapView?.addAnnotation(anno as MKAnnotation)
            }
            mapView?.setRegion(region, animated: true)
            mapView?.addOverlay(testline)
        }
        locationManager?.stopUpdatingLocation()
    }

}


