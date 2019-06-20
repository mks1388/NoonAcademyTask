//
//  EmployeeCell.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
}

extension EmployeeCell: ReusableProtocol {
    static var identifier: String {
        return "employee_cell"
    }
}
