

import Foundation
 import UIKit


struct EndOfGameInformation {
    let win: Bool
    let title: String
    let entErrors: Int
    
    var finalMessage: String {
        if win == true {
            return "Bravo, tu as gagné avec: \(entErrors) / 7.\nLe titre est :\n\(title)"
        } else {
            return "Oh dommage ! tu as perdu  \(entErrors) / 7.\nLe titre est :\n\(title)"
        }
    }
}

class JeuPendu {
    
    static let shared: JeuPendu = JeuPendu()
    
    private init() {}
    
    //
    private let maxErreur: Int = 7
    private var nbErreurs: Int = 0
    private var titreADeviner: [Character] = []
    private var score: Int = 0
    private var indexTrouves: [Bool] = []
    private var lettresUtilisateurs: [Character] = []
    private var filmADevniner: Film?
    
    
    var devinette: String {
        let arr = indexTrouves.indices.map {indexTrouves[$0] ? titreADeviner[$0] : "#"}
        return String(arr)
        
    }
    var lettreUtilisees: String {
        return Array(lettresUtilisateurs).map{String($0)}.joined(separator: " ,")
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
    
    func jouer(avec film:Film) {
        filmADevniner = film
        titreADeviner = Array(film.Title)
        indexTrouves = Array(repeating: false, count: titreADeviner.count)
        titreADeviner.enumerated().forEach {(idx, lettre) in
            if
                !("abcdefghijklmopqrstuvxyz".contains(lettre.lowercased())) {
                indexTrouves[idx] = true
            }
        }
        print("DB: jouer() ", devinette)
        
        nbErreurs = 0
    }
    
    func verifier(lettre:Character){
        lettresUtilisateurs.append(lettre)
        var trouvee = false
        
        titreADeviner.enumerated().forEach { (idx,lettreMystere) in
            if lettreMystere.lowercased() == lettre.lowercased() {indexTrouves[idx] = true
                trouvee = true
            }
        }
        if !trouvee {
            nbErreurs += 1
        }
    }
    
    func verifierFindDePartie() -> String? {
        if nbErreurs == maxErreur {
            return EndOfGameInformation(win: false, title:String(titreADeviner), entErrors: nbErreurs).finalMessage
        } else if indexTrouves.allSatisfy({$0}) {
            score += 1
            return EndOfGameInformation(win: true, title:String(titreADeviner),entErrors: nbErreurs).finalMessage
        }
        return nil
    }
    
    func mettreAJourLeScore(nouveauScore: Int) {
            score = nouveauScore
        }
}
