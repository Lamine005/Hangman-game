
import UIKit



class ViewController: UIViewController {
    
   
  
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var devinetteLabel: UILabel!
    @IBOutlet weak var userInputField: UITextField!
    @IBOutlet weak var userUsedLetters: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hangmanView: UIImageView!
    
    var unFilm: Film?
    var username: String?
    var hint2Alert = false
    var hint4Alert = false
    var hint5Alert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedUsername = UserDefaults.standard.string(forKey: "EnteredName") {
            username = savedUsername
            print("Username from UserDefaults:", username as Any)
        }
        observeUsernameChange()
        set_resetGame()
        
    }
    
    func displayHintAlert(message: String) {
        let hintAlert = UIAlertController(title: "Hint", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        hintAlert.addAction(dismissAction)
        self.present(hintAlert, animated: true, completion: nil)
    }
    
    

    @IBAction func validateBtn(_ sender: Any) {
        if let res = userInputField.text, res.count == 1 {
            JeuPendu.shared.verifier(lettre: Character(res))
            devinetteLabel.text = JeuPendu.shared.devinette
        }
        
        userInputField.text = ""
        userUsedLetters.text = JeuPendu.shared.lettreUtilisees
        pointsLabel.text = "Erreurs: \(JeuPendu.shared.erreurs)"
        hangmanView.image = JeuPendu.shared.image
        
        if let fin = JeuPendu.shared.verifierFindDePartie() {
            print("DB Gagné: ", fin)
            let alert = UIAlertController(title: "Fin", message: "\(fin)", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print("end of game")
            }
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
            set_resetGame()

            
            score.text = JeuPendu.shared.scores
            UserDefaults.standard.set(JeuPendu.shared.scores, forKey: "GameScore")
            self.saveScore(username: username!, gameType: "Titre film", score: Int16(JeuPendu.shared.scoresD))
        } else {
            
            if (JeuPendu.shared.erreursInt == 2 ) && !hint2Alert {
            
                if let releasedString = unFilm?.Released {
                   
                    let yearSubstring = releasedString.suffix(4)
                    
                   
                    if let releasedYear = Int(yearSubstring) {
                        let hintMessage = "Année de sortie: \(releasedYear)"
                        displayHintAlert(message: hintMessage)
                        hint2Alert = true
                    }
                }
            } else if JeuPendu.shared.erreursInt == 4 && !hint4Alert {
                if let rating = unFilm?.bRating, let genre = unFilm?.Genre {
                    let hintMessage = "Rating: \(rating), Genre: \(genre)"
                    displayHintAlert(message: hintMessage)
                    hint4Alert = true
                }
            } else if JeuPendu.shared.erreursInt == 5 && !hint5Alert {
                if let director = unFilm?.Director, let actors = unFilm?.Actors {
                    let hintMessage = "Réalisateurs: \(director), Acteurs: \(actors)"
                    displayHintAlert(message: hintMessage)
                    hint5Alert = true
                }
            }
            

        }
        

    }

    func saveScore(username: String, gameType: String, score: Int16) {
       
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        let newScore = Score(context: context)
        newScore.username = username
        newScore.gameType = gameType
        newScore.score = score

        do {
            try context.save()
            print("Score enregistré avec succès.")
        } catch {
            print("Erreur lors de l'enregistrement du score : \(error)")
        }
    }
    
    func observeUsernameChange() {
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
            if let savedUsername = UserDefaults.standard.string(forKey: "EnteredName") {
                self?.username = savedUsername
                print("Username updated:", savedUsername)
            }
        }
    }
   
    @IBAction func EndGamebutton(_ sender: Any) {
        UserDefaults.standard.set(JeuPendu.shared.scores, forKey: "GameScore")
        JeuPendu.shared.mettreAJourLeScore(nouveauScore: 0)

        score.text = "\(JeuPendu.shared.scores)"
    }
    
    
    func set_resetGame() {
        MovieDownloader.shared.downloadMovie(withID:listeFilms.randomElement()!) { (film) in
            guard let film = film else {
                return
            }
            self.unFilm = film
            JeuPendu.shared.jouer(avec: film)
            self.devinetteLabel.text = JeuPendu.shared.devinette
            self.pointsLabel.text = "pointage: \(JeuPendu.shared.erreurs)"
            self.hangmanView.image = UIImage(contentsOfFile: "")
            self.userUsedLetters.text = ""
            
        }
    }
}
