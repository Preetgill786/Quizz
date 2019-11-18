//
//  quizItem.swift
//  Quiz
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import Foundation

class QuizItem: NSCoder,Codable{
    var quiz = ""
    var quizANS = 0
    var quizOptArr = [String]()
        var quizOptArrCLICK = [false,false,false,false]
    var myANS = 20
}
