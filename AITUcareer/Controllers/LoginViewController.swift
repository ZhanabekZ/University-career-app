//
//  LoginViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 23.04.2023.
//
import UIKit
import Firebase

let defaults = UserDefaults.standard

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { AuthDataResult, error in
            if error != nil {
                let ac = UIAlertController(title: "Something went wrong.", message: error!.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            } else {
                defaults.setValue(true, forKey: "isUserSignedIn")
                
                let tabBarViewController = TabBarViewController()
                
                // Set the TabBarViewController as the root view controller
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    window.rootViewController = tabBarViewController
                    window.makeKeyAndVisible()
                }
            }
        }
    }
    
    
    @IBAction func createNewAccountClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "createAccount") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgotPassword") else { return }
        self.present(vc, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
