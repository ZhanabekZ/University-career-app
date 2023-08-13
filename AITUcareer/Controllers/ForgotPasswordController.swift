//
//  ForgotPasswordController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 23.04.2023.
//

import UIKit
import Firebase

class ForgotPasswordController: UIViewController {

    @IBOutlet var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkEmailClicked(_ sender: UIButton) {
        guard let email = email.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                let ac = UIAlertController(title: "Something went wrong.", message: error!.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Check your email", message: "We've sent you a letter", preferredStyle: .alert)
                let loginCall = UIAlertAction(title: "Let's go", style: .default) { [weak self] _ in
                    self?.goTologin()
                }
                ac.addAction(loginCall)
                self.present(ac, animated: true)
            }
        }
        
    }
    
    func goTologin() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginView") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
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
