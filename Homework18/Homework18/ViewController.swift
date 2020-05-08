//
//  ViewController.swift
//  Homework18
//
//  Created by Kato on 5/8/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

protocol NotesDelegate {
    func getNotesIndex(index: Int)
}

class ViewController: UIViewController {
    
    var delegate: NotesDelegate?
    
    var finalNote: [String] = []
    var selectedCell = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        tableView.delegate = self
        tableView.dataSource = self
    }
    


    @IBAction func onAddTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "new_note", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! NewNoteViewController
        vc.note = self.finalNote
    }
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes_cell", for: indexPath) as! NotesCell
        
        cell.noteLabel.text = finalNote[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedCell = indexPath.row
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let displayVC = storyboard.instantiateViewController(withIdentifier: "display_note")
        
        if let vc = displayVC as? DisplayNoteViewController {
            vc.textToDisplay = finalNote[selectedCell]
        }
        
        present(displayVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            
            self.finalNote.remove(at: indexPath.row)
    
            tableView.reloadData()
            
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            
            print("edit tapped")
            print(String(indexPath.row))
            self.delegate?.getNotesIndex(index: indexPath.row)
            
            let tempstoryboard = UIStoryboard(name: "Main", bundle: nil)
            let temp = tempstoryboard.instantiateViewController(withIdentifier: "newnote_vc")
            tableView.reloadData()
 
            self.navigationController?.pushViewController(temp, animated: true)
 
            
            
        }
        
        edit.backgroundColor = .systemIndigo
        
        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return config
    }
    
}
