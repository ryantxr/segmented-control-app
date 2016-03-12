//
//  ViewController.swift
//  Segmented Control
//
//  Created by ryan teixeira on 3/12/16.
//  Copyright © 2016 Ryan Teixeira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    var dataFilter = 0
    
    var tableDataWork : [String] = ["Proposal", "Send mail", "Fix printer", "Send payroll", "Pay rent"]
    var tableDataHome : [String] = ["Car payment", "Mow lawn", "Carpet clean"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex {
            
            case 0:
                print("Home")
                dataFilter = 0
            case 1:
                print("Work")
                dataFilter = 1
            case 2:
                print("All")
                dataFilter = 2
            default:
                print("All")
                dataFilter = 2
        }
        reload()
    
    }
    
    func reload() {
        dispatch_async( dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("task-cell")

        var title: String?
        switch dataFilter {
            case 0:
                title = tableDataHome[indexPath.row]
            case 1:
                title = tableDataWork[indexPath.row]
            case 2:
                if indexPath.row < tableDataWork.count {
                    title = tableDataWork[indexPath.row]
                } else {
                    title = tableDataHome[indexPath.row - tableDataWork.count]
            }
            default:
                if indexPath.row < tableDataWork.count {
                    title = tableDataWork[indexPath.row]
                } else {
                    title = tableDataHome[indexPath.row + tableDataWork.count]
                }
        }
        cell?.textLabel?.text = title
        
        
        if cell != nil {
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If
        switch dataFilter {
        case 0: return tableDataHome.count
        case 1: return tableDataWork.count
        default: return tableDataHome.count + tableDataWork.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    

}

