//
//  FirstRedVC.swift
//  #9_NavigatoControllers
//
//  Created by Даниил Ярмоленко on 12.10.2022.
//

import UIKit

class FirstRandomColorVC: UIViewController {

    var backgroundColor: UIColor = .red
    @IBAction func goToRootVC(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        print("\(backgroundColor.accessibilityName) view didLoad - first tree")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(backgroundColor.accessibilityName) view will appear - first tree")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(backgroundColor.accessibilityName) view did appear - first tree")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(backgroundColor.accessibilityName) view will disappear - first tree")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(backgroundColor.accessibilityName) view did disappear - first tree")
    }
    
    deinit {
        print("\(backgroundColor.accessibilityName) view deinit - second tree")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
