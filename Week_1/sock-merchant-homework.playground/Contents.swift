func pairsOfSocks(n: Int, numbersSeparatedBySpace: String) -> Int {
    var arrOfKeys: [Int] = []
    var dict: [Int: Int] = [:]
    let arrOfNums = numbersSeparatedBySpace.split(separator: " ")
    var pairs = 0
    
    for num in arrOfNums{
        let numInt = Int(num)!
        if(dict[numInt] == nil){
            dict[numInt] = 1
            arrOfKeys.append(numInt)
        } else {
            dict[numInt]! += 1
        }
    }
    
    for key in arrOfKeys {
        pairs += dict[key]!/2
    }
    return pairs
}

print(pairsOfSocks(n: 10, numbersSeparatedBySpace: "2 3 4 5 1 2 3 5"))
