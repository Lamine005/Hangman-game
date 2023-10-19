

import UIKit

class ScoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storedScore = UserDefaults.standard.integer(forKey: "GameScore")
        let storedScore2 = UserDefaults.standard.integer(forKey: "GameScore2")
        let nameSaved = UserDefaults.standard.string(forKey: "EnteredName")
            
        showscore.text = "\(String(describing: nameSaved!)) ton score pour le mode Film est \(storedScore) "
        
        showScoreGameWord.text = " \(String(describing: nameSaved!)) ton score pour le monde Dictionnaire est \(storedScore2) "
    } 
    
    @IBOutlet weak var showscore: UILabel!
    
    @IBOutlet weak var showScoreGameWord: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
