//
//  SearchedProductViewController.swift
//  Shoppy
//
//  Created by Tommy on 11/22/22.
//

import UIKit
import AlamofireImage
import Parse


class SearchedProductViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func plusClicked(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    var productArray = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self


        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
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
        cell.imageUrlStringCell = productArray[indexPath.row]["image"] as! String
        cell.productImage.af.setImage(withURL: imageURL)
        //cell.imageUrlItem = imageURL
        cell.setData(with: productArray[indexPath.row])
        
        return cell
    }
}
