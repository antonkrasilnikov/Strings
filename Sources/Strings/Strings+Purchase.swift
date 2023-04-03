import Foundation

public extension String {

    private static var _priceFormatter: NumberFormatter?

    private static func priceFormatter(currency: String) -> NumberFormatter {
        if _priceFormatter == nil || _priceFormatter?.currencyCode != currency {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = currency
            formatter.negativePrefix = "\(formatter.negativePrefix!) "
            formatter.positivePrefix = "\(formatter.positivePrefix!) "
            _priceFormatter = formatter
        }

        return _priceFormatter!
    }

    static func currencyName(_ currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: 111))?.replacingOccurrences(of: "111", with: "") ?? currency

    }
    static func price(value: Float, currency: String) -> String {
        return priceFormatter(currency: currency).string(from: NSNumber(value: value)) ?? .init(number: Double(value)) + " " + currencyName(currency)
    }
}
