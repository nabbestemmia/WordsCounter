//
//  TableViewController.swift
//  WordsCounter
//
//  Created by alessio on 24/01/2019.
//  Copyright © 2019 Giovannoli. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    let utilities = Utilities()
    let searchController = UISearchController(searchResultsController: nil)
    var wordsList = Dictionary<String, PropertiesForWord>()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didTapButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.searchController?.searchBar.delegate = self
            searchController.obscuresBackgroundDuringPresentation = false
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wordsList.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        let item  = wordsList[indexPath.row]
        cell.word.text = item.key
        cell.prime.text = "Prime: \(item.value.isPrime)"
        cell.occurrences.text = "Occurrences: \(item.value.occurrences)"
        return cell
    }
    
    func didGetText(contentText: String){
        wordsList = utilities.getWordsDictionaryFromList(list: utilities.getWordsFromText(text: contentText.lowercased()))
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    func didTapButton(){
        if let text = searchController.searchBar.text{
            Client().getText(url: text, onSuccess: {contentText in
                self.didGetText(contentText: contentText)
            }, onFailure: { error in
                self.searchController.isActive = false
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    DispatchQueue.main.async(execute:{
                        self.tableView.reloadData()
                        self.searchController.isActive = true
                    })
                }))
                self.wordsList = Dictionary<String, PropertiesForWord>()
                self.navigationController?.present(alert, animated: true)
                
            })
        }
    }

}

extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
}
