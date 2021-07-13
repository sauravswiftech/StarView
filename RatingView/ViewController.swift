//
//  ViewController.swift
//  RatingView
//
//  Created by Saurav Kumar on 12/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var starView: StarRateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStarView()
        // Do any additional setup after loading the view.
    }

    func setUpStarView() {
        starView.rating = 3
        starView.updateRatingValue = {(value) in
            print("Value:- \(value)")
        }
    }
}

