//
//  PickerViewAdapterProtocol.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

protocol PickerViewAdapterProtocol {
    var selectedValue: Int { get }
    func setUpPickerView(_ pickerView: UIPickerView)
    func setUpRangeOfItems(_ range: NSRange)
   // func setUpDelegate(_ delegate: )
}
