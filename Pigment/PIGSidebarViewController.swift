//
//  PIGSidebarViewController.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/10/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit

class PIGSidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let modes = ["Complementary", "Triade", "Analagous", "Shade", "Compound"]
    
    @IBOutlet weak var modeTableViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        modeTableViewController.delegate = self
        modeTableViewController.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModeCell") as! PIGTableViewCell
        cell.modeLabel.text = modes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modes.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = modes[indexPath.row]
        
        if(selectedItem == "Complementary") {
            PIGSelection.shared.selectedMode = .complimentary
        } else if(selectedItem == "Triade") {
            PIGSelection.shared.selectedMode = .triade
        } else if(selectedItem == "Analagous") {
            PIGSelection.shared.selectedMode = .analagous
        } else if(selectedItem == "Shade") {
            PIGSelection.shared.selectedMode = .shade
        } else if(selectedItem == "Compound") {
            PIGSelection.shared.selectedMode = .compound
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.revealViewController().setFront(viewController, animated: true)
        self.revealViewController().setFrontViewPosition(.left, animated: true)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
