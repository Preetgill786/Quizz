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
        
        //this commented section is to reload the plist file when open in new system
//        let qItem1 = QuizItem()
//                       qItem1.quiz = QuizQuestion.quiz1
//                       qItem1.quizANS = QuizQuestion.ans1Num
//                       var arr1 = [String]()
//                         arr1 = QuizQuestion.optionsQ1
//                       qItem1.quizOptArr = arr1
//                       quizList.append(qItem1)
//
//                       let qItem2 = QuizItem()
//                       qItem2.quiz = QuizQuestion.quiz2
//                       qItem2.quizANS = QuizQuestion.ans2Num
//                       qItem2.quizOptArr = QuizQuestion.optionsQ2
//                       quizList.append(qItem2)
//
//                       let qItem3 = QuizItem()
//                       qItem3.quiz = QuizQuestion.quiz3
//                       qItem3.quizANS = QuizQuestion.ans3Num
//                       qItem3.quizOptArr = QuizQuestion.optionsQ3
//                       quizList.append(qItem3)
//
//
//                       let qItem4 = QuizItem()
//                       qItem4.quiz = QuizQuestion.quiz4
//                       qItem4.quizANS = QuizQuestion.ans4Num
//                       qItem4.quizOptArr = QuizQuestion.optionsQ4
//                       quizList.append(qItem4)
//
//
//                       let qItem5 = QuizItem()
//                       qItem5.quiz = QuizQuestion.quiz5
//                       qItem5.quizANS = QuizQuestion.ans5Num
//                       qItem5.quizOptArr = QuizQuestion.optionsQ5
//                       quizList.append(qItem5)
//
//                       let qItem6 = QuizItem()
//                       qItem6.quiz = QuizQuestion.quiz6
//                       qItem6.quizANS = QuizQuestion.ans6Num
//                       qItem6.quizOptArr = QuizQuestion.optionsQ6
//                       quizList.append(qItem6)
//
//                       let qItem7 = QuizItem()
//                       qItem7.quiz = QuizQuestion.quiz7
//                       qItem7.quizANS = QuizQuestion.ans7Num
//                       qItem7.quizOptArr = QuizQuestion.optionsQ7
//                       quizList.append(qItem7)
//
//                       let qItem8 = QuizItem()
//                       qItem8.quiz = QuizQuestion.quiz8
//                       qItem8.quizANS = QuizQuestion.ans8Num
//                       qItem8.quizOptArr = QuizQuestion.optionsQ8
//                       quizList.append(qItem8)
//
//                       let qItem9 = QuizItem()
//                       qItem9.quiz = QuizQuestion.quiz9
//                       qItem9.quizANS = QuizQuestion.ans9Num
//                       qItem9.quizOptArr = QuizQuestion.optionsQ9
//                       quizList.append(qItem9)
//
//                       let qItem10 = QuizItem()
//                       qItem10.quiz = QuizQuestion.quiz10
//                       qItem10.quizANS = QuizQuestion.ans10Num
//                       qItem10.quizOptArr = QuizQuestion.optionsQ10
//                       quizList.append(qItem10)
//
//
        
        
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
        
        saveChecklistItems()
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
//        tableQuizOptions.delegate = self
//        tableQuizOptions.dataSource = self
    }
    
    
    
    
}


class OptionItemView: UITableViewCell{
    
    @IBOutlet weak var optionName: UILabel!
    
    
}
