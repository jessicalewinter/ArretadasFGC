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
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "ArretadasFGC")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	
	func saveContext () {
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
	
	func getEntity(entity: String) -> (NSEntityDescription){
		let context = self.getContext()
		
		let description:NSEntityDescription = NSEntityDescription.entity(forEntityName: entity, in: context)!
		
		return description
	}
	
	func getContext () -> (NSManagedObjectContext) {
		return persistentContainer.viewContext
	}
	
	func getAll(entity: NSEntityDescription) -> (success: Bool, objects: [NSManagedObject]){
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
	
	func getRecords(entity: NSEntityDescription, fetchOffset: Int) -> (success: Bool, objects: [NSManagedObject]){
		let context = self.getContext()
		
		let request:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>()
		request.fetchLimit = 10
		request.fetchOffset = fetchOffset
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
	
	func deleteAll(entity: NSEntityDescription) {
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

}
