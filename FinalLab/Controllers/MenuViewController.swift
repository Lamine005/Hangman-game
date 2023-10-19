
import UIKit

class MenuViewController: UIViewController {
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func displayConfirmAlert(message: String) {
        let hintConfirm = UIAlertController(title: "Hint", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        hintConfirm.addAction(dismissAction)
        self.present(hintConfirm, animated: true, completion: nil)
    }
    
    let nameKey = "EnteredName"
    
    @IBOutlet weak var nameTextFiel: UITextField!
    
     
    @IBAction func submitbtn(_ sender: UIButton) {
        
        if let enteredName = nameTextFiel.text {
            
            UserDefaults.standard.set(enteredName, forKey: nameKey)
            let hintMessage1 = "Your Name has been added: \(enteredName)"
            displayConfirmAlert(message: hintMessage1)
        }
        
        nameTextFiel.text = ""
        print("Wooow")
        
    }
    @IBAction func MenuUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
         
        
        
    }



