//
//  SearchedProductViewController.swift
//  Shoppy
//
//  Created by Tommy on 11/22/22.
//

import UIKit

class SearchedProductViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
        
        let productSearched = searchBar.text!
        
        let apiKey = "1f582b52cd8c4e079a55bf01a6540913"
                let url = URL(string: "https://api.spoonacular.com/food/products/search?query=\(productSearched)&apiKey=\(apiKey)")!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    if let error = error {
                        //errorCallBack?(error)
                        print(error)
                    } else if let data = data,
                        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(dataDictionary)
                        //successCallBack(dataDictionary)
                    }
                }
                task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedProductCell", for: indexPath) as! SearchedProductCell
        cell.productName.text = "testing"
        return cell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
