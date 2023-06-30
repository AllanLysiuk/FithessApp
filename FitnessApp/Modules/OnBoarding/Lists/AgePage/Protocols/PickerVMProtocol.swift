//
//  AgePageVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

protocol PickerVMProtocol {
    func setUpPickerView(_ pickerView: UIPickerView)
    func setUpRangeOfItems()
    func saveTapped()
}
