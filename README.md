Unit 8: Group 10 Milestone
===

# SHOPPY

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Overview
### Description
Our application aims to provide small scale businesses an outlet to recommend their products to both new and existing customers. 

### App Evaluation
- **Category:** Shopping
- **Mobile:** Our application would be designed to predominately run on mobile devices.
- **Story:** Evaluates users grocery item requests and recommends a variety of options from different retailers.
- **Market:** Individuals that need a method of organizing their shopping list before going out to make purchases.
- **Habit:** Our application focuses on convenience and accessibility, making it a viable tool to use anytime our users require grocery items.
- **Scope:** Our application eventually aims to further enhance user experience by enabling more personable services. One of these services includes recommending products related to frequent purchases made by the user.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [ ] The user must be able to search for items
- [x] The user must be able to log in upon opening application
- [ ] The system must display each item's price, location, and picture
- [ ] The user must be able to create a shopping list
- [ ] The user must be able to edit and delete a shopping list
- [ ] The user must be able to add and remove items to their shopping list


**Optional Nice-to-have Stories**

- [ ] The user should be able to review products
- [ ] The system should be able to recommend related products
- [ ] The user should be able to customize their account
- [ ] The system should organize products into categories
- [ ] The user should be able to favorite specific products


### 2. Screen Archetypes

* Login - User logs in or registers for an account
   * When user opens application, the system must prompt the user to enter login credentials 
* List Screen - User can manage created shopping lists 
   * Allows user to create new grocery lists
   * Allows user to edit and delete current lists
* Search Screen - Displays a variety of potential options of item
   * Permits user to view available options of required item
* Product Screen - Displays product information
   * Display product's price, picture and location
   * Allows user to add it to their shopping list
* Single List Screen - Displays all products from a specific list
   * Allows users to add items to grocery list
   * Allows users to remove items from the shopping list
   * Allows users to select a product to display more information about it.


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Lists
* Browse

Optional:
* Settings
* Favorites

**Flow Navigation** (Screen to Screen)
* Landing page
   * Login / Signup
* Login / Signup:
   * Homepage
* Homepage
   * Create new list
   * Access a list
   * Delete a list
   * Logout 
* Single List Screen
   * Logout
   * Homepage
   * Logout
* Product Screen
   * Add item
   * Logout
   * Single List page
* Search product
   * List page
   * Product
   * Logout


## Wireframes
![Wireframes-group10](https://user-images.githubusercontent.com/98708908/198906171-c0d84438-4f51-4531-9965-6d4dc4fe8321.JPG)

### [BONUS] Digital Wireframes & Mockups
https://www.figma.com/file/uuzEEKftJPLsdXoHxjeNd8/List-App-Wireframe?node-id=0%3A1

![DigitalWireframe-group10](https://imgur.com/THOAcL9.png)
### [BONUS] Interactive Prototype

![Interactive-group10](https://media2.giphy.com/media/62pdf8aIrIXgocXGcP/giphy.gif?cid=790b761166aa76aad07a95592f4cf7b86516f60adb95078e&rid=giphy.gif)


## Schema 

### Models

| Property | Type | Description|
|:--------:|:------:|:------------:|
| listID | String | Identification for one list in the various lists we use. |
| listName | String | A specific name for a list in use. |
| listArray | Array of products | An array of the products. |
| productID | String | Every item carries an identification point of some kind.  |
| productPrice | Double | This is the price of the item.  |
| productID | String | Every item carries an identification point of some kind.  |
| productImage | File | This involves an image of the product. This will be found using the api.  |
| productName | String | This is the name of the item.  |
| quantity | Int | This represents the amount of a specific item the user wishes to purchase.  |
| caloriesVal | Int | Number of calories in a unit.  |






### Networking

**List of network requests by screen**

- Homepage: 
  - (GET) Retrieve all lists
    ```swift
    let query = PFQuery(className: "Lists")
    //query.includeKey("author")
    query.includeKeys(["listid", "listname"])
    query.limit = 20        
    query.findObjectsInBackground { (lists, error) in
       if lists != nil {
          self.lists = lists!
          self.tableView.reloadData()
       }
    }
    ```
  - (DELETE) Delete a list
  
* Accessing API:
  * (GET) Item name, ID, image
    ```swift
    let url = URL(string: "_______")!
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
     
    // Insert API Key to request
    request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) { (data, response, error) in
      // This will run when the network request returns
      if let error = error {
         print(error.localizedDescription)
      } else if let data = data {
             let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
             let restDictionaries = dataDictionary["_______"] as! [[String: Any]]
             var lists: [List] = []
 
             for dictionary in restDictionaries {
                 let list = List.init(dict: dictionary)
                 lists.append(list) 
             }
                return completion(lists)
         }
      }

        cell.productn.text = list["productn"] as? String ?? ""
    
    		cell.productid.text = restaurant["productid"] as? String ?? ""
        
    
    if let imageUrlString = restaurant["image_url"] as? String {
        let imageUrl = URL(string: imageUrlString)
        cell.productImage.af.setImage(withURL: imageUrl!)
    }


    ```
* Create List Page:
  * (POST) Create new list
```swift
let list = PFObject(className: "Lists")
list["name"] = listName.text
list["products"] = [PFObject]() //array of products
list["author"] = PFUser.current()!
list.saveInBackground { (success, error) in
        	if success {
        		print("List saved successfully") }
        	else{
        		print("Error: \(error)")
        	}
}
```
* Search Page:
  * (GET) Search a product by its name
```swift
let query = PFQuery(className:"catalogItems")
query.whereKey("name", equalTo: "nameLabel.text") 
query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
	if let error = error {
		print(error.localizedDescription)
	} else if let objects = objects {
		print("Item found, found \(objects.count) unique entries of the item with the name")
for object in objects {
//Oliver note: hopefully this prints only once
	print("Product name: \(Object.name), Product price: \(Object.price), Product image: \(Object.image)") 
	Break 
		}
	}

}
```
  * (POST) Add product to a specific list
```swift
let product = PFObject(className: "Products") //Oliver note: Create a new “blank” Products object
    	product["name"] = nameLabel.text //Oliver note: Use text input fields for the new Products object
    	product["quantity"] = quantity.text //Oliver note: Same thing
    	product["price"] = price.text //Oliver note: Same thing
 
    	
selectedList.add(product, forKey: "Products") //Oliver note: append a (the new) Products object to the current shopping list
    	selectedList.saveInBackground {   (success, error) in //Oliver note: This simply saves it…
        		if success {
        			print("Product saved successfully")
}	else	{
        			print("Error: \(error)")
        		}
}

```
*Single List Page:
  * (GET) Get all products in a specific list
```swift
Let productList = selectedList["Products"] as? [PFObject] //Oliver note: return array(?) of products assigned to a specific shopping list
```
  * (DELETE) Delete a product from a list
```swift
selectedList.remove(product, forKey: "Products")
```


## Sprint Outline 
(Specifics were done using the github repository itself. 

Sprint Plan in place using GitHub project management flow.
GitHub Project created (1pt)
https://github.com/Tommy-Las/MobileApps-FinalProject



GitHub Milestones created (1pt)
https://trello.com/b/gdfqPBj5/shoppy-board
(This will be used for every sprint!)
(Currently set up as issues on the repository!)

Week 1: All classes and main storyboards will be set in place. 

Week 2: Implementation of API requests and progression between boards. 

Week 3: Continuing to work on the progression between board and a base working version of the project.

Week 4: Polish the existing application. Deal with any existing bugs with current deployment. 



GitHub Issues created from user stories (2pts)
In our github project.


Issues added to project and assigned to specific team members (1pt)
In our github project.


#### [OPTIONAL: Existing API Endpoints ####
**Chomp Food & Recipe Database API**
* Base URL: https://chompthis.com/api/v2/

| HTTP Verb | Endpoint | Description |
|:--------:|:------:|:------------:|
| GET | /food/branded/name.php | Get a branded food item by name. |





<img src='http://g.recordit.co/C7LYQccNG2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='http://g.recordit.co/DZzgW54EtS.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='http://g.recordit.co/DwcNJ8KZLZ.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

App Logo:
<img src='https://i.imgur.com/0dxmwuS.png' title='App Logo' width='' alt='App Logo' />

