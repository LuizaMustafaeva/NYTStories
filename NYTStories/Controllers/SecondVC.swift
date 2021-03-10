//
//  SecondVC.swift
//  NYTStories
//
//  Created by Luiza on 10.03.2021.
//  Copyright © 2021 Luiza. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var nameOfType: String?
    
    private var netManager = NetManager()
    private var stories: [Story] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsOfTableView()
        settingsOfActivityIndicator()
        getData()
    }
    
     //MARK: - Settings of tableView
    private func settingsOfTableView(){
        title = nameOfType?.capitalized
        
        tableView.register(UINib.init(nibName: "SecondCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.reloadData()
    }
    
    //MARK: - Settings of activity indicator
    private func settingsOfActivityIndicator(){
        
        activityIndicator.color = .black
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    //MARK: - Get data from NetManager
    private func getData(){
        
        guard let nameOfType = nameOfType else { return }
        netManager.doRequest(name: nameOfType) { story in
            
            self.stories = story.results!
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Extension UITableViewDelegate
extension SecondVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
           let detailVC = DetailVC.init(nibName: "DetailVC", bundle: nil)
           let url = stories[indexPath.row].url
           detailVC.urlString = url
               navigationController?.pushViewController(detailVC, animated: true)
       }
}

//MARK: - Extension UITableViewDataSource
extension SecondVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
        
        cell.nameLabel.text = stories[indexPath.row].title
        cell.nameLabel.font = UIFont(name: "TimesNewRomanPSMT", size: 18)
        cell.nameLabel.numberOfLines = 0
        
        return cell
    }
}


