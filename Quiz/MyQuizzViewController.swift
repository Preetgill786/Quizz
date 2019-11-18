//
//  ViewController.swift
//  Quiz
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class MyQuizzViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var queCountLbl: UILabel!
    var quizNum = 0
    var selectedQuizList  = [QuizItem]()
    var quizList  = [QuizItem]()
    
    @IBOutlet weak var tableQuizOptions: UITableView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var quizLabel: UILabel!
    
    @IBAction func nextPress(_ sender: Any) {
        
        var isAllFalse = false
        
        for i in 0 ..< selectedQuizList[quizNum].quizOptArrCLICK.count{
            
            if(selectedQuizList[quizNum].quizOptArrCLICK[i] == true){
                isAllFalse = true
            }
            
        }
        
        
        if(!(isAllFalse)){
            let alert = UIAlertController(title: "Alert", message: "Please Give your Answer", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        
        
        
        if(self.quizNum < 5)
        {
            
            self.quizNum += 1
            
            let num = self.quizNum + 1
            self.queCountLbl.text = "\(num)/5"
            
            self.tableQuizOptions.reloadData()
            self.quizLabel.text = self.selectedQuizList[self.quizNum].quiz
            
        }
        
        
        if(self.quizNum == 4)
        {
            
            self.nextButton.setTitle("FINISH", for: UIControl.State.normal)
            return
        }
        
        if( self.quizNum == 5 )
        {
            var resCOUNT = 0
            for i in 0 ..< 5 {
                if(self.selectedQuizList[i].quizANS == self.selectedQuizList[i].myANS){
                    resCOUNT += 1
                }
            }
            
            
            
            
            print("score = \(resCOUNT)")
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
                
                vc.result = resCOUNT
                
                if let navi = self.navigationController {
                    
                    navi.pushViewController(vc, animated: true)
                    
                }
            }
            
        }
        
        
        
    }
    
    
    
    
    
    required init?(coder aDecoder : NSCoder){
        
        
        
        
        
        
        super.init(coder : aDecoder)
        
        print("Documents folder is \(documentsDirectory())")
        print("Data file path is \(dataFilePath())")
        
        
        loadChecklistItems()
        
        var idxArr = [Int]()
        
        for _ in 0 ..< 6 {
            
            repeat{
                let randomIndex = Int.random(in: 0 ..< quizList.count)
                
                if !idxArr.contains(randomIndex)
                {
                    idxArr.append(randomIndex)
                    selectedQuizList.append(quizList[randomIndex])
                    break
                }
                
            }while(true)
            
        }
        
        
    }
    
    func loadChecklistItems() {
        // 1
        let path = dataFilePath()
        // 2
        if let data = try? Data(contentsOf: path) {
            // 3
            let decoder = PropertyListDecoder()
            do {
                // 4
                quizList = try decoder.decode([QuizItem].self,from: data)
            }
            catch
            {
                print("Error decoding item array!")
            }
        } }
    
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("allData.plist")
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
    func saveChecklistItems() {
        // 1
        let encoder = PropertyListEncoder()
        // 2
        do {
            // 3
            let data = try encoder.encode(quizList)
            // 4
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)}
        catch {
            print("Error encoding item array!")
            // 5
        } }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedQuizList[quizNum].quizOptArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        quizLabel.text = selectedQuizList[quizNum].quiz
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "QuizItem") as! OptionItemView
        cell.textLabel!.text = selectedQuizList[quizNum].quizOptArr[indexPath.row]
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedQuizList[quizNum].quizOptArrCLICK[indexPath.row] = true
        selectedQuizList[quizNum].myANS = indexPath.row
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedQuizList[quizNum].quizOptArrCLICK[indexPath.row] = false
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        tableQuizOptions.delegate = self
        tableQuizOptions.dataSource = self
    }
    
    
    
    
}


class OptionItemView: UITableViewCell{
    
    @IBOutlet weak var optionName: UILabel!
    
    
}
