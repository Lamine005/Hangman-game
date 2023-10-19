//
//  WordGameViewController.swift
//  Tp1
//
//  Created by Lamine Djobo on 2023-08-26.
//

import UIKit

class WordGameViewController: UIViewController {

   

        @IBOutlet weak var score: UILabel!
        @IBOutlet weak var devinetteLabel: UILabel!
        @IBOutlet weak var userInputField: UITextField!
        @IBOutlet weak var userUsedLetters: UITextField!
        @IBOutlet weak var pointsLabel: UILabel!
        @IBOutlet weak var hangmanView: UIImageView!

        var jeuPenduWord = JeuPenduWord.shared
        var username: String?
    
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
                jeuPenduWord.verifier(lettre: Character(res))
                devinetteLabel.text = jeuPenduWord.devinette
            }

            userInputField.text = ""
            userUsedLetters.text = jeuPenduWord.lettreUtilisees
            pointsLabel.text = "Erreurs: \(jeuPenduWord.erreurs)"
            hangmanView.image = jeuPenduWord.image

            if let fin = jeuPenduWord.verifierFinDePartie() {
                print("DB Gagné: ", fin)
                let alert = UIAlertController(title: "Fin", message: "\(fin)", preferredStyle: .alert)

                let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    print("end of game")
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                set_resetGame()
                score.text = jeuPenduWord.scores
                UserDefaults.standard.set(jeuPenduWord.scores, forKey: "GameScore2")
                
                if let currentUsername = username {
                        self.saveScore(username: currentUsername, gameType: "Mot", score: Int16(jeuPenduWord.scoresD))
                    }
                
            } else {
                
                
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

        @IBAction func EndGamebutton(_ sender: Any) {
            UserDefaults.standard.set(jeuPenduWord.scores, forKey: "GameScore2")
            jeuPenduWord.mettreAJourLeScore(nouveauScore: 0)

            score.text = "\(jeuPenduWord.scores)"
            
        }
    
        func observeUsernameChange() {
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
                if let savedUsername = UserDefaults.standard.string(forKey: "EnteredName") {
                    self?.username = savedUsername
                    print("Username updated:", savedUsername)
                }
            }
        }


        func set_resetGame() {
            let apiUrl = "https://random-word-api.herokuapp.com/word"
            guard let url = URL(string: apiUrl) else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let words = try JSONDecoder().decode([String].self, from: data)
                        if let randomWord = words.randomElement() {
                            print("Word to guess:", randomWord)
                            DispatchQueue.main.async {
                                self.jeuPenduWord.jouer(avec: randomWord)
                                self.userUsedLetters.text = ""
                                self.devinetteLabel.text = self.jeuPenduWord.devinette
                                self.pointsLabel.text = "Erreurs: \(self.jeuPenduWord.erreurs)"
                                self.hangmanView.image = UIImage(contentsOfFile: "")
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


