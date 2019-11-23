//
//  HomeController.swift
//  Scrap
//
//  Created by Edwin on 11/27/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit

var cellIndex = 0

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var offersTable: UITableView!
    var filterMenuVC : HomeFilterController!
    let dm = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeFilterVC") as? HomeFilterController
        
        // Swipe gesture for filter menu
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        
        offersTable.delegate = self
        dm.loadOffers {
            () in
            OperationQueue.main.addOperation {
                print("Offers: Load Finished")
                self.offersTable.reloadData()
            }
        }
    }
    
    @objc func respondToGesture(gesture : UISwipeGestureRecognizer)
    {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
            showFilterMenu()
        case UISwipeGestureRecognizer.Direction.right:
            closeFilterMenu()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Store.storeInstance().offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "OfferCell", for: indexPath)
        
        let item = Store.storeInstance().offers[indexPath.row]
        
        /*  CURRENTLY UNAVAILABLE JSON DATA - waiting on DB and Web tier
         
         let imageView = cell.viewWithTag(0) as! UIImageView
         imageView.downloadedFrom(link: item.pic)
         
         let category = cell.viewWithTag(4) as! UILabel
         category.text = "Category: \(item.category)"
         
         let manufacture = cell.viewWithTag(6) as! UILabel
         manufacture.text = "Manufacture: \(item.manufacture)"
         
         let model = cell.viewWithTag(7) as! UILabel
         model.text = "Model: \(item.model)"
         
         let part = cell.viewWithTag(8) as! UILabel
         part.text = "Part: \(item.part)"
         
        */
        
        let date = cell.viewWithTag(1) as! UILabel
        date.text = "Date: \(item.dateTime)"
        
        let distance = cell.viewWithTag(2) as! UILabel
        distance.text = "Distance: \(item.distance)"
        
        let price = cell.viewWithTag(3) as! UILabel
        price.text = "Price: $\(item.price)"
        
        let status = cell.viewWithTag(5) as! UILabel
        status.text = "Status: \(item.status)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        performSegue(withIdentifier: "offerDetailsSegue", sender: self)
    }
    
    @IBAction func filterBtnPressed(_ sender: UIBarButtonItem) {
        if AppDelegate.filterMenuBool{
            showFilterMenu()
        }else{
            closeFilterMenu()
        }
    }
    
    func showFilterMenu()
    {
        filterMenuVC.offersTable = self.offersTable
        // Transparent background
        self.filterMenuVC.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        // Add the view
        self.addChild(self.filterMenuVC)
        // Adjust to starting position
        self.filterMenuVC.view.frame = CGRect(x: UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
        // Show the view
        self.view.addSubview(self.filterMenuVC.view)
        
        // Animate view
        UIView.animate(withDuration: 0.3, animations: { ()->Void in
            self.filterMenuVC.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
        })
        
        AppDelegate.filterMenuBool = false
    }
    
    func closeFilterMenu()
    {
        self.offersTable.delegate = self
        
        UIView.animate(withDuration: 0.3, animations: { ()->Void in
            self.filterMenuVC.view.frame = CGRect(x: UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
            }) { (finished) in
                self.filterMenuVC.view.removeFromSuperview()
        }
        AppDelegate.filterMenuBool = true
    }
}
