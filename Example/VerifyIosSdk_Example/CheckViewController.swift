//
//  CheckViewController.swift
//  verify-ios-test-app
//
//  Created by Dorian Peake on 24/06/2015.
//  Copyright (c) 2015 Nexmo Inc. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController, PageIndexable {

    @IBOutlet weak var pinField: UITextField!
    @IBOutlet weak var statusImage: UIImageView!
    
    var index: Int = 1
    
    fileprivate weak var parentPageController : VerifyPageViewController!
    
    // MARK:
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(parent: VerifyPageViewController) {
        self.init(nibName: "CheckViewController", bundle: nil)
        
        parentPageController = parent
    }
    
    // MARK:
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusImage.alpha = 0
    }
    
    // MARK:
    // MARK: Touch
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (pinField.isFirstResponder && (event?.allTouches?.first)?.view != pinField) {
            pinField.resignFirstResponder()
        }
    }
    
    // MARK:
    // MARK: Action
    
    @IBAction func checkPinCode(_ sender: UIButton) {
        if (pinField.text?.characters.count != 4) {
            wrongPinAlert()
            
            return
        }
        
        if (pinField.isFirstResponder) {
            pinField.resignFirstResponder()
        }
        
        parentPageController.checkPinCode()
    }
    
    // MARK:
    // MARK: Private - Alert
    
    private func wrongPinAlert() {
        let alert = UIAlertController(title: "Pin code wrong length", message: "Your pin code should be 4 digits long.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oh, fiddlesticks!", style: .default, handler: { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
