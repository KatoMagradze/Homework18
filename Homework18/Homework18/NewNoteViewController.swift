//
//  NewNoteViewController.swift
//  Homework18
//
//  Created by Kato on 5/8/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController, NotesDelegate {
    
    var note: [String] = []
    
    var isEditingNote = false
    var notesIndex = -1

    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addOrEditButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
        // Do any additional setup after loading the view.
    }
    


    @IBAction func onAddNoteTapped(_ sender: UIButton) {
        
            
        if isEditingNote {
                
            if notesIndex == -1 {return}
                
            let newContent = noteTextView.text
                
            note[notesIndex] = newContent ?? ""
            
            
        }
        else {
            
            let newnote = noteTextView.text!
            
            if newnote == "" {
            let alert1 = UIAlertController(title: "Cannot add blank note", message: "You must enter some text first.", preferredStyle: .alert)
            alert1.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert1, animated: true, completion: nil)
                }
                
            else{
                
                note.append(newnote)
                
        
                if let notesVC = self.navigationController?.viewControllers.first {
            
                let vc = notesVC as! ViewController
            
                vc.delegate = self
            
                vc.finalNote = self.note
                vc.tableView.reloadData()
 
                    
                self.navigationController?.popToViewController(notesVC, animated: true)
                }
            }
        }
            
        
    }
    
    func getNotesIndex(index: Int) {
        print(index)
        self.notesIndex = index
        self.isEditingNote = true
        
        addOrEditButton.setTitle("Save", for: .normal)
        
        let notes = note[index]
        
        noteTextView.text = notes
    }

}
