//
//  ViewController.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let dataController = TasksDataController()
    
    private lazy var tasksTableView: UITableView = {
        let tasksTableView = UITableView(frame: self.view.frame)
        tasksTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "task")
        tasksTableView.backgroundColor = .white
        tasksTableView.rowHeight = UITableView.automaticDimension
        
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        return tasksTableView
    }()
    
    private lazy var nothingView: NothingView = {
        let nothingView = NothingView()
        nothingView.addTaskButton.addTarget(self, action: #selector(goToAddTaskViewController), for: .touchUpInside)
        
        nothingView.translatesAutoresizingMaskIntoConstraints = false
        return nothingView
    }()
    
    private lazy var addTaskCircleButton: UIButton = {
        let addTaskCircleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        addTaskCircleButton.backgroundColor = UIColor(named: "primaryColor")
        addTaskCircleButton.setTitle("+", for: .normal)
        addTaskCircleButton.titleLabel!.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        addTaskCircleButton.clipsToBounds = true
        addTaskCircleButton.layer.cornerRadius = addTaskCircleButton.frame.width / 2
        addTaskCircleButton.addTarget(self, action: #selector(goToAddTaskViewController), for: .touchUpInside)
        
        addTaskCircleButton.translatesAutoresizingMaskIntoConstraints = false
        return addTaskCircleButton
    }()
    
    private func setupLayout() { 
        view.addSubview(nothingView)
        view.addSubview(tasksTableView)
        view.addSubview(addTaskCircleButton)
        
        if dataController.checkIfDataSourceIsEmpty() {
            tasksTableView.isHidden = true
            addTaskCircleButton.isHidden = true
            
            nothingView.isHidden = false
            
            NSLayoutConstraint.activate([
                nothingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                nothingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                nothingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                nothingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            tasksTableView.isHidden = false
            addTaskCircleButton.isHidden = false
            
            nothingView.isHidden = true
            
            tasksTableView.delegate = self
            tasksTableView.dataSource = self
            
            tasksTableView.reloadData()
            
            NSLayoutConstraint.activate([
                tasksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                addTaskCircleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                addTaskCircleButton.heightAnchor.constraint(equalToConstant: 60),
                addTaskCircleButton.widthAnchor.constraint(equalToConstant: 60),
                addTaskCircleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
            ])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }
    
    @objc private func goToAddTaskViewController() {
        let destinationVC = AddTaskViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.fetchAllTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = dataController.tasksData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskTableViewCell
        
        cell.taskNameLabel.text = task.value(forKey: "name") as? String
        cell.taskDescriptionLabel.text = task.value(forKey: "desc") as? String
        
        if task.value(forKey: "isDone") as? Bool == true {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            cell.tintColor = UIColor(named: "primaryColor")
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = dataController.tasksData[indexPath.row]
        
        if editingStyle == .delete {
            let deleteConfirmationAlert = UIAlertController(title: "Delete task", message: "Do you want to delete this task? This action can't be undone.", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                self.dataController.delete(item: task)
                
                tableView.reloadData()
                self.setupLayout()
            }
            
            let exitAction = UIAlertAction(title: "No", style: .default) { _ in
                deleteConfirmationAlert.dismiss(animated: true, completion: nil)
            }
            
            deleteConfirmationAlert.addAction(exitAction)
            deleteConfirmationAlert.addAction(deleteAction)
            present(deleteConfirmationAlert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = dataController.tasksData[indexPath.row]
        
        let destinationVC = TaskViewController()
        destinationVC.selectedTask = task
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = dataController.tasksData[indexPath.row]
        
        let isDone = task.value(forKey: "isDone") as! Bool
        let actionTitle = isDone ? "Undone" : "Done"
        
        let isDoneAction = UIContextualAction(style: .normal, title: actionTitle) { (action, view, completionHandler) in
            self.dataController.markingTaskAsFinished(item: task)
            tableView.reloadData()
        }
        
        isDoneAction.backgroundColor = isDone ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : UIColor(named: "primaryColor")
        let configuration = UISwipeActionsConfiguration(actions: [isDoneAction])
        return configuration
    }
}

