import Foundation

func twoStrings(n: Int, arr: [String]) {
    for position in 0...n - 1 {
        print(compareStrings(str1: arr[position*2], str2: arr[position*2 + 1]))
    }
}

func compareStrings(str1: String, str2: String) -> String {
    let set = Set(str2)
    for char in str1 {
        if (set.contains(char)){
            return "YES"
        }
    }
    return "NO"
}

twoStrings(n: 2, arr: ["hello", "world", "hi", "world",])

print("============")

twoStrings(n: 4, arr: ["wouldyoulikefries", "abcabcabcabcabcabc", "hackerrankcommunity",
                       "cdecdecdecde", "jackandjill", "wentupthehill", "writetoyourparents", "fghmqzldbc"])

print("============")

twoStrings(n: 2, arr: ["aardvark", "apple", "beetroot","sandals"])

print("============")
