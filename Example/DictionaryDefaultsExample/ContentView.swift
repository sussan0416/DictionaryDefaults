//
//  ContentView.swift
//  DictionaryDefaultsExample
//
//  Created by 鈴木孝宏 on 2023/07/12.
//

import DictionaryDefaults
import SwiftUI

struct FirstView: View {
    // 今回実装したDictionaryDefaults
    @DictionaryDefaults(key: "my_dict")
    private var myDictionary = [String: Any]()

    // 表示用にDictionaryをArrayに変換しておく...
    private var keys: [String] {
        get {
            myDictionary.keys.map { $0 }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(keys, id: \.self) { key in
                    Text(myDictionary[key] as! String)
                }
            }
            .toolbar {
                // 全削除ボタン
                Button {
                    myDictionary.removeAll()
                } label: {
                    Text("Clear")
                }
                // 追加ボタン
                Button {
                    myDictionary.updateValue(
                        "FirstView",
                        forKey: UUID().uuidString
                    )
                } label: {
                    Text("Add")
                }
                // 次の画面を開くボタン
                NavigationLink("Show SecondView") {
                    // 次の画面に、myDictionaryのBindingを渡す
                    SecondView(dict: $myDictionary)
                }
            }
        }
    }
}

struct SecondView: View {
    // DictionaryをBindする
    @Binding var dict: [String: Any]

    var body: some View {
        // 追加ボタン
        Button {
            dict.updateValue(
                "SecondView",
                forKey: UUID().uuidString
            )
        } label: {
            Text("Add")
        }
        // 全削除ボタン
        Button {
            dict.removeAll()
        } label: {
            Text("Clear")
        }
    }
}
