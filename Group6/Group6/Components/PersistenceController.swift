//
//  Persistence.swift
//  MyGroceryList
//
//  Created by Luigi Verolla on 10/02/22.
//

import CoreData

struct PersistenceController
{
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    init(inMemory : Bool = false)
    {
        container = NSPersistentContainer(name: "LoggedUser")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler:
        {
            (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Error: \(error), \(error.userInfo)")
            }
        })
    }
}
