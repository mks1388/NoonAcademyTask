//
//  String+Date.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation

extension String {
    func toDate( dateFormat format: String = "dd-MMM" ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
