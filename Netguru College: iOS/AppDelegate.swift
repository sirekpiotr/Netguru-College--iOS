//
//  AppDelegate.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let notificationCenter = NotificationController()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationCenter.notificationCenter.delegate = notificationCenter
        notificationCenter.setupPermissions()
        
        let mainViewController = MainViewController()
        mainViewController.view.backgroundColor = .white
        
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barTintColor = UIColor(named: "primaryColor")
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
   
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Netguru_College__iOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

