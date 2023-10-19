

import Foundation
import UIKit

struct EndOfGameInformation1 {
    let win: Bool
    let title: String
    let entErrors: Int
    
    var finalMessage: String {
        if win == true {
            return "Bravo, tu as gagné avec: \(entErrors) / 7.\nLe mot est :\n\(title)"
        } else {
            return "Oh dommage ! tu as perdu  \(entErrors) / 7.\nLe mot est :\n\(title)"
        }
    }
}

class JeuPenduWord {
    
    static let shared: JeuPenduWord = JeuPenduWord()
    
    private init() {}
    
    private let maxErreur: Int = 7
    private var nbErreurs: Int = 0
    private var motADeviner: String = ""
    private var score: Int = 0
    private var lettresUtilisateurs: [Character] = []
    
    var devinette: String {
         var guessedCharacters = [Character](repeating: "#", count: motADeviner.count)
         
         for (idx, lettre) in motADeviner.enumerated() {
             if lettresUtilisateurs.firstIndex(of: lettre) != nil {
                 guessedCharacters[idx] = lettre
             }
         }
         
         return String(guessedCharacters)
     }
    
    var lettreUtilisees: String {
            return Array(lettresUtilisateurs).map{String($0)}.joined(separator: ", ")
        }
    
    var erreurs: String {
        return "\(nbErreurs) / \(maxErreur)"
    }
    
    var erreursInt: Int {
        return nbErreurs
    }
    
    var scores: String {
        return "\(score)"
    }
    
    var scoresD: Int {
        return score
    }
    
    var image: UIImage {
        return UIImage(named: imageNameSequence[nbErreurs])!
    }
    
    func jouer(avec mot: String) {
        motADeviner = mot.lowercased()
        nbErreurs = 0
        lettresUtilisateurs.removeAll()
        
    }
    
    func verifier(lettre: Character) {
        lettresUtilisateurs.append(lettre)
        
        if !motADeviner.contains(lettre) {
            nbErreurs += 1
        }
    }
    
    func verifierFinDePartie() -> String? {
        if nbErreurs == maxErreur {
            return EndOfGameInformation1(win: false, title: motADeviner, entErrors: nbErreurs).finalMessage
        } else if motADeviner.allSatisfy({ lettresUtilisateurs.contains($0) }) {
            score += 1
            return EndOfGameInformation1(win: true, title: motADeviner, entErrors: nbErreurs).finalMessage
        }
        return nil
    }
    
    func mettreAJourLeScore(nouveauScore: Int) {
            score = nouveauScore
        }
}
