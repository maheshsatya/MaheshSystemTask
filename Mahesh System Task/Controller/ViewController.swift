//
//  ViewController.swift
//  Mahesh System Task
//
//  Created by Apple on 29/10/18.
//  Copyright © 2018 Mahesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userObjects = [UserDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hiding both tableview and Indicatorview
        searchListTableView.isHidden = true
        activityIndicator.isHidden = true
        
        // Dynamic height for tableview
        searchListTableView.estimatedRowHeight = 50.0
        searchListTableView.rowHeight = UITableView.automaticDimension
        
        //Opening Searchbar Keyboard
        searchBar.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Reloading when view will shown
        DispatchQueue.main.async {
            self.searchListTableView.reloadData()
        }
    }

    //MARK: Getting Data from API
    func getDataFromApi(_ searchString: String) {
        self.view.isUserInteractionEnabled = false
        searchListTableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let apiString = "https://api.github.com/search/repositories?q="+searchString
        ApiHelper.requestGetApi(apiString: apiString, success: { (response) in
            self.userObjects.removeAll()
            if let responseData = response as? [String: AnyObject], let items = responseData["items"] as? [[String: AnyObject]] {
                // Convering into models
                for object in items {
                    let repoId = object["id"] as? Int
                    let full_name = object["full_name"] as? String
                    var login: String?
                    if let owner = object["owner"] as? [String: AnyObject] {
                        login = owner["login"] as? String
                    }
                    let description = object["description"] as? String
                    self.userObjects.append(UserDataModel.init(full_name: full_name, login: login, description: description, repoId: repoId))
                }
            }
            // Reloading the UI
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.searchListTableView.isHidden = false
                self.searchListTableView.reloadData()
                if self.userObjects.count > 0 {
                    self.searchListTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
                }
                self.view.isUserInteractionEnabled = true
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.showAlert(title: "Alert!", message: error)
            }
        }
    }
    

}
//MARK: SerachBar Delegates
extension ViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = nil
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        guard let searchString = searchBar.text, searchString.count > 0 else {
            return
        }
        searchBar.text = nil
        getDataFromApi(searchString)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

//MARK: Tableview Delegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell") as! UserDetailTableViewCell
        // Will check object is edited or not
        let editedObjects = UserDataInstance.instance.editedObjects.filter({ (object) -> Bool in
            return object.repoId == userObjects[indexPath.row].repoId
        })
        if editedObjects.count > 0 { // Setting Edited data and hightligted
            cell.userDataObject = editedObjects[0]
            cell.contentView.backgroundColor = UIColor.groupTableViewBackground
        } else {  // Setting data
            cell.userDataObject = userObjects[indexPath.row]
            cell.contentView.backgroundColor = UIColor.white
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Presenting to EditData Viewcontroller
        let editDataVC = self.storyboard?.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        let editedObjects = UserDataInstance.instance.editedObjects.filter({ (object) -> Bool in
            return object.repoId == userObjects[indexPath.row].repoId
        })
        if editedObjects.count > 0 {
            editDataVC.userObject = editedObjects[0]
        } else {
            editDataVC.userObject = userObjects[indexPath.row]
        }
        present(editDataVC, animated: true, completion: nil)
    }
    
}

