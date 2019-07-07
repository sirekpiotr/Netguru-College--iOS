//
//  TaskViewController.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 05/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    let notificationController = NotificationCenter()
    let dataController = TasksDataController()
    
    var selectedTask = NSManagedObject()
    var isEditingOn = false
    
    private lazy var nameTextFieldView: TaskNameView = {
        let nameTextFieldView = TaskNameView()
        nameTextFieldView.nameTextField.isUserInteractionEnabled = false
        nameTextFieldView.nameTextField.clearsOnBeginEditing = false
        
        nameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        return nameTextFieldView
    }()
    
    private lazy var descriptionView: TaskDescriptionView = {
        let descriptionView = TaskDescriptionView()
        descriptionView.descriptionTextView.isUserInteractionEnabled = false
        descriptionView.descriptionTextView.textColor = .black
        descriptionView.descriptionTextView.clearsOnInsertion = false
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionView
    }()
    
    private lazy var mainScrollViewContentView: UIView = {
        let mainScrollViewContentView = UIView()
        mainScrollViewContentView.addSubview(nameTextFieldView)
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
    
    private lazy var taskDoneButton: PrimaryActionButton = {
        let taskDoneButton = PrimaryActionButton()
        taskDoneButton.setTitle("Done", for: .normal)
        taskDoneButton.addTarget(self, action: #selector(setTaskAsDone), for: .touchUpInside)
        
        return taskDoneButton
    }()
    
    private lazy var editBarButtonItem: UIBarButtonItem = {
        let editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(allowEditing))
      
        return editBarButtonItem
    }()
    
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        let deleteBarButtonItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(deleteTask))
       
        return deleteBarButtonItem
    }()
    
    private func setupLayout() {
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .groupTableViewBackground
        
        view.addSubview(mainScrollView)
        view.addSubview(taskDoneButton)
        
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
            
            descriptionView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 20),
            descriptionView.leadingAnchor.constraint(equalTo: mainScrollViewContentView.leadingAnchor, constant: 0),
            descriptionView.trailingAnchor.constraint(equalTo: mainScrollViewContentView.trailingAnchor, constant: 0),
            
            taskDoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskDoneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            taskDoneButton.heightAnchor.constraint(equalToConstant: 50),
            taskDoneButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    
        nameTextFieldView.nameTextField.text = selectedTask.value(forKey: "name") as? String
        descriptionView.descriptionTextView.text = selectedTask.value(forKey: "desc") as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationItem.rightBarButtonItems = [deleteBarButtonItem, editBarButtonItem]
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustScrollViewSize(with: mainScrollView)
    }

    @objc private func deleteTask() {
        let deleteConfirmationAlert = UIAlertController(title: "Delete task", message: "Do you want to delete this task? This action can't be undone.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.dataController.delete(item: self.selectedTask)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let exitAction = UIAlertAction(title: "No", style: .default) { _ in
            deleteConfirmationAlert.dismiss(animated: true, completion: nil)
        }
        
        deleteConfirmationAlert.addAction(exitAction)
        deleteConfirmationAlert.addAction(deleteAction)
        present(deleteConfirmationAlert, animated: true)
    }
    
    @objc private func allowEditing() {
        isEditingOn.toggle()
        
        if isEditingOn {
            editBarButtonItem.title = "Done"
            
            nameTextFieldView.nameTextField.isUserInteractionEnabled = true
            descriptionView.descriptionTextView.isUserInteractionEnabled = true
        } else {
            let nameToSave = nameTextFieldView.nameTextField.text!
            let descriptionToSave = descriptionView.descriptionTextView.text
            
            dataController.editTask(item: selectedTask, name: nameToSave, description: descriptionToSave!)
            
            editBarButtonItem.title = "Edit"
            
            nameTextFieldView.nameTextField.isUserInteractionEnabled = false
            descriptionView.descriptionTextView.isUserInteractionEnabled = false
        }
    }
    
    @objc private func setTaskAsDone() {
        dataController.markingTaskAsFinished(item: selectedTask)
        
        taskDoneButton.isHidden = true
    }
}
