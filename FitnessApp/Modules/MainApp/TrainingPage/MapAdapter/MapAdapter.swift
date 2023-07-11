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
    
//    private func testCoordsCreation() {
//        let coords1 = CLLocationCoordinate2D(latitude: 53.935513, longitude: 27.5810050)
//        let coords2 = CLLocationCoordinate2D(latitude: 53.930333, longitude: 27.5756621)
//        let coords3 = CLLocationCoordinate2D(latitude: 53.925785, longitude: 27.5710916)
//        let coords4 = CLLocationCoordinate2D(latitude: 53.927655, longitude: 27.5667572)
//        testcoords = [coords1,coords2,coords3,coords4]
//        determineCurrentLocation()
//    }
    
    private func convertToTwoArrays(coordinates: [CLLocationCoordinate2D]) -> ([Double], [Double]) {
        var latitudeArr: [Double] = []
        var lonitudeArr: [Double] = []
        coordinates.forEach { elem in
            latitudeArr.append(elem.latitude)
            lonitudeArr.append(elem.longitude)
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
        updateLocation()
    }
    
    func updateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
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


