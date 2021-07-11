import UIKit
import Combine

var myIntArrayPublisher: Publishers.Sequence<[Int], Never> = [1,2,3].publisher
myIntArrayPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print("실패 : error : \(error)")
    }
}, receiveValue: { receivedValue in
    print("값을 받았다. : \(receivedValue)")
})


var mySubscription: AnyCancellable?
var mySubscriptionSet = Set<AnyCancellable>()
var myNotifiaction = Notification.Name("com.girin.customNotification")
var myDefaultPublisher: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: myNotifiaction)
mySubscription = myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print("실패 : error : \(error)")
    }
}, receiveValue: { receivedValue in
    print("받은 값 : \(receivedValue)")
})
mySubscription?.store(in: &mySubscriptionSet)
//myDefaultPublisher.sink(receiveCompletion: { completion in
//    switch completion {
//    case .finished:
//        print("완료")
//    case .failure(let error):
//        print("실패 : error : \(error)")
//    }
//}, receiveValue: { receivedValue in
//    print("받은 값 : \(receivedValue)")
//    }).store(in: &mySubscriptionSet)
NotificationCenter.default.post(Notification(name: myNotifiaction))
NotificationCenter.default.post(Notification(name: myNotifiaction))
NotificationCenter.default.post(Notification(name: myNotifiaction))
//mySubscription?.cancel()

//KVO - Key value observing

class MyFriend {
    var name = "철수" {
        didSet {
            print("name - didSet : ", name)
        }
    }
}
var myFriend = MyFriend()
var myFriendSubscription: AnyCancellable = ["영수"].publisher.assign(to: \.name, on: myFriend)
