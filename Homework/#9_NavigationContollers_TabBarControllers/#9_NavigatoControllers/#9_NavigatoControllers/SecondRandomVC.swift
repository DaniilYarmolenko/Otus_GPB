//
//  SecondBlueVC.swift
//  #9_NavigatoControllers
//
//  Created by Даниил Ярмоленко on 12.10.2022.
//

import UIKit

class SecondRandomVC: UIViewController {

    @IBAction func goToRootView(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToBackVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    var backgroundColor: UIColor = .blue
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        print("\(backgroundColor.accessibilityName) view didLoad - second tree")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(backgroundColor.accessibilityName) view will appear - second tree")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(backgroundColor.accessibilityName) view did appear - second tree")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(backgroundColor.accessibilityName) view will disappear - second tree")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(backgroundColor.accessibilityName) view did disappear - second tree")
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
