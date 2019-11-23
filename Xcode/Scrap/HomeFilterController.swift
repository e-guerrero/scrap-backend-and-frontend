//
//  HomeFilterController.swift
//  Scrap
//
//  Created by Edwin on 12/3/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit

class HomeFilterController: UIViewController, UITableViewDelegate {
    
    var offersTable : UITableView?
    let dm = DataManager()

    static var PRICE_UP = 1
    static var PRICE_DOWN = 2
    static var NEWEST = 3
    static var OLDEST = 4
    static var CLOSEST = 5
    static var FURTHEST = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        offersTable?.delegate = self
    }
    
    @IBAction func priceUpBtnPressed(_ sender: UIButton) {
        dm.loadOffersPriceUp {
            () in
            OperationQueue.main.addOperation {
                print("Offers Price Ascending: Load Finished")
                self.offersTable?.reloadData()
            }
        }
    }
    
    @IBAction func priceDownBtnPressed(_ sender: UIButton) {
        dm.loadOffersPriceDown {
            () in
            OperationQueue.main.addOperation {
                print("Offers Price Descending: Load Finished")
                self.offersTable?.reloadData()
            }
        }
    }
    
    @IBAction func newestBtnPressed(_ sender: UIButton) {
        dm.loadOffersNewest {
            () in
            OperationQueue.main.addOperation {
                print("Offers Newest: Load Finished")
                self.offersTable?.reloadData()
            }
        }
    }
    
    @IBAction func oldestBtnPressed(_ sender: UIButton) {
        dm.loadOffersOldest {
            () in
            OperationQueue.main.addOperation {
                print("Offers Oldest: Load Finished")
                self.offersTable?.reloadData()
            }
        }
    }
    
    @IBAction func closestBtnPressed(_ sender: UIButton) {
        dm.loadOffersClosest {
            () in
            OperationQueue.main.addOperation {
                print("Offers Closest: Load Finished")
                self.offersTable?.reloadData()
            }
        }
    }
    
    @IBAction func furthestBtnPressed(_ sender: UIButton) {
        dm.loadOffersFurthest {
            () in
            OperationQueue.main.addOperation {
                print("Offers Furthest: Load Finished")
                self.offersTable?.reloadData()
            }
        }
    }
}
