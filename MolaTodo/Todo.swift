//
//  Todo.swift
//  MolaTodo
//
//  Created by sittidetPawutinan on 25/4/2565 BE.
//

import Foundation
import UIKit

struct Todo {
    var id = UUID().uuidString
    var details = ""
    var type = TodoType.todoList
    var dueDate = Date()
    var isDone = false
    var icon: UIImage? {
        return UIImage(named: type.rawValue)
    }
}

enum TodoType: String{
    case todoList = "Todolist"
    case shopping = "Shopping"
    case work = "Work"
    
    static var allItem: [TodoType] {
        return [.todoList, .shopping, .work]
    }
    
    var icon: UIImage? {
        print(self.rawValue)
        return UIImage(named: self.rawValue)
    }
}
