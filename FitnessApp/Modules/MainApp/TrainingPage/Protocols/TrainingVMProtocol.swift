//
//  TrainingVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import MapKit

protocol TrainingVMProtocol {
    func setUpDelegate(_ delegate: TrainingVCDelegate)
    func setUpMapView(_ mapView: MKMapView)
    func setUpMapItems()
    func checkTimer()
    func startStopButtonDidTap()
    func resetButtonDidTap()
    func startButonDidTap(isSelected: Bool)
}
