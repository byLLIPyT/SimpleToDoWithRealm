//
//  TableViewController.swift
//  ToDoRelam
//
//  Created by Александр Уткин on 26.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
var tasksList: Results<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tasksList = realm.objects(Task.self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = tasksList[indexPath.row].task
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let task = tasksList[indexPath.row]
        if editingStyle == .delete {
            deleteTask(task: task, indexPath: indexPath)
        }
    }
    
    private func deleteTask(task: Task, indexPath: IndexPath) {
        
        try! realm.write{
            realm.delete(task)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    

    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Новая задача", message: "Введите новую задачу", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            let newTask = Task()
            newTask.task = task
            StorageManager.save(task: newTask)
            self.tableView.insertRows(at: [IndexPath(row: self.tasksList.count - 1, section: 0)], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    

}
