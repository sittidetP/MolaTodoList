//
//  TodoListViewController.swift
//  MolaTodo
//
//  Created by sittidetPawutinan on 28/4/2565 BE.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, TodoItemViewControllerDelegate, UITableViewDelegate {
    
    lazy var store: TodoStoreProtocol = {
        return TodoStore()
    }()
    
    var indexSelectedCell: Int? = nil
    
    var todoList: [Todo]{
        get {
            store.getTodoList()
        }
        set {
            store.save(todoList: newValue)
            tableView.reloadData()
        }
    }
    /*
    var todoList : [Todo] = [
        Todo(id: UUID().uuidString, details: "Test 1", type: .todoList, dueDate: Date(), isDone: false),
        Todo(id: UUID().uuidString, details: "Test 2", type: .shopping, dueDate: Date(), isDone: false),
        Todo(id: UUID().uuidString, details: "Test 3", type: .work, dueDate: Date(), isDone: false)
    ]*/

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        if let todoListcell = cell as? TodoListTableViewCell {
            todoListcell.detailsLabel.text = todoItem.details
            todoListcell.dueDateLabel.text = todoItem.dueDate.description
            todoListcell.iconImageView.image = todoItem.type.icon
            todoListcell.isDoneSwitch.isOn = todoItem.isDone
            return todoListcell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //print("row selected : \(indexPath.row)")
        indexSelectedCell = indexPath.row //set selectedRow index
        performSegue(withIdentifier: "updateSegue", sender: nil)
      }
    

//    @IBAction func addButtonTapped(_ sender: Any) {
//        let newItem = Todo(
//            id: UUID().uuidString,
//            details: "Test \(todoList.count + 1)",
//            type: .todoList,
//            dueDate: Date(),
//            isDone: false)
//        todoList.append(newItem)
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TodoItemViewController{
            if segue.identifier == "updateSegue" {
                if let index = indexSelectedCell {
                    vc.todoItem = todoList[index]
                }
            }
            vc.delegate = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func onUpdated(todoItem: Todo) {
        if !store.isAlreadyInList(id: todoItem.id){
            todoList.append(todoItem)
        }else {
            if let index = indexSelectedCell {
                //print(todoItem.type)
                todoList[index] = todoItem
            }
        }
        
    }
}
