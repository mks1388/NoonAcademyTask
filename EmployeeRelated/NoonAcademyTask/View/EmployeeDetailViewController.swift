//
//  EmployeeDetailViewController.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import CoreData

protocol EmployeeDetailProtocol {
    var name: String? { get }
    var email_id: String? { get }
    var city: String? { get }
    var married: Bool { get }
    var aniversary_date: NSDate? { get }
}

class EmployeeDetailViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldCity: UITextField! {
        didSet {
            cityPicker.dataSource = self
            cityPicker.delegate = self
            textFieldCity.inputView = cityPicker
        }
    }
    @IBOutlet weak var textFieldMarried: UITextField! {
        didSet {
            marritalStatusPicker.dataSource = self
            marritalStatusPicker.delegate = self
            textFieldMarried.inputView = marritalStatusPicker
        }
    }
    @IBOutlet weak var textFieldAniversaryDate: UITextField! {
        didSet {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.maximumDate = Date()
            datePicker.addTarget(self, action: #selector(self.didSelectAniversaryDate(_:)), for:.valueChanged)
            textFieldAniversaryDate.inputView = datePicker
        }
    }
    
    private lazy var cityPicker = UIPickerView()
    private lazy var marritalStatusPicker = UIPickerView()
    private lazy var interactor = DataInteractor()
    
    let picker = UIPickerView()
    
    var employee: EmployeeDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveData));
        navigationItem.title = "Employee Detail"
    }
    
    //MARK: Private
    private func populateFields() {
        guard let employee = employee else {
            textFieldAniversaryDate.isHidden = true
            return
        }
        textFieldName.text = employee.name
        textFieldEmail.text = employee.email_id
        textFieldCity.text = employee.city
        textFieldMarried.text = employee.married ? "YES" : "NO"
        textFieldAniversaryDate.isHidden = !employee.married
        textFieldAniversaryDate.text = (employee.aniversary_date as Date?)?.toString()
    }
    
    @objc private func saveData() {
        guard let name = textFieldName.text, !name.isEmpty else {
            return
        }
        guard let email = textFieldEmail.text, !email.isEmpty else {
            return
        }
        guard let city = textFieldCity.text, !city.isEmpty else {
            return
        }
        guard let married = textFieldMarried.text, !married.isEmpty else {
            return
        }
        let isMarried = married == "YES" ? true : false
        
        var aniversaryDate: Date? = nil
        
        if isMarried {
            guard let aniversary = textFieldAniversaryDate.text?.toDate() else {
                return
            }
            aniversaryDate = aniversary
        }
        
        interactor.saveData(name: name, email: email, city: city, isMarried: isMarried, aniversaryDate: aniversaryDate)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didSelectAniversaryDate(_ datePicker: UIDatePicker) {
        textFieldAniversaryDate.text = datePicker.date.toString()
    }
}

//MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension EmployeeDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == cityPicker || pickerView == marritalStatusPicker {
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return Constant.cityArr.count
        }
        if pickerView == marritalStatusPicker {
            return Constant.marritalStatusArr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPicker {
            return Constant.cityArr[row]
        }
        if pickerView == marritalStatusPicker {
            return Constant.marritalStatusArr[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker {
            textFieldCity.text = Constant.cityArr[row]
            return
        }
        if pickerView == marritalStatusPicker {
            textFieldMarried.text = Constant.marritalStatusArr[row]
            textFieldAniversaryDate.isHidden = row == 0
            return
        }
    }
}
