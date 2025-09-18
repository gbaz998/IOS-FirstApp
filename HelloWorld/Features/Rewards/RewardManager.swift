import Foundation
final class RewardManager {
    static let shared = RewardManager()
    private let pointsKey = "reward.points"
    private init() {}
    var points: Int {
        get { UserDefaults.standard.integer(forKey: pointsKey) }
        set { UserDefaults.standard.set(newValue, forKey: pointsKey) }
    }
    @discardableResult
    func award(points: Int, reason: String? = nil) -> Int {
        self.points += points
        NotificationCenter.default.post(name: .didEarnReward, object: nil, userInfo: ["points": self.points, "reason": reason ?? ""])
        return self.points
    }
}
extension Notification.Name {
    static let didEarnReward = Notification.Name("reward.didEarn")
}
