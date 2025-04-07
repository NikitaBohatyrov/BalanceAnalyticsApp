import SwiftUI

public struct AccountData: Equatable, Identifiable, Sendable {
    public var id: String
    public var name: String
    public var description: String
    public var date: Date
    public var amount: Int
    public var balance: Int = 0

    public init(components: [String]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.id = components[0]
        self.date = dateFormatter.date(from: components[1]) ?? .now
        self.name = components[2]
        self.description = components[3]
        self.amount = Int(components[4]) ?? 0
    }

    public func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }

    public func getFormattedAmount() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    public func getFormattedBalance() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value: balance)) ?? ""
    }
}
