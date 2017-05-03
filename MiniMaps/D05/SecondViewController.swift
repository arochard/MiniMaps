//
//  SecondViewController.swift
//  D05
//
//  Created by Alexandre ROCHARD on 4/10/17.
//  Copyright © 2017 Alexandre ROCHARD. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listPlace: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listPlace.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        cell.textLabel?.text = SharedData.sharedInstance.places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.sharedInstance.places.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fc = self.tabBarController?.viewControllers?[0] as! FirstViewController
        fc.setLocation(id: indexPath.row)
        self.tabBarController?.selectedIndex = 0
    }
    

}

