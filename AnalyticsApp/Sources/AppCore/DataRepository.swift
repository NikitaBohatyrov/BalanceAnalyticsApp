import Foundation

struct DataRepository: Equatable {
    var data: [AccountData] = []
    init() {
        data = fetchData()
    }

    func sliceFetchedData(state: AppCore.State) -> [AccountData] {
        if let selectedDate = state.selectedDate, let index = state.selectedData.firstIndex(of: selectedDate) {
            return Array(state.selectedData[0...index])
        }
        return data
    }

    func getDataSlice(state: AppCore.State) -> [AccountData] {
        switch state.dayRange {
        case .week: return data.suffix(7)
        case .month: return data.suffix(31)
        case .year: return filterResults(data)
        }
    }

    private func fetchData() -> [AccountData] {
        if let filepath = Bundle.main.path(forResource: "data.csv", ofType: nil) {
            do {
                let fileContent = try String(contentsOfFile: filepath)
                let lines = fileContent.components(separatedBy: "\n")
                var result: [AccountData] = lines.dropFirst().compactMap({ line in
                    guard !line.isEmpty else { return nil }
                    let components = line.replacingOccurrences(of: "\r", with: "").components(separatedBy: ",")
                    return AccountData(components: components)
                })
                for index in 0 ..< result.count {
                    if index == 0 {
                        let initialBalance = 7000
                        result[index].balance = initialBalance + result[index].amount
                    } else {
                        let previousValue = result[index - 1].balance
                        result[index].balance = previousValue + result[index].amount
                    }
                }
                return result
            } catch {
                print("error: \(error)")
            }
        } else {
            print("data file could not be found")
        }
        return []
    }
    
    private func filterResults(_ data: [AccountData]) -> [AccountData] {
        return Array(data.enumerated().compactMap { index, element in
            index % 3 == 0 ? element : nil
        })

    }
}
