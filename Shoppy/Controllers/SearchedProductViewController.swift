//
//  SearchedProductViewController.swift
//  Shoppy
//
//  Created by Tommy on 11/22/22.
//

import UIKit
import AlamofireImage

class SearchedProductViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var productArray = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableView.self, forCellReuseIdentifier: "cell")
        
        

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
        
        let productSearched = searchBar.text!
        
        let apiKey = "1f582b52cd8c4e079a55bf01a6540913"
                let url = URL(string: "https://api.spoonacular.com/food/products/search?query=\(productSearched)&apiKey=\(apiKey)")!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { [self] (data: Data?, response: URLResponse?, error: Error?) in
                    if let error = error {
                        //errorCallBack?(error)
                        print(error)
                    } else if let data = data,
                        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        
                        
                        productArray = dataDictionary["products"] as! [Dictionary<String, Any>]
                        
                        tableView.reloadData()
                        
                        print(productArray[0])
                        
                        //successCallBack(dataDictionary)
                    }
                }
                task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedProductCell", for: indexPath) as! SearchedProductCell
        cell.productName.text = productArray[indexPath.row]["title"] as! String
        let imageURL = URL(string: productArray[indexPath.row]["image"] as! String) as! URL
        cell.productImage.af.setImage(withURL: imageURL)
        
        return cell
    }
    
    
    func addProductToList(sender: UIButton) {
        var buttonNumber = sender.tag
        
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
