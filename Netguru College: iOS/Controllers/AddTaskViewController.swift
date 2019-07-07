//
//  AddTaskViewController.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    let dataController = TasksDataController()
    
    private var selectedDate: Date?
    
    private lazy var nameTextFieldView: TaskNameView = {
        let nameTextFieldView = TaskNameView()
        
        nameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        return nameTextFieldView
    }()
    
    private lazy var descriptionView: TaskDescriptionView = {
        let descriptionView = TaskDescriptionView()
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionView
    }()
    
    private lazy var notificationView: NotificationView = {
        let notificationView = NotificationView()
        notificationView.backgroundColor = .white
        notificationView.addNotificationButton.addTarget(self, action: #selector(setDateForNewTask), for: .touchUpInside)
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        return notificationView
    }()
    
    private lazy var mainScrollViewContentView: UIView = {
        let mainScrollViewContentView = UIView()
        mainScrollViewContentView.addSubview(nameTextFieldView)
        mainScrollViewContentView.addSubview(notificationView)
        mainScrollViewContentView.addSubview(descriptionView)
        
        mainScrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
        return mainScrollViewContentView
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView()
        mainScrollView.addSubview(mainScrollViewContentView)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        return mainScrollView
    }()
    
    lazy var addTaskButton: PrimaryActionButton = {
        let addTaskButton = PrimaryActionButton()
        addTaskButton.setTitle("Save".uppercased(), for: .normal)
        addTaskButton.addTarget(self, action: #selector(saveNewTask), for: .touchUpInside)
        
        return addTaskButton
    }()
    
    private func setupLayout() {
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .groupTableViewBackground
        
        view.addSubview(mainScrollView)
        view.addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            mainScrollViewContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            mainScrollViewContentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainScrollViewContentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainScrollViewContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainScrollViewContentView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            mainScrollViewContentView.centerYAnchor.constraint(equalTo: mainScrollView.centerYAnchor),
            
            nameTextFieldView.topAnchor.constraint(equalTo: mainScrollViewContentView.topAnchor, constant: 0),
            nameTextFieldView.leadingAnchor.constraint(equalTo: mainScrollViewContentView.leadingAnchor, constant: 0),
            nameTextFieldView.trailingAnchor.constraint(equalTo: mainScrollViewContentView.trailingAnchor, constant: 0),
            
            notificationView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 20),
            notificationView.leadingAnchor.constraint(equalTo: mainScrollViewContentView.leadingAnchor, constant: 0),
            notificationView.trailingAnchor.constraint(equalTo: mainScrollViewContentView.trailingAnchor, constant: 0),
            
            descriptionView.topAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: 20),
            descriptionView.leadingAnchor.constraint(equalTo: mainScrollViewContentView.leadingAnchor, constant: 0),
            descriptionView.trailingAnchor.constraint(equalTo: mainScrollViewContentView.trailingAnchor, constant: 0),

            addTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addTaskButton.heightAnchor.constraint(equalToConstant: 50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
 
    @objc private func saveNewTask() {
        if nameTextFieldView.nameTextField.text != "" {
            guard let newTaskName = nameTextFieldView.nameTextField.text else { return }
            let newTaskDescription = descriptionView.descriptionTextView.text
            
            dataController.addTaskToTasksData(name: newTaskName, description: newTaskDescription, date: selectedDate)
            navigationController?.popToRootViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Empty task", message: "You can't add task without name. Please correct it, and try again!", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
    }
    
    @objc func setDateForNewTask() {
        let notificationDatePicker: UIDatePicker = UIDatePicker()
        notificationDatePicker.timeZone = NSTimeZone.local
        notificationDatePicker.frame = CGRect(x: 0, y: 30, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "Pick a date for reminder \n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(notificationDatePicker)
        
        let selectAction = UIAlertAction(title: "Set", style: UIAlertAction.Style.default, handler: { _ in
            self.selectedDate = notificationDatePicker.date
            
            let calendar = Calendar.current
            let day = calendar.component(.day, from: self.selectedDate!)
            let month = calendar.component(.month, from: self.selectedDate!)
            let year = calendar.component(.year, from: self.selectedDate!)
            let hour = calendar.component(.day, from: self.selectedDate!)
            let minute = calendar.component(.minute, from: self.selectedDate!)
            
            self.notificationView.addNotificationButton.setTitle("\(day)-\(month)-\(year) at \(hour):\(minute)", for: .normal)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New task"
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustScrollViewSize(with: mainScrollView)
    }
}
