//
//  ViewController.swift
//  HandleJSONDecode
//
//  Created by Igor on 02.10.2021.
//

//

import UIKit

class ViewController: UIViewController {
    private let randomUserAPI = "https://randomuser.me/api"

    @IBAction func buttonPressed() {
        NetworkManager.shared.fetchData(from: randomUserAPI) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    dump(data)
                    self.showAlertController(type: .sucsess)
                case .failure:
                    self.showAlertController(type: .fail)
                }
            }
        }
    }

    private func showAlertController(type: AlertType) {
        let alert = UIAlertController(title: nil, message: "Check debug console", preferredStyle: .alert)

        switch type {
        case .sucsess:
            alert.title = "Sucsess"
        case .fail:
            alert.title = "Failed"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    enum AlertType {
        case sucsess
        case fail
    }
}
