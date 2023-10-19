//
//  PreferencesViewController.swift
//  Tp1
//
//  Created by Lamine Djobo on 2023-09-11.
//

import UIKit

class PreferencesViewController: UIViewController, UIPickerViewDataSource , UIPickerViewDelegate {
   
    let languageKey = "selectedLanguage"
    let themeKey = "selectedTheme"

    
    let langues = ["Français", "Anglais", "Portugais", "Arménien", "Japonais"]
    
    let theme = ["Jaune", "Vert", "Orange", "Violet", "Rouge", "Bleu", "Marron"
    ]
    @IBOutlet weak var LanguesPreferences: UIPickerView!
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ThemePreferences: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LanguesPreferences.dataSource = self
        LanguesPreferences.delegate = self
        
        ThemePreferences.dataSource = self
        ThemePreferences.delegate = self
     
        if let selectedLanguage = UserDefaults.standard.string(forKey: languageKey) {
                // Afficher la langue sélectionnée dans le label
                languageLabel.text = "Langue sélectionnée : \(selectedLanguage)"
                
                if let index = langues.firstIndex(of: selectedLanguage) {
                    LanguesPreferences.selectRow(index, inComponent: 0, animated: false)
                }
            }
            
            // Charger le thème sélectionné depuis UserDefaults ou utiliser une valeur par défaut
            if let selectedTheme = UserDefaults.standard.string(forKey: themeKey) {
                // Afficher le thème sélectionné dans le label
                themeLabel.text = "Thème sélectionné : \(selectedTheme)"
                
                if let index = theme.firstIndex(of: selectedTheme) {
                    ThemePreferences.selectRow(index, inComponent: 0, animated: false)
                }
            }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == LanguesPreferences {
            return langues.count
        } else if pickerView == ThemePreferences {
            return theme.count
        } else {
            return 0 // Retourne 0 pour d'autres pickerView
        }
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == LanguesPreferences {
            return langues[row]
        } else if pickerView == ThemePreferences {
            return theme[row]
        } else {
            return nil // Retourne nil pour d'autres pickerView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == LanguesPreferences {
            let selectedLanguage = langues[row]
            UserDefaults.standard.set(selectedLanguage, forKey: languageKey)
        } else if pickerView == ThemePreferences {
            let selectedTheme = theme[row]
            UserDefaults.standard.set(selectedTheme, forKey: themeKey)
        }
        UserDefaults.standard.synchronize() 
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
