//
//  ViewController.swift
//  SpacexLauchesApp
//
//  Created by Elif on 29.11.2019.
//  Copyright © 2019 Elif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //View
    @IBOutlet weak var tableView: UITableView!
    //Variables
    var elementArray = [LaunchData]()
    var elementList = [LaunchData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getJsonData()
    }
    
    private func configureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func getJsonData()
    {
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        //1.
        let url = URL(string: "https://api.spacexdata.com/v2/launches/")
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { (data, responce, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2.
                if data != nil {
                    do {
                        /*
                         let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                             print(jsonResponse)
                         */
                        let user = try JSONDecoder().decode([LaunchData].self, from: data!)
                        self.elementArray = user
                        self.elementList = user
                        //print(self.elementList.count)
                        //print(self.elementList[1].flightNumber)
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementList.count //row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        cell.flightNumberLabel.text = String(describing: elementList[indexPath.row].flightNumber!)
        cell.missionNameLabel.text = String(describing: elementList[indexPath.row].mission_name!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



