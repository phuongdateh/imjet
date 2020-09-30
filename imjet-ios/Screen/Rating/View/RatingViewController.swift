//
//  RatingViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import Cosmos


class RatingViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var navigationBarWrapperView: UIView!
    @IBOutlet weak var backNavigationBarWrapperView: UIView!
    
    @IBOutlet weak var ratingContentLb: UILabel!
    
    @IBOutlet weak var ratingWrapperView: UIView!
    
    @IBOutlet weak var contentWrapperView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var confirmTitleLb: UILabel!
    
    // MARK: - Metadata
    class func storyBoardId() -> String {
        return "RatingViewController"
    }
    
    class func storyBoardName() -> String {
        return "Rating"
    }
    
    // MARK: - Properties
    let fullString = NSMutableAttributedString.init()
    var presenter: RatingPresenterProtocol?
    var journey: Journey? {
        return presenter?.journey
    }
    var ratingView: CosmosView!
    var ratePoint: Int = 0
    
    // MARK: - View LyfeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRatingTitle()
        setupRatingView()
        navigationBarWrapperView.addShadow()
        backNavigationBarWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backNavigationBarWrapperView_Tap)))
        
        ratingContentLb.attributedText = fullString
        
        contentWrapperView.layer.borderColor = ColorSystem.blackOpacity.cgColor
        contentWrapperView.layer.borderWidth = 0.5
        contentWrapperView.layer.cornerRadius = 10
        contentTextView.font = FontSystem.normalText
        contentTextView.textColor = ColorSystem.blackOpacity
        contentTextView.delegate = self
    
        confirmTitleLb.text = "GỬI ĐÁNH GIÁ"
        confirmTitleLb.font = FontSystem.buttonTitle
        confirmTitleLb.textColor = ColorSystem.white
        confirmWrapperView.layer.cornerRadius = 10
        confirmWrapperView.backgroundColor = ColorSystem.black
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_Tap)))
        
    }
    
    func setRatingTitle() {
        fullString.append(NSAttributedString.init(string: "Đánh giá chuyến đi", attributes: [.font: FontSystem.pageTitle, .foregroundColor: ColorSystem.black]))
        fullString.append(NSAttributedString.init(string: "\n\n\nCảm ơn bạn đã hoàn thành chuyến đi. Mỗi chuyến thành công của bạn tạo động lực cho chúng tôi hoàn thiện sản phẩm tốt hơn.", attributes: [.font: FontSystem.normalText, .foregroundColor: ColorSystem.black]))
    }
    
    func setupRatingView() {
        ratingView = CosmosView.init(frame: CGRect.init(x: 0, y: 0, width: ratingWrapperView.frame.size.width, height: ratingWrapperView.frame.size.height))
        ratingView.settings.totalStars = 5
        ratingView.settings.starSize = 35
        ratingView.settings.fillMode = .full
        ratingView.settings.filledImage = UIImage.init(assetId: .ratingFilled)?.withRenderingMode(.alwaysOriginal)
        ratingView.settings.emptyImage = UIImage.init(assetId: .ratingEmpty)?.withRenderingMode(.alwaysOriginal)
        ratingView.didTouchCosmos = { [weak self] point in
            if let weakSelf = self {
                weakSelf.ratePoint = Int(point)
            }
        }
        ratingWrapperView.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
//        let constraints: [NSLayoutConstraint] = [
//            NSLayoutConstraint.init(item: ratingView, attribute: .top, relatedBy: .equal, toItem: ratingWrapperView, attribute: .top, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: ratingView, attribute: .bottom, relatedBy: .equal, toItem: ratingWrapperView, attribute: .bottom, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: ratingView, attribute: .leading, relatedBy: .equal, toItem: ratingWrapperView, attribute: .leading, multiplier: 1, constant: 0),
//            NSLayoutConstraint.init(item: ratingView, attribute: .trailing, relatedBy: .equal, toItem: ratingWrapperView, attribute: .trailing, multiplier: 1, constant: 0)
//        ]
//        ratingWrapperView.addConstraints(constraints)
    }
    
    @objc func backNavigationBarWrapperView_Tap() {
        self.popViewController()
    }
    
    @objc func confirmWrapperView_Tap() {
        ViewService.showLoadingIndicator()
        if let journey = journey {
            let rating = Rating.init(partnerJourneyID: journey.getPartnerId())
            rating.point = ratePoint
            rating.content = contentTextView.text
            if let presenter = presenter {
                presenter.ratingJourney(id: journey.id, rating: rating)
            }
        }
    }
}

// MARK: - RatingViewProtocol
extension RatingViewController: RatingViewProtocol {
    func didRatingJourneySuccess() {
        ViewService.hideLoadingIndicator()
        self.popViewController()
    }
    
    func didRatingJourneyFail() {
        ViewService.hideLoadingIndicator()
        self.popViewController()
    }
}

// MARK: - UITextViewDelegate
extension RatingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Nhận xét của bạn ..."
        }
    }
}
