//
//  ViewController.swift
//  SimpleTblViewChat
//
//  Created by Mohit Singh on 19/02/21.
//

import UIKit
import LoremIpsum

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblViewChat: UITableView!
    @IBOutlet weak var txfMsgInput: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    // MARK: - Properties
    var sampleData = ["Hope"]

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action Methods
    @IBAction func btnActionSend(_ sender: UIButton) {
        let randomMsg = [1, 2, 1, 1, 2].randomElement()
        switch randomMsg {
        case 1:
            let numOfWords: UInt = UInt([1, 2, 3].randomElement()!)
            let words: String = LoremIpsum.words(withNumber: numOfWords)
            sampleData.append(words)
        case 2:
            let numOfSen: UInt = UInt([2, 3, 4].randomElement()!)
            let sentences = LoremIpsum.sentences(withNumber: numOfSen)
            sampleData.append(sentences)
        case .none:
            break
        case .some(_):
            break
        }
        tblViewChat.insertRows(at: [IndexPath(row: self.sampleData.count - 1, section: 0)], with: .fade)
        tblViewChat.scrollToRow(at: IndexPath(row: self.sampleData.count - 1, section: 0), at: .bottom, animated: true)
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
        cell.lblTxt.text = sampleData[indexPath.row]
        return cell
    }
}

