//
//  StorageManager.swift
//  CoreDemoApp
//
//  Created by Виталий Бобрик on 19.04.22.
//

import Foundation
import CoreData
import UIKit

class StorageManager {
    static let shared = StorageManager()
    
    //private var taskList: [Task] = []
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    private init() { }
    
    func save(_ taskName: String) {
        var taskList = fetchData()
        let task = Task(context: viewContext)
        task.title = taskName
        taskList.append(task)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func fetchData() -> [Task] {
        let fetchRequest = Task.fetchRequest()
        guard let taskList = try? viewContext.fetch(fetchRequest) else {return []}
        return taskList
    }
    
    func deleteCell(at index: Int) {
        var taskList = fetchData()
        taskList.remove(at: index)
        if viewContext.hasChanges {
            print("yes")
            do {
                try self.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("no")
        }
    }
}
