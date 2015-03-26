// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var increments: [String : Int] = ["i": 0]

func i(var key: String,
    col_ID id1: String? = __COLUMN__,
    lineID id2: String? = __LINE__,
    funcID id3: String? = __FUNCTION__,
    fileID id4: String? = __FILE__
    ) -> Int {
       // for i in ID {
            key += "\(id1)\(id2)\(id3)\(id4)"
       // }
        if let i = increments[key] {
            increments[key] = i + 1
            return i
        } else {
            increments[key] = 0
            return Int(0)
        }
}

println(i("i"))


func dpa(){
    i("s")
}

dpa()