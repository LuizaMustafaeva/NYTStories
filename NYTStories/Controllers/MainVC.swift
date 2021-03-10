//
//  ViewController.swift
//  NYTStories
//
//  Created by Luiza on 10.03.2021.
//  Copyright © 2021 Luiza. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var arrayOfType = [""]
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Stories"
        
        arrayOfType = ["arts", "automobiles", "books", "business", "fashion", "food", "health", "home", "insider", "magazine", "movies", "nyregion", "obituaries", "opinion", "politics", "realestate", "science", "sports", "sundayreview", "technology", "theater", "t-magazine", "travel", "upshot", "us", "world"]
        
        settingsOfTableView()
    }
    
    //MARK: - Settings of tableView
    private func settingsOfTableView(){
        
        tableView.register(UINib.init(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Extension UITableViewDelegate
extension MainVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let secondVC = SecondVC.init(nibName: "SecondVC", bundle: nil)
        
        let nameOfType = arrayOfType[indexPath.row]
        secondVC.nameOfType = nameOfType
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - Extension UITableViewDataSource
extension MainVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        
        let nameOfType = arrayOfType[indexPath.row]
        
        cell.nameLabel.text = nameOfType.capitalized
        cell.nameLabel.font = UIFont(name: "TimesNewRomanPSMT", size: 22)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
}


