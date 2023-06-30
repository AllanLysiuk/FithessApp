//
//  PickerViewAdapter.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class PickerViewAdapter: NSObject {
    private weak var pickerView: UIPickerView?
    private var rangeArray: [Int] = []
    var selectedValue: Int = 0
    
    private func setUpPickerView() {
        pickerView?.delegate = self
        pickerView?.dataSource = self

    }
}

//MARK: Adapter protocol
extension PickerViewAdapter: PickerViewAdapterProtocol {
    
    func setUpPickerView(_ pickerView: UIPickerView) {
        self.pickerView = pickerView
        self.setUpPickerView()
    }
    
    func setUpRangeOfItems(_ range: NSRange) {
        let itemsRange = Range(range)!
        for elem in itemsRange {
            rangeArray.append(elem)
        }
    }
}

//MARK: PickerView Delegate
extension PickerViewAdapter: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(rangeArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = row
    }
}


//MARK: PickerView DataSource
extension PickerViewAdapter: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rangeArray.count
    }
}
