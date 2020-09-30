//
//  ChooseAddressViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class ChooseAddressViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var sourceAddressTf: UITextField!
    @IBOutlet weak var destinationAddressTf: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lineDestinationWrapperView: UIView!
    @IBOutlet weak var lineSourceWrapperView: UIView!
    @IBOutlet weak var backButtonWrapperView: UIView!
    @IBOutlet weak var navigationBarSectionView: UIView!
    @IBOutlet weak var myAddressWrapperView: UIView!
    
    @IBOutlet weak var myAddressWrapperViewHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var myAddressView: MyAddressView?
    var presenter: ChooseAddressPresenterProtocol?
    var placeList: [GooglePlace] = []
    var isSourceAddressTf: Bool = true
    var builder: JourneyRequestBuilder!
    var isSearching: Bool = false {
        didSet {
            didSetIsSearching()
        }
    }
    @objc var extraInfo: [String: AnyObject] = [:]
    var info: GoogleGeocode? {
        didSet {
            updateView()
        }
    }
    private var isFirstTimeAppear: Bool = false
    
    // MARK: - MetaData
    class func storyBoardId() -> String {
        return "ChooseAddressViewController"
    }
    
    class func storyBoardName() -> String {
        return "ChooseAddress"
    }
    
    // MARK: - View Lyfecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        if isFirstTimeAppear == true {
            sourceAddressTf.selectAll(nil)
            destinationAddressTf.text = ""
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFirstTimeAppear = true
        setupUI()
        hideMyAddressWrapperView()
        
    }
    
    // MARK: - Method Setup UI and RenderView
    func setupUI() {
        lineSourceWrapperView.backgroundColor = ColorSystem.blackOpacity
        lineDestinationWrapperView.backgroundColor = ColorSystem.blackOpacity
        
        navigationBarSectionView.addShadow()
        navigationBarSectionView.backgroundColor = ColorSystem.white
        backButtonWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backButtonWrapperView_DidTap)))
        sourceAddressTf.returnKeyType = .search
//        sourceAddressTf.text = info.formattedAddress
        destinationAddressTf.returnKeyType = .search
        
        sourceAddressTf.delegate = self
        destinationAddressTf.delegate = self
        
//        ViewService.registerNibWithTableView(AddressResultsTableViewCell.getIdentifier(), tableView: tableView)
        tableView.registerCells(with: [AddressResultsTableViewCell.getIdentifier(), SearchingTableViewCell.getIdentifier()])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
//        if myAddressView == nil {
//            let view = ViewService.viewFrom(MyAddressView.nibName()) as! MyAddressView
//            myAddressView = view
//            myAddressView!.delegate = self
//            myAddressWrapperView.addChildView(myAddressView!)
//        }
        
        sourceAddressTf.text = ""
        if let sourceAddress = extraInfo[Constants.sourceAddress] as? String {
            sourceAddressTf.text = sourceAddress
        }
        
        addObserver(self, forKeyPath: #keyPath(sourceAddressTf), options: [.old], context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == #keyPath(extraInfo) {
            if isFirstTimeAppear == false {
                if let presenter = presenter {
                    presenter.pushJourney(extraInfo, builder)
                }
            }
        }
    }
    
    @objc func backButtonWrapperView_DidTap() {
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if let index = viewControllers.index(of: self), index > 0 {
                navigationController.popViewController(animated: true)
            }
        }
    }

    // MARK: - Action for UITextField
    @IBAction func sourceAddressTf_EditingChanged(_ sender: Any) {
        if let text = sourceAddressTf.text, text.count > 3 {
//            getAutocomplete(string: text)
            isSearching = true
        }
        else if let text = sourceAddressTf.text,
            text.count == 0{
            isSearching = false
        }
    }
    
    @IBAction func destinationAddressTf_EditingChanged(_ sender: Any) {
        if let text = destinationAddressTf.text, text.count > 3 {
//            getAutocomplete(string: text)
            isSearching = true
        }
        else if let text = destinationAddressTf.text,
        text.count == 0 {
            isSearching = false
        }
    }
    
    func getAutocomplete(string: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            if let weakSelf = self {
                if let presenter = weakSelf.presenter {
                    presenter.lookUpAddressFrom(string)
                }
            }
        })
    }
    
    func updateView() {
        var sourceAddressStr: String = ""
        if let sourceAddress = extraInfo["sourceAddress"] as? String {
            sourceAddressStr = sourceAddress
        }
        else if let info = info,
            let formattedAddress = info.formattedAddress {
            sourceAddressStr = formattedAddress
        }
        sourceAddressTf.text = sourceAddressStr
    }
    
    func hideMyAddressWrapperView() {
        myAddressWrapperViewHeightConstraint.constant = 0
    }
    
}

// MARK: - ChooseAddressViewProtocol
extension ChooseAddressViewController: ChooseAddressViewProtocol {
    func didLookUpAddressFromStrSuccess(placeList: [GooglePlace]) {
        self.placeList = placeList
        isSearching = false
        tableView.reloadData()
    }
    
    func didLookUpAddressFromStrFail() {
        isSearching = false
    }
    
    func didGetCurrentAddressSuccess(info: GoogleGeocode) {
        self.info = info
        ViewService.hideLoadingIndicator()
        hideMyAddressWrapperView()
    }
    
    func didGetCurrentAddressFail() {
        ViewService.hideLoadingIndicator()
        ToastView.sharedInstance.showContent("Đã có lỗi xảy ra")
    }
    
    func didSetIsSearching() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChooseAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == false {
            if placeList.count > 0 {
                return placeList.count
            }
            else {
                return 0
            }
        }
        else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if placeList.count > 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: AddressResultsTableViewCell.getIdentifier(), for: indexPath) as! AddressResultsTableViewCell
           cell.setupData(placeList[indexPath.row])
           
           return cell
        }
        else {
            if isSearching == true {
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchingTableViewCell.getIdentifier(), for: indexPath) as! SearchingTableViewCell
                //            cell.addShimmer()
                cell.frame.size.height = 57
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if placeList.count > 0{
            var placeStr: String = ""
            if isSourceAddressTf == true {
                if let longAddress = placeList[indexPath.row].description {
                    placeStr = longAddress
                }
                sourceAddressTf.text = placeStr
                extraInfo.updateValue(placeStr as AnyObject, forKey: Constants.sourceAddress)
                destinationAddressTf.becomeFirstResponder()
                placeList.removeAll()
            }
            else {
                if let longAddress = placeList[indexPath.row].description {
                    placeStr = longAddress
                }
                destinationAddressTf.text = placeStr
                if let presenter = presenter {
                    extraInfo.updateValue(placeStr as AnyObject, forKey: Constants.destinationAddress)
                    placeList.removeAll()
                    presenter.pushJourney(extraInfo, builder)
                }
            }
            tableView.reloadData()
        }
    }

    
}

// MARK: - UITextFieldDelegate
extension ChooseAddressViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == sourceAddressTf {
            isSourceAddressTf = true
        }
        else {
            isSourceAddressTf = false
        }
        textField.selectAll(nil)
        isSearching = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let presenter = presenter {
            if let text = textField.text, text.count > 0 {
                presenter.lookUpAddressFrom(text)
            }
        }
        isSearching = true
        self.view.endEditing(true)
        return true
    }
}

// MARK: - MyAddressViewDelegate
extension ChooseAddressViewController: MyAddressViewDelegate {
    func myAddressViewDelegateDidTapCurrentLocationWrapperView(from view: MyAddressView) {
        // call geocode
        if let presenter = presenter {
            ViewService.showLoadingIndicator()
            presenter.getCurrentAddress()
        }
    }
}
