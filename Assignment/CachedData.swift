//
//  CachedData.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import UIKit
import CoreData

class CachedData {
    static var shared = CachedData()
    private var originalList: [DataBaseDetail]?
    private init() { }
    
    private func addItemInDatabase(image: String, desc: String) { // create Item
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // create context
        let managedContext = appDelegate.persistentContainer.viewContext
        if let cartEntity = NSEntityDescription.entity(forEntityName: "NewsDetail", in: managedContext) {
            let cart = NSManagedObject(entity: cartEntity, insertInto: managedContext)
            cart.setValue(image, forKey: "imageURL")
            cart.setValue(desc, forKey: "desc")
            
            do {
                try managedContext.save()
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    
    private func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsDetail")
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let results = result as? [NSManagedObject] {
                
                for result in results {
                    managedContext.delete(result)
                    do {
                        try managedContext.save()
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
        } catch {
            print("Something went wrong")
        }
    }
    
    private func fetchDataAndUpdateList() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsDetail")
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if let results = result as? [NSManagedObject] {
                var tempArr = [DataBaseDetail]()
                for result in results {
                    
                    
                    if let imageURL = result.value(forKey: "imageURL") as? String, let desc = result.value(forKey: "desc") as? String {
                        print("imageURL:", imageURL, "desc:", desc)
                        tempArr.append(DataBaseDetail(imageURL: imageURL, desc: desc))
                    }
                    
                }
                self.originalList = tempArr.isEmpty ? self.originalList: tempArr
            }
            
        } catch {
            print("Something went wrong")
        }
    }
    
    func getDataInNewsDetailForm() -> [NewsArticleDetail] {
        fetchDataAndUpdateList()
        var temp = [NewsArticleDetail]()
        if let list = originalList {
            for item in list {
                temp.append(NewsArticleDetail(description: item.desc, urlToImage: item.imageURL))
            }
        }
        return temp
    }
    
    
    func saveDataInDataBase(_ list: [NewsArticleDetail]?) {
        if let list = list {
            deleteAllData()
            for item in list {
                if let image = item.urlToImage, let description = item.description {
                    addItemInDatabase(image: image, desc: description)
                }
            }
        }
    }
    
}
