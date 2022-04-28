//
//  TodoStore.swift
//  MolaTodo
//
//  Created by sittidetPawutinan on 28/4/2565 BE.
//

import Foundation

protocol TodoStoreProtocol {
    func getTodoList() -> [Todo]
    func save(todoList: [Todo])
    func isAlreadyInList(id: String) -> Bool
}

class TodoStore: TodoStoreProtocol {
    private var todoList: [Todo] = []
    
    func getTodoList() -> [Todo]{
        return todoList
    }
    
    func save(todoList: [Todo]){
        self.todoList = todoList
    }
    
    func isAlreadyInList(id: String) -> Bool{
        for item in todoList {
            if item.id == id {
                return true
            }
        }
        return false
    }
}
