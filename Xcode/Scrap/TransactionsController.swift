//
//  TransactionsController.swift
//  Scrap
//
//  Created by Edwin on 12/5/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit

class TransactionsController: UIViewController, UITableViewDataSource
{

    
    let transactions = [("1 Transaction"),
                        ("2 Transaction"),
                        ("3 Transaction")]
    
    let offersByUser = [("1 offersByUser"),
                        ("2 offersByUser"),
                        ("3 offersByUser")]
    
    let wishlist = [("1 wishlist"),
                    ("2 wishlist"),
                    ("3 wishlist")]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 // first element in array of sections
        {
            //return Store.storeInstance().transactions.count
            return transactions.count
        }
        else if section == 1
        {
            //return Store.storeInstance().offersByUser.count
            return offersByUser.count
        }
        else
        {
            //return Store.storeInstance().wishList.count
            return wishlist.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = UITableViewCell()
        if indexPath.section == 0{
            var id = transactions[indexPath.row]
            cell.textLabel?.text = id
        }
        else if indexPath.section == 1{
            var id2 = offersByUser[indexPath.row]
            cell.textLabel?.text = id2
        }
        else
        {
            var id3 = wishlist[indexPath.row]
            cell.textLabel?.text = id3
        }
        return cell


//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: "OfferCell", for: indexPath)
//
//            let item = Store.storeInstance().offers[indexPath.row]
//
//            /*  CURRENTLY UNAVAILABLE JSON DATA - waiting on DB and Web tier
//
//             let imageView = cell.viewWithTag(0) as! UIImageView
//             imageView.downloadedFrom(link: item.pic)
//
//             let category = cell.viewWithTag(4) as! UILabel
//             category.text = "Category: \(item.category)"
//
//             let manufacture = cell.viewWithTag(6) as! UILabel
//             manufacture.text = "Manufacture: \(item.manufacture)"
//
//             let model = cell.viewWithTag(7) as! UILabel
//             model.text = "Model: \(item.model)"
//
//             let part = cell.viewWithTag(8) as! UILabel
//             part.text = "Part: \(item.part)"
//
//             */
//
//            let date = cell.viewWithTag(1) as! UILabel
//            date.text = "Date: \(item.dateTime)"
//
//            let distance = cell.viewWithTag(2) as! UILabel
//            distance.text = "Distance: \(item.distance)"
//
//            let price = cell.viewWithTag(3) as! UILabel
//            price.text = "Price: $\(item.price)"
//
//            let status = cell.viewWithTag(5) as! UILabel
//            status.text = "Status: \(item.status)"
//
//            return cell
//        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Transactions"
        }
        else if section == 1
        {
            return "Your Offers"
        }
        else
        {
            return "Wishlist"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    



}
