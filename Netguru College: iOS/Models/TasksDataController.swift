//
//  TasksDataController.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit
import CoreData

class TasksDataController {
    let notificationController = NotificationController()
    
    var tasksData = [NSManagedObject]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func fetchAllTasks() -> [NSManagedObject] {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            tasksData = try managedContext.fetch(fetchRequest)
        } catch let fetchError as NSError {
            print("Error! \(fetchError)")
        }
        
        return tasksData
    }
    
    func checkIfDataSourceIsEmpty() -> Bool {
        let dataSourceArray = fetchAllTasks()
        
        if dataSourceArray.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func addTaskToTasksData(name: String, description: String? = "", date: Date? = nil) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        let newTask = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        newTask.setValue(name, forKey: "name")
        newTask.setValue(description, forKey: "desc")
        newTask.setValue(date, forKey: "date")
        
        if date != nil {
            notificationController.setNotification(for: newTask)
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Something goes wrong with saving!")
        }
    }
    
    func delete(item: NSManagedObject) {
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(item)
        
        do {
            try managedContext.save()
        } catch {
            print("Something goes wrong with deleting!")
        }
    }
    
    func markingTaskAsFinished(item: NSManagedObject) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "name == %@", item.value(forKey: "name") as! String)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count != 0 {
                var isDone = item.value(forKey: "isDone") as! Bool
                
                isDone.toggle()
                results[0].setValue(isDone, forKey: "isDone")

            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try managedContext.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    func editTask(item: NSManagedObject, name: String, description: String) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "name == %@", item.value(forKey: "name") as! String)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count != 0 {
                results[0].setValue(name, forKey: "name")
                results[0].setValue(description, forKey: "desc")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try managedContext.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    init() {
        self.tasksData = fetchAllTasks()
    }
}
