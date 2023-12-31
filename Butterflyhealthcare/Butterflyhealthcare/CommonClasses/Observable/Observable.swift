//
//  Observable.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.


import Foundation

//Observable
class Observable<T> {
    var value : T?
    {
        didSet{
            listener?(value)
        }
    }
    init(_ value: T?){
        self.value = value
    }
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener:@escaping (T?) -> Void){
        listener(value)
        self.listener = listener
    }
}
