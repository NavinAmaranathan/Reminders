//
//  AddReminderViewController.swift
//  Reminder
//
//  Created by Navi on 11/07/22.
//

import UIKit

class AddReminderViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private var titleField: UITextField!
    @IBOutlet private var bodyField: UITextField!
    @IBOutlet private var datePicker: UIDatePicker!
    var reminderDetails: (() -> Void)?
    private var reminders = [Reminder]()
    private var manager = ReminderManager()
    
    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action methods

    @IBAction func didTapAdd() {
        if validateFields() == true {
            guard let title = titleField.text, let body = bodyField.text else {
                return
            }
            let reminder = Reminder(id: UUID(),
                                    title: title,
                                    subtitle: body,
                                    date: datePicker.date)
            reminders.append(reminder)
            manager.createReminder(reminder: reminder)
            reminderDetails?()
            dismiss(animated: true, completion: nil)
        } else {
            InfoView.shared.display(title: "OOPS", message: "Please enter title, body and pick a date", actionTitle: "Ok", action: nil, style: .actionSheet, target: self)
        }
    }
    
    // MARK: - Private methods
    
    private func validateFields() -> Bool {
        if let title = titleField.text, let body = bodyField.text {
            if title.isEmpty || body.isEmpty {
                return false
            }
        } else {
            return false
        }
        return true
    }
}
