//  ViewController.swift

import UIKit
import RealmSwift

class ToDoListItem: Object{
    
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table: UITableView!
    
    //var tasks = [String]()
    var data = [ToDoListItem]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        data = realm.objects(ToDoListItem.self).map({$0})             //will return all ToDoListItems
        
        self.title = "Until Done"
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
        // Setup  (initial saving mechanism)
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].item         //구조체 사용
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Open the screen where we can see item info and delete
        let item = data[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "task") as? TaskViewController else{
            return
        }
        
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.item
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func didTapAddButton(){
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        //"update" is a function in EntryViewController
        //Everytime we call update() in EntryVC, the table view needs to reload (refetch tasks saved)
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh(){
        
        data = realm.objects(ToDoListItem.self).map({$0})
        table.reloadData()
    }
    
}
