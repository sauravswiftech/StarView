//
//  StarView.swift
//  RatingView
//
//  Created by Saurav Kumar on 12/07/21.
//

import UIKit

@IBDesignable
class StarRateView: UIView {
    // MARK: - Properties
    private var imageViewList = [UIButton]()
    var updateRatingValue: ((_ value: Int) -> Void)?
    
    @IBInspectable
    var maxCount: Int = 5 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var fillImage: UIImage? =  UIImage(named: "shapeFill.png") {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var emptyImage: UIImage? = UIImage(named: "shapeEmpty.png") {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var halfImage: UIImage? = UIImage(named: "halfRating.png") {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var rating: Double = -1 {
        didSet {
            displayRating(rating)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
    }
    
    // MAKR: - View
    private func updateView() {
        imageViewList.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        for index in 1...maxCount {
            let button: UIButton = UIButton()
            button.setImage(emptyImage, for: .normal)
            button.tag = index
            button.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(clickedOnStar(_:)), for: .touchUpInside)
            imageViewList.append(button)
        }
        //Create UIStackView
        let stackView = UIStackView(arrangedSubviews: imageViewList)
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    
    @objc private func clickedOnStar(_ sender: UIButton) {
        updateViewAppearence(sender.tag.doubleValue)
    }
    
    private func updateViewAppearence(_ rating: Double) {
        var tag = 0
        for imageView in imageViewList {
            if rating >= imageView.tag.doubleValue {
                imageView.setImage(fillImage, for: .normal)
                setNeedsDisplay()
                tag = tag + 1
            } else {
                imageView.setImage(emptyImage, for: .normal)
                setNeedsDisplay()
            }
        }
        updateRatingValue?(tag)
       
    }

    private func displayRating(_ rating: Double) {
        guard rating <= maxCount.doubleValue else {
            return
        }
        self.isUserInteractionEnabled = false
        var toShowHalfRatingIndex: Int?
        let integerValue = Int(rating.integerPart)
        let fractionPart = rating.fractionPart
        var endIndex: Int = integerValue - 1
        if integerValue > 0 && fractionPart > 0 {
            toShowHalfRatingIndex = integerValue
            endIndex = integerValue
        } else if fractionPart > 0 {
            toShowHalfRatingIndex = 0
            endIndex = 0
        }
        guard endIndex >= 0 else { return }
        for index in 0...endIndex {
            if toShowHalfRatingIndex != nil && toShowHalfRatingIndex == index {
                imageViewList[index].setImage(halfImage, for: .normal)
                return
            }
            imageViewList[index].setImage(fillImage, for: .normal)
        }
        
    }
 
}

extension Double {
    
    var integerPart: Double {
        return Double(Int(self))
    }
    
    var fractionPart: Double {
        let fractionStr = "0.\(String(self).split(separator: ".")[1])"
        return Double(fractionStr)!
    }
}

extension Int {
    var doubleValue: Double {
        return Double(self)
    }
}

