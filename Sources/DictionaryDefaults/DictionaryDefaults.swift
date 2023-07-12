import SwiftUI

@propertyWrapper
public struct DictionaryDefaults: DynamicProperty {
    private let key: String
    private let userDefaults: UserDefaults

    @State private var dictionary: [String: Any] {
        didSet {
            userDefaults.set(dictionary, forKey: key)
        }
    }

    public var wrappedValue: [String: Any] {
        get {
            dictionary
        }

        nonmutating set {
            dictionary = newValue
        }
    }

    public var projectedValue: Binding<[String: Any]> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }

    public init(wrappedValue defaultValue: [String: Any], key: String, suiteName: String? = nil) {
        self.key = key

        userDefaults = UserDefaults(suiteName: suiteName)!

        let dict = userDefaults.dictionary(forKey: key)
        if let dict {
            dictionary = dict
        } else {
            userDefaults.set(defaultValue, forKey: key)
            dictionary = defaultValue
        }
    }
}
