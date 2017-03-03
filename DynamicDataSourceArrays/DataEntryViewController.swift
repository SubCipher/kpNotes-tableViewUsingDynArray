//
//  DataEntryViewController.swift
//  DynamicDataSourceArrays
//
//  Created by kpicart on 3/3/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit


class DynamicData: NSObject {
    //array for to present data to view controller
    //will work here but you might want it in separate file for house keeping purposes (would'nt want 100+ classes in one file)
    
    var stringArray: [String] = [ ]
}

class DataEntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //connect with DynamicData class for access to resources
    let dataSource = DynamicData()
    
    @IBOutlet weak var dataSubmission: UITextField!
    @IBOutlet weak var submissionButtonOutlet: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //give textField some color (note: the label color is set in storyBoard)
        dataSubmission.backgroundColor = UIColor.cyan
    }
    
    @IBAction func submissionButton(_ sender: UIButton) {
        
        //take in user input to populate userString w/data from UI input: func at end of file
        populateTheArray()
        
        //put array count into countLable as a string
        countLabel.text = "Strings in array: \(dataSource.stringArray.count)"
        
        //SeCReCT SaUCe: this reloads data so you can see it in the table view after array updates
        tableView.reloadData()
    }
    
    //do the table view stuff (tableViewDelgate and tableViewDataSource listed at top for this subClass
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //get the array count
        return dataSource.stringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        /* important for array to have some data or else crASHES: SEE func populateTheArray() */
        let arrayText = dataSource.stringArray[indexPath.row]
        cell.textLabel?.text = arrayText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if using diff viewController this would push a VC but here just we just "push" the label (a subclass of the same superClass)
        inputLabel?.text = dataSource.stringArray[indexPath.row]
    }
    
    func populateTheArray() {
        //put data from UI into array
        if (dataSubmission.text?.isEmpty)!{
            dataSource.stringArray.append("please enter some text")
        } else {
            dataSource.stringArray.append(dataSubmission.text!)
        }
        
    }
}
