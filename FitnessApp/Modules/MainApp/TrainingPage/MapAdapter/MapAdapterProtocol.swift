//
//  MapAdapterProtocol.swift
//  FitnessApp
//
//  Created by Allan on 10.07.23.
//

import Foundation
import MapKit

protocol MapAdapterProtocol {
    func setUpMapView(_ mapView: MKMapView)
    func updateLocation()
    func setUpItems(_ items: [CLLocationCoordinate2D])
   // func setUpDelegate(_ delegate: SettingsAdapterDelegate)
}
