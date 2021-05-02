//
//  Date.swift
//  KumuExam
//
//  Created by Macbook pro on 02/05/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import Foundation

extension Date {
    /**
     Formats a Date
     
     - parameters format: (String) for eg dd-MM-yyyy hh-mm-ss
     */
    
    func toHumanReadableFormat() -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMMM dd, yyyy"
        let dateString = dayTimePeriodFormatter.string(from: self)
        return dateString
    }
}
