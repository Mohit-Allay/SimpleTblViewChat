//
//  ViewController.swift
//  SimpleTblViewChat
//
//  Created by Mohit Singh on 19/02/21.
//

import UIKit
import LoremIpsum

//MARK: - RAJA's Method
class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblViewChat: UITableView!
    @IBOutlet weak var txfMsgInput: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txfMsgInputBCons: NSLayoutConstraint!
    
    // MARK: - Properties
    var sampleData = ["0 Hope"]
    var keyboardDismiss = true
    
    private(set) var keyboardIsOpen: Bool = false
    private(set) var keyboardFrame: CGRect = .zero
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        tblViewChat.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            txfMsgInputBCons.constant = isKeyboardShowing ? keyboardFrame.height : 20
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardDidHideNotification
            txfMsgInputBCons.constant = isKeyboardShowing ? keyboardFrame.height : 20
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
            }
        }
    }

    
    
    // MARK: - Action Methods
    @IBAction func btnActionSend(_ sender: UIButton) {
        let randomMsg = [1, 2, 1, 1, 2].randomElement()
        switch randomMsg {
        case 1:
            let numOfWords: UInt = UInt([1, 2, 3].randomElement()!)
            let words: String = LoremIpsum.words(withNumber: numOfWords)
            sampleData.insert("\(self.sampleData.count) " + words, at: 0)
        
        case 2:
            let numOfSen: UInt = UInt([2, 3, 4].randomElement()!)
            let sentences = LoremIpsum.sentences(withNumber: numOfSen)
            sampleData.insert("\(self.sampleData.count) " + sentences, at: 0)
        
        case .none:
            break
        
        case .some(_):
            break
        }
        tblViewChat.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
    }
}

// MARK: - Extensions
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTxtTblCell", for: indexPath) as! ChatTxtTblCell
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.lblTxt.text = sampleData[indexPath.row]
        return cell
    }
}

//
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if txfMsgInput.isFirstResponder && translation.y > 20 {
            txfMsgInput.resignFirstResponder()
        }
    }
}
