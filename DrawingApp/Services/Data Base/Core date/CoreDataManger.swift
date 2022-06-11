//
//  CoreDataManger.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManger {
        
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DrawingApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext () {
        
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManger: DataBaseService {
   

    func savePhotoWith(data: PhotoData){
        
        let photo = Photo(context: moc)
        photo.setValue(data.name, forKey: "name")
        photo.setValue(data.creatingDate, forKey: "creationDate")
        photo.setValue(data.id, forKey: "id")
        
        saveContext()
    }
    
    func fetchPhotos() -> [Photo] {
        do {
            let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
            let photos = try moc.fetch(fetchRequest)
            return photos
        } catch {
            print(error)
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    func deletePhotoWith(id: String){
        
        let photos = fetchPhotos()
        for photo in photos {
            if photo.id == id{
                moc.delete(photo)
                saveContext()
            }
        }
    }
    
}
