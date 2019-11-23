//
//  OfferDetailsController.swift
//  Scrap
//
//  Created by Edwin on 12/5/18.
//  Copyright © 2018 gtech. All rights reserved.
//

import UIKit

class OfferDetailsController: UIViewController {
    
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var sellerID: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var partID: UILabel!
    @IBOutlet weak var offerID: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    @IBAction func buyBtnPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.text = "Date: \(Store.storeInstance().offers[cellIndex].dateTime)"
        status.text = "Status: \(Store.storeInstance().offers[cellIndex].status)"
        qty.text = "Quantity: \(Store.storeInstance().offers[cellIndex].qty)"
        sellerID.text = "Seller ID: \(Store.storeInstance().offers[cellIndex].sellerId)"
        price.text = "Price: \(Store.storeInstance().offers[cellIndex].price)"
        partID.text = "Part ID: \(Store.storeInstance().offers[cellIndex].partId)"
        offerID.text = "Offer ID: \(Store.storeInstance().offers[cellIndex].offerId)"
        distance.text = "Distance: \(Store.storeInstance().offers[cellIndex].distance)"
    }
}
