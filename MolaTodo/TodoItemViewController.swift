//
//  TodoItemViewController.swift
//  MolaTodo
//
//  Created by sittidetPawutinan on 25/4/2565 BE.
//

import UIKit

protocol TodoItemViewControllerDelegate: AnyObject{
    func onUpdated(todoItem: Todo)
}

class TodoItemViewController: UIViewController {

    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var todoTypePickerView: UIPickerView!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
//    var todoItem = Todo(
//        id: UUID().uuidString,
//        details: "My todo list",
//        type: TodoType.todoList,
//        dueDate: Date(),
//        isDone: false)
    
    var todoItem: Todo?
    
    weak var delegate: TodoItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTypePickerView.dataSource = self
        todoTypePickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let todoItem = todoItem {
            detailsTextView.text = todoItem.details
            dueDatePickerView.date = todoItem.dueDate
            isDoneSwitch.isOn = todoItem.isDone
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if todoItem == nil {
            todoItem = Todo()
        }
        if var todoItem = todoItem {
            todoItem.details = detailsTextView.text
            todoItem.dueDate = dueDatePickerView.date
            
            let selectedValue = todoTypePickerView.selectedRow(inComponent: 0)
            //print(selectedValue)
            todoItem.type = TodoType.allItem[selectedValue]
            todoItem.isDone = isDoneSwitch.isOn
            
            
            delegate?.onUpdated(todoItem: todoItem)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate Handler

extension TodoItemViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TodoType.allItem.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TodoType.allItem[row].rawValue
    }
}
