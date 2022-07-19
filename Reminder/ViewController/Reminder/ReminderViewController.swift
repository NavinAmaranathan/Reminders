//
//  ReminderViewController.swift
//  Reminder
//
//  Created by Navi on 11/07/22.
//

import UIKit

class ReminderViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private var tableView: UITableView!
    var reminders: [Reminder]? = nil
    var manager = ReminderManager()
    
    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    // MARK: - Action methods

    @IBAction func didTapAddButton() {
        guard let addNewReminderVC = storyboard?.instantiateViewController(withIdentifier: "AddVC") as? AddReminderViewController else { return }
        addNewReminderVC.reminderDetails = {[weak self] in
            self?.updateUI()
        }
        present(addNewReminderVC, animated: true, completion: nil)
    }
    
    // MARK: - Private methods

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func updateUI() {
        reminders = manager.fetchReminders()
        if (reminders != nil && reminders?.count != 0) {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
