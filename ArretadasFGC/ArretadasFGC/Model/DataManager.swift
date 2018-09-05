//
//  DataManager.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import CoreData

class DataManager {
    
    private var storeType: String!
    
    
    init(persistenceType: String = NSSQLiteStoreType){
        self.storeType = persistenceType
    }
	
	static var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "ArretadasFGC")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            storeDescription.type = storeType
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	
	static func saveContext () {
		let context = self.getContext()
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	static func getEntity(entity: String) -> (NSEntityDescription)?{
		let context = self.getContext()
		
        guard let description:NSEntityDescription = NSEntityDescription.entity(forEntityName: entity, in: context) else { return nil }
		
		return description
	}
	
	static func getContext () -> (NSManagedObjectContext) {
		return persistentContainer.viewContext
	}
	
	static func getAll(entity: NSEntityDescription) -> (success: Bool, objects: [NSManagedObject]){
		let context = self.getContext()
		
		let request:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>()
		request.entity = entity
		
		var result:[NSManagedObject]?
		
		do {
			result = try context.fetch(request) as? [NSManagedObject]
			return(true, result!)
		} catch {
			print("Failed reading all")
			return(false, result!)
		}
	}
	
	static func deleteAll(entity: NSEntityDescription) {
		let managedContext = self.getContext()
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
		fetchRequest.returnsObjectsAsFaults = false
		
		do
		{
			let results = try managedContext.fetch(fetchRequest)
			for managedObject in results
			{
				let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
				managedContext.delete(managedObjectData)
			}
			try managedContext.save()
		} catch let error as NSError {
			print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
		}
		
	}
    static func executeThe(query: NSPredicate, forEntityName entity: String ) -> [NSManagedObject]{
        let context = self.getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = query
        //request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
            
        } catch {
            print("Failed query")
        }
        return []

    }

}
