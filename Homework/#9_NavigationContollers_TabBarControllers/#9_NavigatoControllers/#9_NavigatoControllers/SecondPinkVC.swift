//
//  SecondPinkVC.swift
//  #9_NavigatoControllers
//
//  Created by Даниил Ярмоленко on 12.10.2022.
//

import UIKit

class SecondPinkVC: UIViewController {

    @IBAction func goToRoot(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "goToSecondRandom" {
            if let vc = segue.destination as? SecondRandomVC {
                vc.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pink view didLoad - second tree")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("pink view will appear - second tree")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("pink view did appear - second tree")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("pink view will disappear - second tree")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("pink view did disappear - second tree")
    }
    
    deinit {
        print("pink view deinit - second tree")
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
