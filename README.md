# DictionaryDefaults

This is an `AppStorage` like property wrapper for saving/restoring the `Dictionary` type value.

# Usage

```swift
import DictionaryDefaults

struct ContentView: View {
    @DictionaryDefaults(key: "my_dict")
    private var myDictionary = [String: Any]()

    var body: some View {
        List(keys, id: \.self) { key in
            Text(myDictionary[key] as! String)
        }

        Button(
            action: {
                // As soon as the dictionary is changed, the change is saved in UserDefaults
                myDictionary.updateValue("FirstView", forKey: UUID().uuidString)
            },
            label: {
                Text("Add")
            }
        )

        // Binding is OK
        OtherView(dict: $myDictionary)
    }
}
```