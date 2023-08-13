//
//  CreateAccountViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 23.04.2023.
//

import UIKit
import Firebase
class CreateAccountViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountClicked(_ sender: UIButton) {
        guard let name = name.text else { return }
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] AuthDataResult, error in
            if error != nil {
                let ac = UIAlertController(title: "Something went wrong.", message: error!.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            } else if self?.isValidEmail(email) == false {
                let ac = UIAlertController(title: "Something went wrong.", message: "Please enter a valid Astana IT University email.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            } else if let user = AuthDataResult?.user {
                // Save the user's name
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { [weak self] error in
                    if error != nil {
                        let ac = UIAlertController(title: "Something went wrong.", message: error?.localizedDescription, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    } else {
                        Auth.auth().currentUser?.sendEmailVerification { error in
                            if error != nil {
                                let ac = UIAlertController(title: "Something went wrong.", message:         error?.localizedDescription, preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                self?.present(ac, animated: true)
                            } else {
                                let ac = UIAlertController(title: "Check your email.", message: "We have sent you verification letter.", preferredStyle: .alert)
                                let loginCall = UIAlertAction(title: "Let's sign in", style: .default) { _ in
                                    self?.goToLogin()
                                }
                                ac.addAction(loginCall)
                                self?.present(ac, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
        
    func goToLogin() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginView") else { return }
        self.present(vc, animated: true)
    }
    
    @IBAction func signinClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginView") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@astanait\\.edu\\.kz$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
