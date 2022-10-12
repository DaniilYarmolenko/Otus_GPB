//
//  FirstRedVC.swift
//  #9_NavigatoControllers
//
//  Created by Даниил Ярмоленко on 12.10.2022.
//

import UIKit

class FirstRandomColorVC: UIViewController {

    let backgroundColor: UIColor = .red
    @IBAction func goToRootVC(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(backgroundColor.accessibilityName) view didLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(backgroundColor.accessibilityName) view will appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(backgroundColor.accessibilityName) view did appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(backgroundColor.accessibilityName) view will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(backgroundColor.accessibilityName) view did disappear")
    }
    
    deinit {
        print("\(backgroundColor.accessibilityName) view deinit")
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
