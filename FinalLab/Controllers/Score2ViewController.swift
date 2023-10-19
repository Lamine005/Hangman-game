//
//  Score2ViewController.swift
//  Tp1
//
//  Created by Lamine Djobo on 2023-08-26.
//

import UIKit
import CoreData

class Score2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gameType1 = "Mot"
        let gameType2 = "Titre film"
        
        let topScoresGame1 = fetchScores(forGameType: gameType1)
        let topScoresGame2 = fetchScores(forGameType: gameType2)
        
        
        var topScoresText = "5 meilleurs scores pour le mode \(gameType1):\n"
        
        for (index, score) in topScoresGame1.prefix(5).enumerated() {
            let position = index + 1
            let scoreText = "\(position). \(score.username ?? "") - \(score.score)\n"
            topScoresText += scoreText
        }
        
        topScoresText += "\n5 meilleurs scores pour le mode \(gameType2):\n"
        
        for (index, score) in topScoresGame2.prefix(5).enumerated() {
            let position = index + 1
            let scoreText = "\(position). \(score.username ?? "") - \(score.score)\n"
            topScoresText += scoreText
        }
        showScoreGames.text = topScoresText
    }
        
        func fetchScores(forGameType gameType: String) -> [Score] {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "gameType == %@", gameType)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
            fetchRequest.fetchLimit = 5 
            
            do {
                let scores = try context.fetch(fetchRequest)
                return scores
            } catch {
                print("Error fetching scores: \(error)")
                return []
            }
        }
        
        @IBOutlet weak var showScoreGames: UILabel!
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

